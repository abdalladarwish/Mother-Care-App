import 'package:flutter/material.dart';
import 'screens/sign_up/login_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'screens/welcome_screen.dart';
import 'navigator_keys.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My baby',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff2d74a3),
        canvasColor: Colors.white,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          unselectedItemColor: Color(0xff193a9b),
          selectedItemColor: Theme.of(context).primaryColor,
        ),
      ),
      navigatorKey: NavigatorKeys.rootNavigationKey,
      initialRoute: '/',
      routes: {
        '/': (ctx) => WelcomeScreen(),
        SignUpScreen.route: (ctx) => SignUpScreen(),
        LoginScreen.route: (ctx) => LoginScreen(),
        HomeScreen.route : (ctx) => HomeScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => WelcomeScreen(),
        );
      },
    );
  }
}
