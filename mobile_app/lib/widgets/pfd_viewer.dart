import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class PDFViewerWidget extends StatefulWidget {
  final String url;

  const PDFViewerWidget({required this.url, Key? key}) : super(key: key);

  @override
  _PDFViewerWidgetState createState() => _PDFViewerWidgetState();
}

class _PDFViewerWidgetState extends State<PDFViewerWidget> {
  late PDFDocument document;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  _loadPdf() async {
    document = await PDFDocument.fromAsset(widget.url);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 250,
      decoration: BoxDecoration(border: Border.all()),
      margin: EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Container(
            child: Text(
              "double click to zoom",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(1.0), color: Colors.black54),
          ),
          Expanded(
            child: Center(
              child: isLoading
                  ? CircularProgressIndicator()
                  : PDFViewer(document: document, showIndicator: false),
            ),
          ),
        ],
      ),
    );
  }
}
