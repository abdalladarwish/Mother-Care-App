import 'package:flutter/material.dart';

class ConnectingToInternetWidget extends StatelessWidget {
  const ConnectingToInternetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/WIFI-Icon.gif"),
          Text(
            "Connecting To Internet",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
