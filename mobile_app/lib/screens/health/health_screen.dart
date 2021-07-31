import 'package:flutter/material.dart';
import '../../models/data_model/device.dart';
import 'devices_screen.dart';
import '../../services/sensor_data_provider.dart';
import '../../widgets/build_text_form_field.dart';
import '../../widgets/connecting_to_internet_widget.dart';
import '../../widgets/no_internet_connection_widget.dart';
import '../../services/connection_status.dart';
import 'package:provider/provider.dart';
import '../../widgets/build_appbar.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({Key? key}) : super(key: key);
  static final route = '/';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ConnectionStatus(),
      builder: (context, _) => Consumer2<ConnectionStatus, SensorDataProvider>(
        builder: (context, connectionStatus, sensorDataProvider, child) {
          return Scaffold(
            appBar: buildAppBar(context, "Health"),
            body: _build(connectionStatus),
            floatingActionButton: connectionStatus.isConnected &&
                    sensorDataProvider.sensorDataStatus == SensorDataStatus.HAVE_DEVICES
                ? FloatingActionButton(
                    onPressed: () {
                      _showAddDeviceDialog(context, sensorDataProvider);
                    },
                    child: Icon(Icons.add),
                  )
                : null,
          );
        },
      ),
    );
  }

  Widget _build(ConnectionStatus connectionStatus) {
    if (connectionStatus.connecting) {
      return ConnectingToInternetWidget();
    } else if (!connectionStatus.isConnected) {
      return NoInternetConnectionWidget();
    } else {
      return DevicesScreen();
    }
  }

  _showAddDeviceDialog(BuildContext context, SensorDataProvider sensorDataProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return AddDeviceWidget(sensorDataProvider: sensorDataProvider);
      },
    );
  }
}

class AddDeviceWidget extends StatefulWidget {
  final SensorDataProvider sensorDataProvider;

  AddDeviceWidget({required this.sensorDataProvider, Key? key}) : super(key: key);

  @override
  _AddDeviceWidgetState createState() => _AddDeviceWidgetState();
}

class _AddDeviceWidgetState extends State<AddDeviceWidget> {
  final device = Device(null, null);
  final formKey = GlobalKey<FormState>();
  bool isAddingDevice = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      content: Form(
        key: formKey,
        child: Container(
          height: 220,
          child: Column(
            children: [
              if (isAddingDevice) LinearProgressIndicator(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    buildTextFromField(
                        label: "Your Child Name",
                        onChanged: (val) => device.babyName = val,
                        validator: (val) {
                          return val?.isNotEmpty ?? false ? null : "Enter your child name";
                        }),
                    SizedBox(
                      height: 5,
                    ),
                    buildTextFromField(
                        label: "Your Device Id",
                        onChanged: (val) {
                          try{
                            device.deviceId = int.parse(val);
                          } catch(e){
                            device.deviceId = 0;
                          }

                        } ,
                        validator: (val) {
                          return val?.isNotEmpty ?? false ? null : "Enter your device id";
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState?.validate() ?? false) {
              setState(() {
                isAddingDevice = true;
              });
              final result = await widget.sensorDataProvider.addDevice(device);
              if (result) {
                Navigator.of(context).pop();
              } else {
                setState(() {
                  isAddingDevice = false;
                });
              }
            }
          },
          child: Text("Add"),
          style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        )
      ],
    );
  }
}
