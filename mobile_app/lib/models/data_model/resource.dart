class Section {
  final String title;
  final List<Subsection> subsections;

  Section(this.title, this.subsections);
}

class Subsection {
  final String title;
  final List<Object> content;

  Subsection(this.title, this.content);
}



class HtmlData {
  final String text;
  final String styles;
  HtmlData(this.text, {this.styles = ""});
}

class ImageContent {
  final String imgUrl;
  
  ImageContent(this.imgUrl);
}

class BulletListContent {
  final Object title;
  final List<Object> items;

  BulletListContent(this.title, this.items);
}

class VideoContent {
  final String videoId;

  VideoContent(this.videoId);
}

class PDFContent{
  final String pdfUrl;
  PDFContent(this.pdfUrl);
}
