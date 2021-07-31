import 'package:flutter/material.dart';
import '../navigator_keys.dart';
import 'sign_up/login_screen.dart';
import 'sign_up/sign_up_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: size.height / 3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/welcome.png"),
                    ),
                  ),
                ),
                SizedBox(height: 100,),
                Column(
                  children: [
                    MaterialButton(
                      height: 60,
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black), borderRadius: BorderRadius.circular(50)),
                      onPressed: () {
                        NavigatorKeys.rootNavigationKey.currentState?.pushNamed(LoginScreen.route);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 20),
                    MaterialButton(
                      height: 60,
                      minWidth: double.infinity,
                      color: Color(0xFF1187D2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      onPressed: () {
                        NavigatorKeys.rootNavigationKey.currentState?.pushNamed(SignUpScreen.route);
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
