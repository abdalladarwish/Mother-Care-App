import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import '../../services/fetch_video.dart';
import 'custom_video_controls.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class VideoScreen extends StatefulWidget {
  final String videoId;

  VideoScreen(this.videoId);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  bool showLoading = true;

  // video without webview
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool isPureVideoInit = false;
  bool errorPureVideo =false;

  // video with webview
  InAppWebViewController? inAppWebViewController;
  bool isWebVideoInit = false;

  Future<void> initializePlayer(String? videoUrl) async {
    if(videoUrl == null){
      _tryWebView();
    }else{
      try {
        _videoPlayerController = VideoPlayerController.network(videoUrl);
        await _videoPlayerController?.initialize();
        _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController!,
            autoPlay: true,
            customControls: CustomVideoControls(),
            materialProgressColors: ChewieProgressColors(
              playedColor: Colors.red,
              handleColor: Colors.red,
              bufferedColor: Colors.white,
            ));
        setState(() {
          showLoading = false;
          isPureVideoInit = true;
          errorPureVideo = false;
          isWebVideoInit = false;
        });
      } catch (e) {
        _tryWebView();
      }
    }

  }

  _tryWebView(){
    setState(() {
      isPureVideoInit = false;
      errorPureVideo = true;
      isWebVideoInit = true;
    });
  }
  @override
  void initState() {
    fetchVideoInfo(widget.videoId).then((videoUrl) => initializePlayer(videoUrl));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.primaryColor,
            size: 20,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Colors.black,
        width: size.width,
        child: Stack(
          children: [
            if (isPureVideoInit || isWebVideoInit)
              Center(
                child: Container(
                  height: size.height * 0.3,
                  child: _buildPlayer(),
                ),
              )
            else if(errorPureVideo && !isWebVideoInit)
              Container(
                color: Colors.grey.shade200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          child: Text(
                            "Error in Loading video, please check internet connection",
                            style: TextStyle(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.error,
                          color: Colors.red,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isWebVideoInit = true;
                                showLoading = true;
                              });
                            },
                            child: Row(
                              children: [Text("Refresh"), Icon(Icons.refresh)],
                            )),
                        Expanded(child: Container())
                      ],
                    )
                  ],
                ),
              ),
            if (showLoading)
              Container(
                color: Colors.black,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildPlayer() {
    if (!errorPureVideo) {
      return Container(
        child: Chewie(
          controller: _chewieController!,
        ),
      );
    } else if(errorPureVideo && isWebVideoInit) {
      String html =  ''' <!DOCTYPE html>
                     <html lang="en">
                     <style>
                      iframe {
                          position: absolute;
                          top: 0; 
                          left: 0;
                          width: 100%;
                          height: 100%;
                      }
                     </style>
                     <body> 
                     <div id="player"></div>
                     <script>
                     var tag = document.createElement('script');
                      tag.src = "https://www.youtube.com/iframe_api";
                      var firstScriptTag = document.getElementsByTagName('script')[0];
                      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
                      var player;
                      var onError = function(event) {
                         console.log("VideoError");  // channel handle error
                      }
                      
                      function onYouTubeIframeAPIReady() {
                          player = new YT.Player('player', {
                              videoId: '${widget.videoId}',
                              enablejsapi:1,
                              controls:1,
                              fs: 1,
                              events: {
                                  onReady: function (event) {
                                      event.target.playVideo();
                                  },
                                  onError: onError
                              }
                          });
                      }
                     </script>
                    </body>
    </html>
    ''';
      return InAppWebView(
        initialData: InAppWebViewInitialData(data: html),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            mediaPlaybackRequiresUserGesture: false,
          ),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          inAppWebViewController = controller;
        },
        onLoadStop: (InAppWebViewController controller, Uri? uri){
          setState(() {
            showLoading = false;
          });
        },
        onLoadError: (controller, url, code, message) {
          setState(() {
            isWebVideoInit = false;
            showLoading = false;
          });
        },
        onConsoleMessage: (InAppWebViewController controller, ConsoleMessage consoleMessage) {
          if (consoleMessage.message == "VideoError") {
            setState(() {
              showLoading = false;
              isWebVideoInit = false;
            });
          }
        },
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}