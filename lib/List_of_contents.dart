import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_380_project/Models/content.dart';
import 'Screens/content_detail_page.dart';
import 'Screens/filter_by.dart';
import 'Screens/profile.dart';
import './Providers/content_provider.dart';

class ListOfContents extends StatelessWidget {
  const ListOfContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(child: Text("HaDiBe!")),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const Profile(),
            ));
          },
          iconSize: 40,
          icon: const Icon(
            Icons.account_box,
          ),
        ),
        actions: [
          IconButton(
            iconSize: 40,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const FilterBy(),
              ));
            },
            icon: const Icon(Icons.filter_list_sharp),
          ),
        ],
      ),
      body: Container(child: const ContentGrid(),color: Colors.black38,),
    );
  }
}

class ContentGrid extends StatelessWidget {
  const ContentGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final contentData = Provider.of<ContentProvider>(context);
    final contents = contentData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: contents.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider(
        create: (context) => contents[index],
        child: ContentInList(
            //contents[index].name,
            //contents[index].platform,
            //contents[index].imageUrl,
            //contents[index].rate,
            ),
      ),
    );
  }
}

class ContentInList extends StatefulWidget {
  @override
  State<ContentInList> createState() => _ContentInListState();
}

class _ContentInListState extends State<ContentInList> {
  //final String name;
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
            icon: Icon(content.isFavorite
                ? Icons.favorite
                : Icons.favorite_border),
            color: Colors.red,
            onPressed: () {
              content.favoriteStatus();
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
