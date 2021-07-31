import 'package:flutter/material.dart';

class ResourceSubSection extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  ResourceSubSection({required this.title,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.only(left: 8),
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FittedBox(child: Text(title)),
                IconButton(
                  splashRadius: 16,
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  ),
                  onPressed: onTap,
                )
              ],
            ),
          ),
        ),
        Divider(
          height: 5,
        ),
        // ListTile()
      ],
    );
  }
}
