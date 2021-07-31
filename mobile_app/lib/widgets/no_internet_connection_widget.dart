import 'package:flutter/material.dart';

class NoInternetConnectionWidget extends StatelessWidget {
  const NoInternetConnectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off_sharp,
            size: 100,
          ),
          Text("No Internet Connection")
        ],
      ),
    );
  }
}
