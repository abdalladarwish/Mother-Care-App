class BlogCoverImage{
  String? name;
  String? type;
  String? picBytes;

  BlogCoverImage.formJson(Map<String, dynamic> jsonData){
    name = jsonData['name'];
    type = jsonData['type'];
    picBytes = jsonData['picByte'];
  }
}