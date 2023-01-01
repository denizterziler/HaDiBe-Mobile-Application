import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_380_project/Firebase/auth.dart';
import 'package:se_380_project/Providers/content_provider.dart';
import 'package:se_380_project/Widgets/content_in_favorites.dart';
import 'package:se_380_project/Widgets/content_in_watch_list.dart';

class FavoritesContentGrid extends StatelessWidget {
  const FavoritesContentGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final Auth _authService = Auth();
    final contentData = Provider.of<ContentProvider>(context);
    final contents = contentData.favList;
    if (contents.isNotEmpty) {
      return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: contents.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
          value: contents[index],
          child: const ContentInFavorites(),
        ),
      );
    } else {
      return Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                width: 350,
                height: 50,
                color: Colors.blue,
                child: const Center(
                  child: Text("You don't have any favorite content",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                width: 300,
                height: 100,
                color: Colors.red,
                child: const Center(
                  child: Text(
                    "You can add contents with Favorite buttons",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          )
        ],
      ));
    }
  }
}
