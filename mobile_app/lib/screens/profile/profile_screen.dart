import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../../navigator_keys.dart';
import '../welcome_screen.dart';
import 'about_me_widget.dart';
import 'health_data_widget.dart';
import '../../widgets/build_appbar.dart';

class ProfileScreen extends StatefulWidget {
  static const route = '/';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<bool> isExpandedList = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        "Profile",
        actions: [
          IconButton(
            onPressed: () {
              while(NavigatorKeys.rootNavigationKey.currentState?.canPop() ?? false){
                NavigatorKeys.rootNavigationKey.currentState?.pop();
              }
              NavigatorKeys.tabNavigatorKeys.forEach((key, value) {
                while(NavigatorKeys.tabNavigatorKeys[key]!.currentState?.canPop() ?? false){
                  NavigatorKeys.tabNavigatorKeys[key]!.currentState?.pop();
                }
              });
              NavigatorKeys.rootNavigationKey.currentState?.push(
                MaterialPageRoute(
                  builder: (context) => WelcomeScreen(),
                )
              );
            },
            icon: Icon(Icons.logout),
            color: Colors.red,
            splashRadius: 20,
          ),
        ],
      ),
      body: ListView(
        children: [
          ExpansionPanelList(
            children: [
              ExpansionPanel(
                headerBuilder: (context, isExpanded) => _buildHeader("About Me"),
                body: AboutMeWidget(),
                isExpanded: isExpandedList[0],
              ),
              ExpansionPanel(
                  headerBuilder: (context, isExpanded) => _buildHeader("Health Data"),
                  body: HealthDataWidget(),
                  isExpanded: isExpandedList[1])
            ],
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                isExpandedList[panelIndex] = !isExpandedList[panelIndex];
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Center(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).primaryColor.withAlpha(230)),
            ),
          ),
        ],
      ),
    );
  }
}
