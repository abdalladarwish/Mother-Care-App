class Device {
  int? deviceId;
  String? babyName;
  // Device();
  Device(this.deviceId, this.babyName);

  Map toJson(){
    Map<String, dynamic> map = Map();
    map["deviceId"] = deviceId;
    map["babyName"] = babyName;
    return map;
  }
}