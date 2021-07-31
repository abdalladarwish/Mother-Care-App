import 'package:flutter/material.dart';
import '../services/connection_status.dart';
import 'package:provider/provider.dart';

class VideoWidget extends StatefulWidget {
  final String videoId;
  final VoidCallback onPressed;
  VideoWidget(this.videoId, this.onPressed, {Key? key}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    final videoHeight = MediaQuery.of(context).size.height * 0.25;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      height: videoHeight,
      child: ChangeNotifierProvider(
        create: (_) => ConnectionStatus(),
        child: Consumer<ConnectionStatus>(
          builder: (context, connectionStatus, _) {
            if (connectionStatus.connecting)
              return Container(
                color: Colors.grey.shade200,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Connecting to internet",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      LinearProgressIndicator()
                    ],
                  ),
                ),
              );
            else if (connectionStatus.isConnectedFirstTime) {
              return Container(
                child: _buildClickImage(connectionStatus),
              );
            } else if (!connectionStatus.isConnected) {
              return Container(
                color: Colors.grey.shade200,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No Internet Connection",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildClickImage(ConnectionStatus connectionStatus) {
    return Container(
      child: Image.network(
        'https://img.youtube.com/vi/${widget.videoId}/sddefault.jpg',
        fit: BoxFit.fitWidth,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            if (count == 0) {
              count++;
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Stack(
              children: [
                Container(
                  child: child,
                  width: MediaQuery.of(context).size.width,
                ),
                _buildButton()
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              backgroundColor: Colors.grey,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Stack(
            children: [
              Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width,
              ),
              _buildButton()
            ],
          );
        },
      ),
    );
  }

  Widget _buildButton() {
    return Center(
      child: ElevatedButton(
        child: Icon(
          Icons.play_arrow,
          color: Colors.white,
          size: 30,
        ),
        onPressed: widget.onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        ),
      ),
    );
  }
}
