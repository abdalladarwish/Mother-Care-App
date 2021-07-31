import 'package:flutter/material.dart';
import 'package:my_baby/services/sensor_data_provider.dart';
import 'package:provider/provider.dart';
import '../../models/gui_model/tab.dart';

import 'tabs_data.dart';

class BottomNavigationItem extends StatelessWidget {
  BottomNavigationItem({required this.currentTab, required this.onSelectTab});

  final TabType currentTab;
  final ValueChanged<TabType> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return Consumer<SensorDataProvider>(
      builder: (context, sensorDataProvider, child){
        return BottomNavigationBar(
          currentIndex: currentTab.index,
          items: [
            _buildItem(TabType.TIMELINE),
            _buildItem(TabType.HEALTH),
            _buildItem(TabType.RESOURCES),
            _buildItem(TabType.PROFILE)
          ],
          onTap: (index) {
            onSelectTab(TabType.values[index]);
            if(TabType.values[index] == TabType.HEALTH){
              sensorDataProvider.getDevices();
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          unselectedItemColor:
          Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          selectedItemColor:
          Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        );
      }
    );
  }

  BottomNavigationBarItem _buildItem(TabType tabItem) {
    return BottomNavigationBarItem(
      icon: tabs[tabItem]!.icon,
      label: tabs[tabItem]!.name,
    );
  }
}
