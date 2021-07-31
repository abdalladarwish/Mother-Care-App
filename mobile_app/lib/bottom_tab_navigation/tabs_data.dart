import 'package:flutter/material.dart';
import '../../models/gui_model/tab.dart';

import '../screens/health/health_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/timeline/timeline_screen.dart';
import '../screens/resources/resources_screen.dart';
import 'tabs_routes.dart';

final Map<TabType, TabItem> tabs = {
  TabType.TIMELINE: TabItem(
      name: "Timeline",
      icon: Icon(Icons.view_list),
      routes: timelineRoutes,
      initialRoute: TimelineScreen.route
  ),
  TabType.HEALTH: TabItem(
      name: "Health",
      icon: Icon(Icons.favorite),
      routes: healthRoutes,
      initialRoute: HealthScreen.route
  ),
  TabType.RESOURCES: TabItem(
      name: "Resources",
      icon: Icon(Icons.folder),
      routes: resourceRoutes,
      initialRoute: ResourcesScreen.route
  ),
  TabType.PROFILE: TabItem(
    name: "Profile",
    icon:  Icon(Icons.person),
    routes:  profileRoutes,
    initialRoute: ProfileScreen.route
  )
};

