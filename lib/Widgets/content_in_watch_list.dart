import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_380_project/Models/content.dart';
import 'package:se_380_project/Providers/content_provider.dart';
import 'package:se_380_project/Screens/content_detail_page.dart';
class ContentInWatchList extends StatefulWidget {
  const ContentInWatchList({Key? key}) : super(key: key);

  @override
  State<ContentInWatchList> createState() => _ContentInWatchListState();
}

class _ContentInWatchListState extends State<ContentInWatchList> {
  @override
  Widget build(BuildContext context) {
    final content = Provider.of<Content>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          trailing: Row(
            children: [
              const Icon(
                Icons.star,
                size: 9,
              ),
              Text(
                "${content.rate}/10",
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          leading: IconButton(
            icon: Icon(
                content.isFavorite ? Icons.favorite : Icons.favorite_border),
            color: Colors.red,
            onPressed: () {
              setState(() {});
              content.favoriteStatus();
              content.notifyListeners();
            },
          ),
          title: Text(content.name),
          backgroundColor: Colors.black54,
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ContentDetailPage.routeName,
                arguments: content.name);
          },
          child: Image.network(
            content.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}


