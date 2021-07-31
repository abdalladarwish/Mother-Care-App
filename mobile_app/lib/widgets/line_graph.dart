import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../models/data_model/sensors_data.dart';
import '../services/general_notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
class LineGraph extends StatelessWidget {
  final List<SensorsData> data;
  final String mapKey;
  final isLive;
  final List<charts.Series<SensorsData, int>> dataSeries = [];

  LineGraph(this.data, {required this.mapKey, this.isLive = false}) {
    dataSeries.add(
      charts.Series(
        id: "Date",
        data: data,
        domainFn: (datum, index) => index!,
        measureFn: (datum, index) => datum.data[mapKey]!.value,
      )..setAttribute(charts.measureAxisIdKey, 'secondaryMeasureAxisId'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralNotificationProvider>(
      builder: (context, generalNotificationProvider, child) {
        return Column(
          children: [
            if (isLive && generalNotificationProvider.isDeviceConnected)
              Container(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("Live",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
                ),
              )
            else if (isLive && !generalNotificationProvider.isDeviceConnected)
              Container(
                color: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("Device not Connected",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ),
            Expanded(
              child: data.isNotEmpty ? charts.LineChart(
                dataSeries,
                animate: true,
                domainAxis: charts.NumericAxisSpec(
                  tickFormatterSpec: charts.BasicNumericTickFormatterSpec((indexNum){
                    if(indexNum != null){
                      int index = indexNum.toInt();
                      if(index >= 0 && index < data.length){
                        return DateFormat.Hms().format(data[index].data[mapKey]!.time.add(Duration(hours: 2)));
                      }else{
                        return DateFormat.Hms().format(data.last.data[mapKey]!.time.add(Duration(hours: index - data.length + 3)));
                      }
                    }
                    return '';
                  }),
                  viewport: charts.NumericExtents(
                    data.length - 20, isLive? data.length + 3: data.length -1
                  )
                ),
                behaviors: [
                  charts.SlidingViewport(),
                  charts.PanAndZoomBehavior(),
                ],
              ): Container(),
            )
          ],
        );
      },
    );
  }
}
