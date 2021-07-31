import 'package:flutter/material.dart';
import 'models/gui_model/tab.dart';

class NavigatorKeys {
  static final rootNavigationKey = GlobalKey<NavigatorState>();
  static final tabNavigatorKeys = {
    TabType.TIMELINE: GlobalKey<NavigatorState>(),
    TabType.HEALTH: GlobalKey<NavigatorState>(),
    TabType.RESOURCES: GlobalKey<NavigatorState>(),
    TabType.PROFILE: GlobalKey<NavigatorState>(),
  };
}
