import 'package:flutter/material.dart';
import 'build_save_button.dart';
import 'custom_textfields.dart';

class AboutMeWidget extends StatelessWidget {
  const AboutMeWidget({Key? key}) : super(key: key);
  final saving = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          buildCustomTextField(title: "First Name", initialVal: "Abdullah"),
          buildCustomTextField(title: "Last Name", initialVal: "Mohamed"),
          buildCustomTextField(title: "Username", initialVal: "abdullahmohamed", isEditable: false),
          buildCustomTextField(title: "Phone", initialVal: "01019141965"),
          DateOfBirthTextField(title: "Date of birth", initialVal: "1990-03-02"),
          buildCustomTextField(title: "Sex", initialVal: "male"),
          buildCustomTextField(title: "Email", initialVal: "aa@exampl.com", isEditable: false),
          Row(
            children: [
              buildSaveButton(false, (){})
            ],
          ),
        ],
      ),
    );
  }
}
