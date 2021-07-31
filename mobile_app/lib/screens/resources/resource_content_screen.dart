import 'package:flutter/material.dart';
import '../../widgets/pfd_viewer.dart';
import '../video_player/video_screen.dart';
import '../../navigator_keys.dart';
import '../../widgets/html_widget.dart';
import '../../widgets/build_appbar.dart';
import '../../widgets/video_widget.dart';
import '../../models/data_model/resource.dart';

class ResourceContentScreen extends StatelessWidget {
  static const route = '/resourceContent';

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> args = ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final title = args['title'];
    final List contents = args['content'] as List;
    return Scaffold(
      appBar: buildAppBar(context, title),
      body: ListView.builder(
        itemCount: contents.length,
        itemBuilder: (ctx, index) {
          final content = contents[index];
          if (content is String) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Text(content, textAlign: TextAlign.justify),
            );
          } else if (content is HtmlData) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: HtmlWidget(content),
            );
          } else if (content is ImageContent) {
            return Container(
              child: Image.asset(content.imgUrl, fit: BoxFit.scaleDown),
            );
          } else if (content is VideoContent) {
            return VideoWidget(
              content.videoId,
              () {
                NavigatorKeys.rootNavigationKey.currentState
                    ?.push(MaterialPageRoute(builder: (_) => VideoScreen(content.videoId)));
              },
              key: ValueKey(content.videoId),
            );
          } else if(content is PDFContent){
            return PDFViewerWidget(url: content.pdfUrl);
          }else {
            return Container();
          }
        },
        padding: EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
}
