import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/previous_sensor_data_provider.dart';
import '../../services/sensor_data_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/line_graph.dart';
import '../../widgets/build_appbar.dart';

class SensorDataScreen extends StatelessWidget {
  static const route = 'temperature';

  SensorDataScreen();

  @override
  Widget build(BuildContext context) {
    final Map<String, Object?> args = ModalRoute.of(context)!.settings.arguments as Map<String, Object?>;
    final int deviceIndex = args['deviceIndex'] as int;
    final String mapKey = args['mapKey'] as String;
    return ChangeNotifierProvider<PreviousSensorDateProvider>(
      create: (_) => PreviousSensorDateProvider(),
      child: Consumer<PreviousSensorDateProvider>(
        builder: (context, previousSensorDataProvider, child) {
          return Scaffold(
            appBar: buildAppBar(context, args["title"]),
            body: Consumer<SensorDataProvider>(
              builder: (context, sensorDataProvider, child) {
                return Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.chevron_left),
                              onPressed: () {
                                if (previousSensorDataProvider.date == null) {
                                  previousSensorDataProvider.date =
                                      sensorDataProvider.dayDate.subtract(Duration(days: 1));
                                } else {
                                  previousSensorDataProvider.date =
                                      previousSensorDataProvider.date!.subtract(Duration(days: 1));
                                }
                                previousSensorDataProvider.getPreviousData();
                              },
                              splashRadius: 25,
                              iconSize: 25,
                            ),
                            Text(
                              _dataToString(previousSensorDataProvider.previousSensorDataStatus ==
                                      PreviousSensorDataStatus.NO_STATUS
                                  ? sensorDataProvider.dayDate
                                  : previousSensorDataProvider.date!),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: Icon(Icons.chevron_right),
                              onPressed: previousSensorDataProvider.previousSensorDataStatus ==
                                      PreviousSensorDataStatus.NO_STATUS
                                  ? null
                                  : () {
                                      previousSensorDataProvider.date =
                                          previousSensorDataProvider.date!.add(Duration(days: 1));
                                      previousSensorDataProvider.getPreviousData();
                                    },
                              iconSize: 25,
                              splashRadius: 25,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: previousSensorDataProvider.previousSensorDataStatus ==
                            PreviousSensorDataStatus.NO_STATUS ?Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LineGraph(sensorDataProvider.sensorsData[deviceIndex],mapKey: mapKey, isLive: true)
                        ) : previousSensorDataProvider.previousSensorDataStatus ==
                            PreviousSensorDataStatus.HAVE_DATA ?  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: LineGraph(previousSensorDataProvider.previousSensorsData[deviceIndex], mapKey: mapKey,),
                            ): Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  String _dataToString(DateTime date) {
    return DateFormat.yMMMMd('en_US').format(date);
  }
}
