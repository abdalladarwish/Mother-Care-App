import 'package:flutter/material.dart';

class ResourceCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const ResourceCard({
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final margin = const EdgeInsets.all(10);
    return Stack(
      children: [
        Container(
          margin: margin,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          margin: margin,
          color: Theme.of(context).primaryColor.withAlpha(160),
          child: Center(
            child: FittedBox(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
