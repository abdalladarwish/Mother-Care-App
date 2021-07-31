import 'package:flutter/material.dart';
import '../../navigator_keys.dart';
import '../home_screen.dart';
import 'user_login_info.dart';
import '../../services/login_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static final route = 'login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: Consumer<LoginProvider>(
        builder: (context, loginProvider, _) =>  Scaffold(
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
              "Login",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(4),
              child: loginProvider.loginStatus == LoginStatus.LOGGING_IN ? LinearProgressIndicator(): Container(),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 150,),
                  UserLoginInfo(),
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
                        if(loginProvider.loginFromKey.currentState?.validate() ?? false){
                          final status = await loginProvider.login();
                          if(status){
                            while(await NavigatorKeys.rootNavigationKey.currentState?.maybePop() ?? false)
                              NavigatorKeys.rootNavigationKey.currentState?.pop();
                            NavigatorKeys.rootNavigationKey.currentState?.pushNamed(HomeScreen.route);
                          }
                        }
                      },
                      color: Color(0xFF1187D2),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Login",
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
