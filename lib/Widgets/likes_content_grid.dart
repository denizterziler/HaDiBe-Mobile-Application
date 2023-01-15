import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_380_project/Providers/content_provider.dart';
import 'package:se_380_project/Widgets/content_in_likes.dart';

class LikesContentGrid extends StatelessWidget {
  const LikesContentGrid({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: const ContentInLikes(),
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
                      child: Text("You don't have any liked content",
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
                        "You can like contents from the Content Detail Pages",
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
