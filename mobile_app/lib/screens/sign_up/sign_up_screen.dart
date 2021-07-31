import 'package:flutter/material.dart';
import '../../navigator_keys.dart';
import 'login_screen.dart';
import 'user_basic_details.dart';
import '../../services/sign_up_provider.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  static final route = 'signup';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpProvider(),
      child: Consumer<SignUpProvider>(
        builder: (context, signUpProvider, _) =>  Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 70,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                NavigatorKeys.rootNavigationKey.currentState?.pop();
              },
              iconSize: 25,
              splashRadius: 25,
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            title: Text(
              "Sign up",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(4),
              child: signUpProvider.signUpStatus == SignUpStatus.SIGNING_UP ? LinearProgressIndicator(): Container(),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  UserBasicDetails(),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.only(top: 3, left: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                        )),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () async {
                        if(signUpProvider.basicDetailsFromKey.currentState?.validate() ?? false){
                          final status = await signUpProvider.signUp();
                          if(status){
                            NavigatorKeys.rootNavigationKey.currentState?.popAndPushNamed(LoginScreen.route);
                          }
                        }
                      },
                      color: Color(0xFF1187D2),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
