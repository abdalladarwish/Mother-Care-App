import 'package:flutter/material.dart';
import 'build_save_button.dart';
import 'custom_textfields.dart';

class HealthDataWidget extends StatelessWidget {
  const HealthDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          buildCustomTextField(title: "Blood Type", initialVal: "A"),
          buildCustomTextField(title: "Height", initialVal: "160 cm"),
          buildCustomTextField(title: "Weight", initialVal: "90 kg"),
          buildCustomTextField(title: "Status", initialVal: "Pregnant"),
          DateOfBirthTextField(title: "Pregnant Since", initialVal: "2021-06-21"),
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
