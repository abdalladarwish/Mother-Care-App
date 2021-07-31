import 'package:flutter/material.dart';
import 'sensor_collections_screen.dart';
import '../../models/data_model/device.dart';
import '../../models/gui_model/tab.dart';
import '../../services/sensor_data_provider.dart';
import 'package:provider/provider.dart';

import '../../navigator_keys.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SensorDataProvider>(
      builder: (context, sensorDataProvider, _) {
        if (sensorDataProvider.sensorDataStatus == SensorDataStatus.GETTING_CONNECTED_DEVICES) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (sensorDataProvider.devices.isEmpty) {
            return Center(
              child: Text(
                "No Devices Add Yet!",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => _buildDeviceWidget(sensorDataProvider.devices[index], index),
              itemCount: sensorDataProvider.devices.length,
            );
          }
        }
      },
    );
  }

  Widget _buildDeviceWidget(Device device, int deviceIndex) {
    return ListTile(
      title: Text(device.babyName ?? ""),
      subtitle: Text(device.deviceId?.toString() ?? ""),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
      onTap: () {
        NavigatorKeys.tabNavigatorKeys[TabType.HEALTH]!.currentState
            ?.pushNamed(SensorCollectionScreen.route, arguments: {"deviceIndex": deviceIndex});
      },
    );
  }
}
