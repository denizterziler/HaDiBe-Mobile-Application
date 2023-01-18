import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/*class ContentInLikes extends StatefulWidget {
  const ContentInLikes({Key? key}) : super(key: key);

  @override
  State<ContentInLikes> createState() => _ContentInLikesState();
}

class _ContentInLikesState extends State<ContentInLikes> {
  @override
  Widget build(BuildContext context) {
    final content = Provider.of<Content>(context);
    final provider = Provider.of<ContentProvider>(context);
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
                content.isLiked ? Icons.favorite : Icons.favorite_border),
            color: Colors.red,
            onPressed: () {
              setState(() {});
              content.likeStatus();
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
}*/