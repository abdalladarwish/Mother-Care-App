import 'package:flutter/material.dart';

enum TabType { TIMELINE, HEALTH, RESOURCES, PROFILE }

class TabItem {
  final String name;
  final Icon icon;
  final Map<String, WidgetBuilder> routes;
  final String initialRoute;

  TabItem({required this.name, required this.icon, required this.routes, required this.initialRoute});
}
