import 'dart:convert';
import 'dart:io';

Map<String, Object> splitQueryString(String query) {
  return query.split('&').fold({}, (map, element) {
    final index = element.indexOf("=");
    if (index == -1) {
      if (element != "") {
        map[element] = "";
      }
    } else if (index != 0) {
      var key = element.substring(0, index);
      var value = element.substring(index + 1);
      map[key] = value;
    }
    return map;
  });
}

Future<Map<String, dynamic>> fetch(String videoId) async {
  final url = "https://www.youtube.com/get_video_info?video_id=${videoId}&html5=1&c=TVHTML5&cver=6.20180913";
  // mobile
  var request = await HttpClient().getUrl(Uri.parse(url));
  var response = await request.close();
  var content = '';
  await for (var s in response.transform(utf8.decoder)) {
    content += s;
  }
  // web
  // var request = await html.HttpRequest.getString(url);
  // var content = request;

  content = Uri.decodeFull(content);
  var query = splitQueryString(content);
  Map<String, dynamic> jsonQuery = json.decode(query["player_response"] as String);
  // jsonQuery.forEach((key, value) {
  //   print(key);
  // });
  // print('---------------');
  Map<String, dynamic> streamingData = jsonQuery['streamingData'];
  // streamingData.forEach((key, value) {
  //   print(key);
  // });
  // print('---------------');

  List<dynamic> formats = streamingData['formats'] as List<dynamic>;
  Map<String, dynamic> video = formats[0];
  return video;
  // video.forEach((key, value) {
  //   print(key);
  // });
  // print('---------------');
  // formats.forEach((element) {
  //   print(element['url']);
  //   print(element['quality']);
  // });
}

Future<String?> fetchVideoInfo(String videoId) async {
  try {
    var video = await fetch(videoId);
    if (video['url'] != null) {
      return video['url'] as String;
    }
    return null;
  } catch (e) {
    return null;
  }
}
