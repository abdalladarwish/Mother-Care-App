import 'package:flutter/material.dart';
import '../screens/health/position_screen.dart';
import '../screens/timeline/timeline_favorites_screen.dart';
import '../screens/health/sensor_collections_screen.dart';
import '../screens/timeline/timeline_resource_screen.dart';
import '../screens/health/temperature_screen.dart';
import '../screens/resources/resource_content_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/health/health_screen.dart';
import '../screens/timeline/timeline_screen.dart';
import '../screens/resources/resource_subsections_screen.dart';
import '../screens/resources/resources_screen.dart';

final Map<String, WidgetBuilder> timelineRoutes = {
  TimelineScreen.route: (context) => TimelineScreen(),
  TimelineResourceScreen.route: (context) => TimelineResourceScreen(),
  TimelineFavoritesScreen.route: (context) => TimelineFavoritesScreen()
};

final Map<String, WidgetBuilder> healthRoutes = {
  HealthScreen.route: (context) => HealthScreen(),
  SensorDataScreen.route: (context) => SensorDataScreen(),
  SensorCollectionScreen.route: (context) => SensorCollectionScreen(),
  PositionScreen.route : (context) => PositionScreen()
};

final Map<String, WidgetBuilder> resourceRoutes = {
  ResourcesScreen.route: (context) => ResourcesScreen(),
  ResourceSubsectionsScreen.route: (context) => ResourceSubsectionsScreen(),
  ResourceContentScreen.route : (context) => ResourceContentScreen()
};

final Map<String, WidgetBuilder> profileRoutes = {
  ProfileScreen.route: (context) => ProfileScreen()
};
