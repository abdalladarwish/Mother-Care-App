import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Map<String, WidgetBuilder> routes;
  final String initialRoute;

  TabNavigator(
      {required this.navigatorKey,
      required this.initialRoute,
      required this.routes});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: initialRoute,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routes[routeSettings.name]!(context),
          settings: routeSettings
        );
      },
    );
  }
}
