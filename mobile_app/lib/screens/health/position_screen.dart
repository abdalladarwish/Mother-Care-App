import 'dart:math';

import 'package:flutter/material.dart';
import '../../services/sensor_data_provider.dart';
import '../../widgets/build_appbar.dart';
import 'package:provider/provider.dart';

class PositionScreen extends StatelessWidget {
  static final route = 'position-screen';

  PositionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int deviceIndex = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: buildAppBar(context, "Baby Position"),
      body: Consumer<SensorDataProvider>(
        builder: (context, sensorDataProvider, child) {
          return Container(
            margin: EdgeInsets.all(8),
            child: Center(child: _buildPositionImage(sensorDataProvider, deviceIndex, context)),
          );
        },
      ),
    );
  }

  Widget _buildPositionImage(SensorDataProvider sensorDataProvider, int deviceIndex, BuildContext context) {
    if (sensorDataProvider.sensorsData[deviceIndex].isNotEmpty &&
        sensorDataProvider.sensorsData[deviceIndex].last.positionRead != 'Undefined') {
      return Image.asset(
        "assets/images/${sensorDataProvider.sensorsData[deviceIndex].last.positionRead}_image.jpg",
        frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return child;
          }
          return AnimatedOpacity(
            child: child,
            opacity: frame == null ? 0 : 1,
            duration: const Duration(seconds: 2),
            curve: Curves.easeOut,
          );
        },
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: LinearProgressIndicator(),
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          Text("Getting Correct Position"),
        ],
      );
    }
  }
}
