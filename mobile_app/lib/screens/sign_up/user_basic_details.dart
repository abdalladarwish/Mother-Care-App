import 'package:flutter/material.dart';
import '../../services/sign_up_provider.dart';
import '../../widgets/build_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class UserBasicDetails extends StatefulWidget {
  UserBasicDetails({Key? key}) : super(key: key);

  @override
  _UserBasicDetailsState createState() => _UserBasicDetailsState();
}

class _UserBasicDetailsState extends State<UserBasicDetails> {
  final datetimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
      builder: (context, signUpProvider, _) => Form(
        key: signUpProvider.basicDetailsFromKey,
        child: Column(
          children: <Widget>[
            buildTextFromField(
              label: "First Name",
              onChanged: (val) {
                signUpProvider.user.firstName = val;
              },
              validator: (val) {
                if (val?.isEmpty ?? true) {
                  return "You must enter your first name";
                }
                return null;
              },
            ),
            buildTextFromField(
              label: "Last Name",
              onChanged: (val) {
                signUpProvider.user.lastName = val;
              },
              validator: (val) {
                if (val?.isEmpty ?? true) {
                  return "You must enter your last name";
                }
                return null;
              },
            ),
            buildTextFromField(
                label: "Username",
                onChanged: (val) {
                  signUpProvider.user.userName = val;
                },
                validator: (val) {
                  if (val?.isEmpty ?? true) {
                    return "You must enter your username";
                  } else if (signUpProvider.signUpStatus == SignUpStatus.SIGNING_UP &&
                      !signUpProvider.userNameValidated) {
                    return "username already exist";
                  }
                  return null;
                }),
            buildTextFromField(
              label: "Date of Birth",
              controller: datetimeController,
              hint: "yyyy-mm-dd",
              keyboardType: TextInputType.datetime,
              onChanged: (val) {
                try{
                  final datetime = DateFormat("yyyy-MM-dd").parse(val);
                  final formatted = DateFormat("yyyy-MM-dd").format(datetime);
                  signUpProvider.user.birthOfDate = formatted;
                } catch(e){
                  signUpProvider.user.birthOfDate = null;
                }
              },
              validator: (val) {
                if (val?.isEmpty ?? true) {
                  return "You must enter your data of birth";
                } else if(signUpProvider.user.birthOfDate == null){
                  return "You must enter your data in format [yyyy-MM-dd]";
                }
                return null;
              },
              suffixIcon: Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () async{
                    final datetime = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime.now());
                    if (datetime != null){
                      final formattedDate = DateFormat("yyyy-MM-dd").format(datetime);
                      datetimeController.text = formattedDate;
                      signUpProvider.user.birthOfDate = formattedDate;
                    } else {
                      datetimeController.text = "";
                    }
                  },
                  iconSize: 25,
                  splashRadius: 25,
                  icon: Icon(Icons.date_range),
                ),
              ),
            ),
            buildTextFromField(
              label: "Phone Number",
              keyboardType: TextInputType.phone,
              onChanged: (val) {
                signUpProvider.user.phone = val;
              },
              validator: (val) {
                if (val?.isEmpty ?? true) {
                  return "You must enter your phone number";
                }
                return null;
              },
            ),
            buildTextFromField(
              label: "Email",
              keyboardType: TextInputType.emailAddress,
              onChanged: (val) {
                signUpProvider.user.email = val;
              },
              validator: (val) {
                if (val?.isEmpty ?? true) {
                  return "You must enter your email";
                }
                return null;
              },
            ),
            buildTextFromField(
              label: "Password",
              obscureText: true,
              onChanged: (val) {
                signUpProvider.user.password = val;
              },
              validator: (val) {
                if (val?.isEmpty ?? true) {
                  return "You must enter your password";
                }
                return null;
              },
            ),
            buildTextFromField(
              label: "Confirm Password ",
              obscureText: true,
              validator: (val) {
                if (val?.isEmpty ?? true) {
                  return "You must enter your confirmed password";
                } else if (val! != signUpProvider.user.password) {
                  return "password doesn't match";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
