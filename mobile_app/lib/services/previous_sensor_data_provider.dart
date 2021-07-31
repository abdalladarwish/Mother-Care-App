import 'package:flutter/cupertino.dart';
import '../models/data_model/sensors_data.dart';

enum PreviousSensorDataStatus{GETTING_DATA, HAVE_DATA, NO_STATUS}

class PreviousSensorDateProvider with ChangeNotifier {
  PreviousSensorDataStatus previousSensorDataStatus = PreviousSensorDataStatus.NO_STATUS;
  DateTime? date;
  List<List<SensorsData>> previousSensorsData = [[]];

  getPreviousData(){
    if(date!.day == DateTime.now().day){
      previousSensorDataStatus = PreviousSensorDataStatus.NO_STATUS;
      notifyListeners();
    }else {
      previousSensorDataStatus = PreviousSensorDataStatus.GETTING_DATA;
      notifyListeners();
    }
  }
}