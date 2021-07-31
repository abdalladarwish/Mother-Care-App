import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/timeline_data_provider.dart';
import '../../services/timeline_favorite_data_provider.dart';
import 'package:provider/provider.dart';
import '../../models/gui_model/tab.dart';
import 'timeline_resource_screen.dart';
import '../../models/data_model/blog.dart';
import '../../navigator_keys.dart';

class TimelineFavoriteCard extends StatelessWidget {
  final int blogIndex;

  const TimelineFavoriteCard({required this.blogIndex, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xff237eba);
    final textStyle = TextStyle(fontWeight: FontWeight.bold, color: primaryColor);
    return Consumer2<TimelineDataProvider, TimelineFavoriteDataProvider>(
        builder: (context, timelineDateProvider, timelineFavoriteDataProvider, child) {
      final Blog blogData = timelineFavoriteDataProvider.blogs[blogIndex];
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              padding: EdgeInsets.only(left: 8, right: 8, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    blogData.categories!.join(', '),
                    style: textStyle,
                  ),
                  Text(
                    DateFormat.yMMMMd('en_US').format(DateTime.parse(blogData.datetime!)),
                    style: textStyle,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                blogData.title!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: _buildImageFromBase64(blogData.coverImage!.picBytes!),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              margin: EdgeInsets.only(bottom: 4),
              child: Text(blogData.description!),
            ),
            Divider(
              height: 1,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      NavigatorKeys.tabNavigatorKeys[TabType.TIMELINE]!.currentState
                          ?.pushNamed(TimelineResourceScreen.route, arguments: blogData);
                    },
                    child: Text(
                      "Expand",
                      style: textStyle,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          final result = await timelineDateProvider.blogDislike(blogData, isNotifyListeners: true);
                          if (result) {
                            timelineFavoriteDataProvider.removeBlog(blogIndex);
                          }
                        },
                        icon: Icon(
                          Icons.favorite_outlined,
                          color: Colors.red,
                        ),
                        splashRadius: 20,
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      Text("${blogData.blogLikes.length > 0 ? blogData.blogLikes.length : ''}")
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildImageFromBase64(String base64) {
    Uint8List bytes = base64Decode(base64);
    return Image.memory(
      bytes,
      fit: BoxFit.scaleDown,
    );
  }
}
