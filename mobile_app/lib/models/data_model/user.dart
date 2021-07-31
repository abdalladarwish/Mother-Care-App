
class User {
  String? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? phone;
  String? email;
  String? password;
  String? gender;
  String? birthOfDate;
  bool? isMarried;
  bool? isPregnant;
  double? height;
  double? weight;

  User();

  User.fromJson(Map<String, dynamic> map) {
    id = map["id"];
    firstName = map["firstName"];
    lastName = map["lastName"];
    userName = map["userName"];
    phone = map["phone"];
  }

  Map<String, dynamic> toJson(){
    final map = Map<String, dynamic>();
    map["id"] = id;
    map["firstName"] = firstName;
    map["lastName"] = lastName;
    map["username"] = userName;
    map["password"] = password;
    map["phone"] = phone;
    map["birthOfDate"] = birthOfDate;
    map["email"] = email;
    return map;
  }

}
