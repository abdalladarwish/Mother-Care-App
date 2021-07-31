import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/data_model/blog.dart';
import 'package:http/http.dart' as http;

import 'global_data.dart';

enum FavoriteDataStatus { GETTING_DATA, HAVE_DATA }

class TimelineFavoriteDataProvider with ChangeNotifier {
  FavoriteDataStatus favoriteDataStatus = FavoriteDataStatus.GETTING_DATA;

  List<Blog> blogs = [];

  TimelineFavoriteDataProvider() {
    _getFavoritesBlogs();
  }

  _getFavoritesBlogs() async {
    final response = await http.get(
      Uri.parse('$baseUrl/blog/liked'),
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
      favoriteDataStatus = FavoriteDataStatus.HAVE_DATA;
      notifyListeners();
    }
  }

  bool removeBlog(int blogIndex) {
    blogs.removeAt(blogIndex);
    notifyListeners();
    return true;
  }
}
