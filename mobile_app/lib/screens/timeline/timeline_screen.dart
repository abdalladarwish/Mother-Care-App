import 'package:flutter/material.dart';
import 'timeline_favorites_screen.dart';
import '../../models/gui_model/tab.dart';
import 'timeline_card.dart';
import '../../services/timeline_data_provider.dart';
import 'package:provider/provider.dart';
import '../../navigator_keys.dart';
import '../../widgets/build_appbar.dart';


class TimelineScreen extends StatefulWidget {
  static const route = '/';

  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: buildAppBar(context, "Timeline", actions: [
        PopupMenuButton<String>(
          icon: Icon(Icons.adaptive.more, color: Colors.black,),
          itemBuilder: (context) => [
           PopupMenuItem(child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
               Text("Favorites"),
               Icon(Icons.favorite, color: Colors.red,)
             ],
           ),value: "_",)
          ],
          onSelected: (_){
            NavigatorKeys.tabNavigatorKeys[TabType.TIMELINE]!.currentState?.pushNamed(TimelineFavoritesScreen.route);
          },
        )
      ]),
      body: Consumer<TimelineDataProvider>(
        builder: (context, timelineDataProvider, child){
          if(timelineDataProvider.timelineStatus == TimelineStatus.GETTING_FIRST_BLOGS){
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(timelineDataProvider.timelineStatus == TimelineStatus.HAVE_BLOGS){
            return  ListView.builder(
              itemBuilder: (context, index) => TimeLineCard(blogIndex: index),
              itemCount: timelineDataProvider.blogs.length,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}