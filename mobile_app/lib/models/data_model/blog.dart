import 'blog_cover_image.dart';
import 'blog_like.dart';
import '../../services/global_data.dart';

class Blog{
  int? id;
  String? title;
  String? description;
  List<String>? categories;
  String? htmlText;
  String? datetime;
  BlogCoverImage? coverImage;
  List<BlogLike> blogLikes = [];
  bool isLiked = false;
  Blog();

  Blog.fromJson(Map<String, dynamic> jsonData){
    id = jsonData['id'];
    title = jsonData['title'];
    description = jsonData['description'];
    htmlText = jsonData['html'];
    datetime = jsonData['date'];
    if (jsonData['categories'] is String){
      categories = [jsonData['categories']];
    }else {
      categories = jsonData['categories'];
    }
    coverImage = BlogCoverImage.formJson(jsonData['image']);
    for(var blogLike in jsonData['likes']){
      blogLikes.add(BlogLike.fromJson(blogLike));
      if(blogLikes.last.username == username){
        isLiked = true;
      }
    }
  }
}