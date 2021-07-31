class BlogLike{
  int? likeId;
  String? username;

  BlogLike.fromJson(Map<String, dynamic> jsonData){
    likeId = jsonData['id'];
    username = jsonData['user']['username'];
  }
}