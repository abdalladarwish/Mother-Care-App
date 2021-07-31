import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/data_model/blog_like.dart';
import '../models/data_model/blog.dart';
import 'global_data.dart';
import 'package:http/http.dart' as http;

enum TimelineStatus { GETTING_FIRST_BLOGS, GETTING_MORE_BLOGS, HAVE_BLOGS }

class TimelineDataProvider with ChangeNotifier {
  List<Blog> blogs = [];
  TimelineStatus timelineStatus = TimelineStatus.GETTING_FIRST_BLOGS;

  TimelineDataProvider() {
    _getFirstBlogs();
  }

  _getFirstBlogs() async {
    final response = await http.get(
      Uri.parse('$baseUrl/blog/get/all/all/0'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": 'Bearer ' + token,
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var blog in data) {
        blogs.add(Blog.fromJson(blog));
      }
      timelineStatus = TimelineStatus.HAVE_BLOGS;
      notifyListeners();
    } else {}
    return true;
  }

  Future<bool> blogLike(int blogIndex, {bool isNotifyListeners = false}) async {
    final response = await http.post(
      Uri.parse("$baseUrl/like/${blogs[blogIndex].id}"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": 'Bearer ' + token,
      }
    );
    if(response.statusCode == 200) {
      blogs[blogIndex].isLiked = true;
      blogs[blogIndex].blogLikes.add(BlogLike.fromJson({
        'id': jsonDecode(response.body)['id'],
        'user':{
          'username': username
        }
      }));
      if(isNotifyListeners){
        notifyListeners();
      }

      return true;
    }else{
      return false;
    }

  }

  Future<bool>blogDislike(Blog blog, {bool isNotifyListeners = false}) async{
    int likeIndex = blog.blogLikes.indexWhere((blogLike) => blogLike.username == username);
    if(likeIndex != -1){
      int likeId = blog.blogLikes[likeIndex].likeId!;
      final response = await http.post(
          Uri.parse("$baseUrl/like/delete/$likeId"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": 'Bearer ' + token,
          }
      );
      if(response.statusCode == 200){
        final blogIndex = blogs.indexWhere((b) => b.id == blog.id);
        if(blogIndex !=-1){
          likeIndex = blogs[blogIndex].blogLikes.indexWhere((blogLike) => blogLike.username == username);
          if(likeIndex != -1){
            blogs[blogIndex].blogLikes.removeAt(likeIndex);
          }
          blogs[blogIndex].isLiked = false;
          if(isNotifyListeners){
            notifyListeners();
          }
        }
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
