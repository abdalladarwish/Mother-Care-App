import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/sensor_data_provider.dart';
import '../services/timeline_data_provider.dart';
import '../services/general_notification_provider.dart';
import 'package:provider/provider.dart';
import '../models/gui_model/tab.dart';
import '../navigator_keys.dart';

import '../bottom_tab_navigation/tab_navigator.dart';
import '../bottom_tab_navigation/bottom_navigation_item.dart';
import '../bottom_tab_navigation/tabs_data.dart';

class HomeScreen extends StatefulWidget {
  static final route = 'home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<TabNavigator> navigators;
  late Map<TabType, int> navigatorIndex;

  TabType _currentTab = TabType.RESOURCES;
  TabType? _previousTab;

  @override
  void initState() {
    super.initState();
    navigators = [_buildTabNavigator(_currentTab)];
    navigatorIndex = {_currentTab: 0};

  }


  _selectPreviousTab(TabType tabType) {
    setState(() => _currentTab = tabType);
    _previousTab = null;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SensorDataProvider>(
      create: (_) => SensorDataProvider(),
      child: WillPopScope(
        // handle the android back bottom
        onWillPop: () async {
          final mayBePop = await NavigatorKeys.tabNavigatorKeys[_currentTab]!.currentState?.maybePop();
          if (mayBePop != null) {
            final isFirstRouteInCurrentTab = !mayBePop;
            if (isFirstRouteInCurrentTab && _previousTab != null) {
              _selectPreviousTab(_previousTab!);
              return false;
            } else if (isFirstRouteInCurrentTab && _currentTab != TabType.TIMELINE) {
              _selectPreviousTab(TabType.TIMELINE);
              return false;
            }
            // let system handle back button if we're on the first route
            return isFirstRouteInCurrentTab;
          } else {
            return false;
          }
        },
        child: Consumer<SensorDataProvider>(
          builder: (context, sensorDataProvider, child) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => GeneralNotificationProvider(sensorDataProvider)),
                ChangeNotifierProvider(create: (_) => TimelineDataProvider())
              ],
              builder: (context, child) => Consumer<GeneralNotificationProvider>(
                builder: (context, value, child) => child!,
                child: Scaffold(
                  body: IndexedStack(
                    index: navigatorIndex[_currentTab],
                    children: navigators,
                  ),
                  bottomNavigationBar: BottomNavigationItem(
                    currentTab: _currentTab,
                    onSelectTab: _onSelectTab,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onSelectTab(TabType tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      NavigatorKeys.tabNavigatorKeys[tabItem]!.currentState?.popUntil((route) => route.isFirst);
    } else {
      if (!navigatorIndex.containsKey(tabItem)) {
        navigators.add(_buildTabNavigator(tabItem));
        navigatorIndex[tabItem] = navigators.length - 1;
      }
      _previousTab = _currentTab;
      setState(() => _currentTab = tabItem);
    }
  }

  TabNavigator _buildTabNavigator(TabType tabItem) {
    return TabNavigator(
      navigatorKey: NavigatorKeys.tabNavigatorKeys[tabItem]!,
      initialRoute: tabs[tabItem]!.initialRoute,
      routes: tabs[tabItem]!.routes,
    );
  }
}
