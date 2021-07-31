import 'package:flutter/material.dart';
import '../../services/login_provider.dart';
import '../../widgets/build_text_form_field.dart';
import 'package:provider/provider.dart';

class UserLoginInfo extends StatelessWidget {
  const UserLoginInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, _) => Form(
        key: loginProvider.loginFromKey,
        child: Column(
          children: <Widget>[
            buildTextFromField(
              label: "username",
              onChanged: (val) {
               loginProvider.username = val;
               loginProvider.passwordInCorrect = false;
              },
              validator: (val) {
                if (val?.isEmpty ?? true) {
                  return "You must enter your username";
                }else if(loginProvider.passwordInCorrect){
                  return "username may be incorrect";
                }
                return null;
              },
            ),
            buildTextFromField(
              label: "password",
              obscureText: true,
              onChanged: (val) {
                loginProvider.password = val;
                loginProvider.passwordInCorrect = false;
              },
              validator: (val) {
                if (val?.isEmpty ?? true) {
                  return "You must enter your password";
                } else if(loginProvider.passwordInCorrect){
                  return "password may be incorrect";
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
