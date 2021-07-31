import 'package:flutter/material.dart';
import 'time_line_favorite_card.dart';
import '../../services/timeline_favorite_data_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/build_appbar.dart';

class TimelineFavoritesScreen extends StatelessWidget {
  static final route = 'timeline-favorites';

  const TimelineFavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, "Favorites"),
        body: ChangeNotifierProvider<TimelineFavoriteDataProvider>(
          create: (_) => TimelineFavoriteDataProvider(),
          builder: (context, child) => child!,
          child: Consumer<TimelineFavoriteDataProvider>(
            builder: (context, timelineFavoriteDataProvider, child) {
              if (timelineFavoriteDataProvider.favoriteDataStatus == FavoriteDataStatus.GETTING_DATA) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (timelineFavoriteDataProvider.favoriteDataStatus == FavoriteDataStatus.HAVE_DATA) {
                return ListView.builder(
                  itemBuilder: (context, index) => TimelineFavoriteCard(blogIndex: index),
                  itemCount: timelineFavoriteDataProvider.blogs.length,
                );
              } else {
                return Container();
              }
            },
          ),
        ));
  }
}
