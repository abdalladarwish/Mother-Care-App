import 'package:flutter/material.dart';

import '../../data.dart';
import 'resource_subsections_screen.dart';
import '../../widgets/resource_card.dart';

class ResourcesScreen extends StatelessWidget {
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 5),
      child: GridView.builder(
        itemCount: data.length,
        itemBuilder: (cxt, index) {
          return GestureDetector(
            child: ResourceCard(
              imageUrl: 'assets/images/baby1.jpg',
              title: data[index].title,
            ),
            onTap: () => Navigator.of(context).pushNamed(
                ResourceSubsectionsScreen.route,
                arguments: {'title': data[index].title,'subsections':data[index].subsections}),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1 / 1.2),
      ),
    );
  }
}
