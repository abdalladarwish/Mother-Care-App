import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/data_model/blog.dart';
import '../../services/timeline_data_provider.dart';
import 'package:provider/provider.dart';
import '../../models/gui_model/tab.dart';
import '../../navigator_keys.dart';
import 'timeline_resource_screen.dart';

class TimeLineCard extends StatefulWidget {
  final int blogIndex;

  TimeLineCard({required this.blogIndex, Key? key}) : super(key: key);

  @override
  _TimeLineCardState createState() => _TimeLineCardState();
}

class _TimeLineCardState extends State<TimeLineCard> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xff237eba);
    final textStyle = TextStyle(fontWeight: FontWeight.bold, color: primaryColor);
    return Consumer<TimelineDataProvider>(builder: (context, timelineDateProvider, child) {
      final Blog blogData = timelineDateProvider.blogs[widget.blogIndex];
      isLiked = blogData.isLiked;
      return Container(
        decoration: BoxDecoration(
          border: Border.fromBorderSide(BorderSide(color: Colors.black12))
        ),
        margin: EdgeInsets.all(8),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
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
                            bool result = false;
                            if (isLiked) {
                              result = await timelineDateProvider.blogDislike(blogData);
                              if (result) {
                                setState(() {
                                  isLiked = false;
                                });
                              }
                            } else {
                              result = await timelineDateProvider.blogLike(widget.blogIndex);
                              if(result){
                                setState(() {
                                  isLiked = true;
                                });
                              }
                            }
                          },
                          icon: Icon(
                            isLiked ? Icons.favorite_outlined : Icons.favorite_border_outlined,
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
