import 'package:flutter/material.dart';
import 'position_screen.dart';
import '../../widgets/build_appbar.dart';
import '../../models/gui_model/tab.dart';
import 'temperature_screen.dart';
import '../../navigator_keys.dart';

class SensorCollectionScreen extends StatelessWidget {
  SensorCollectionScreen({Key? key}) : super(key: key);

  static final route = 'sensorCollection';

  @override
  Widget build(BuildContext context) {
    final Map<String, int> args = ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    final int deviceIndex = args["deviceIndex"] as int;
    print("SensorCollection: $deviceIndex");
    return Scaffold(
      appBar: buildAppBar(context, "Heath"),
      body: ListView(
        children: [
          _buildSensorReadings(deviceIndex, "tempRead", "Temperature"),
          _buildSensorReadings(deviceIndex, "spo2Read", "SPO2"),
          _buildSensorReadings(deviceIndex, "heartRateRead", "HeartRate"),
          ListTile(
            title: Text(
              "Baby Position",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              NavigatorKeys.tabNavigatorKeys[TabType.HEALTH]!.currentState?.pushNamed(PositionScreen.route, arguments: deviceIndex);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSensorReadings(int deviceIndex, String mapKey, String title){
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
      onTap: () {
        NavigatorKeys.tabNavigatorKeys[TabType.HEALTH]!.currentState?.pushNamed(SensorDataScreen.route, arguments: {"deviceIndex": deviceIndex, "mapKey": mapKey, "title": title});
      },
    );
  }
}
