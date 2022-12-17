import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_380_project/Models/content.dart';
import 'package:se_380_project/Providers/content_provider.dart';
import 'package:se_380_project/Screens/rate.dart';

class ContentDetailPage extends StatefulWidget {
  static const routeName = '/content-detail';

  const ContentDetailPage({super.key});

  @override
  State<ContentDetailPage> createState() => _ContentDetailPageState();
}

class _ContentDetailPageState extends State<ContentDetailPage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ContentProvider>(context);
    var contentName = ModalRoute.of(context)?.settings.arguments as String;
    var loadedContent = Provider.of<ContentProvider>(context)
        .items
        .firstWhere((element) => element.name == contentName);
    return ChangeNotifierProvider.value(
      value: ContentProvider(),
      // create: (BuildContext context) => ContentProvider(), ChangeNotifierProvider{}
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(loadedContent.name),
          actions: [
            IconButton(
              icon: Icon(loadedContent.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: Colors.red,
              onPressed: () {
                setState(() {});
                loadedContent.favoriteStatus();
                loadedContent.notifyListeners();
              },
            ),
          ],
        ),
        bottomNavigationBar: ListTile(
          tileColor: Colors.black54,
          title: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black)),
                  onPressed: null,
                  child: const Text("Comment",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Rate.routeName,
                        arguments: loadedContent.name);
                    loadedContent.addListener(() {
                      setState(() {});
                    });
                  },
                  child: const Text("Rate"),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black)),
                  onPressed: () {
                    provider.addWatchList(
                        loadedContent, provider.isAdded(loadedContent));
                    final snackBar = SnackBar(
                      content: provider.isAdded(loadedContent)
                          ? Text(
                              '${loadedContent.name} has been added to your list')
                          : Text(
                              '${loadedContent.name} has been removed from your list'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Text("+ List",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black)),
                  onPressed: null,
                  child: const Text("Other",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.grey,
          child: ListView(
            children: [
              Center(
                child: Image.network(
                  loadedContent.imageUrl,
                  scale: 1.2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        color: Colors.black,
                        alignment: Alignment.center,
                        constraints: const BoxConstraints(
                          maxWidth: 400,
                          maxHeight: 50,
                        ),
                        child: Text.rich(
                          TextSpan(
                            children: <InlineSpan>[
                              const WidgetSpan(
                                  child: Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 20,
                              )),
                              WidgetSpan(
                                  child: Container(
                                color: Colors.black,
                                padding: const EdgeInsets.all(1.0),
                                child: const Text("   "),
                              )),
                              TextSpan(
                                text:
                                    'Rate of ${loadedContent.name} is:${loadedContent.rate}/10',
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          color: Colors.black,
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(
                            maxWidth: 400,
                            maxHeight: 50,
                          ),
                          child: Text.rich(
                            TextSpan(
                              children: <InlineSpan>[
                                const WidgetSpan(
                                    child: Icon(
                                  Icons.info_outline,
                                  color: Colors.teal,
                                  size: 20,
                                )),
                                WidgetSpan(
                                    child: Container(
                                  color: Colors.black,
                                  padding: const EdgeInsets.all(1.0),
                                  child: const Text("   "),
                                )),
                                TextSpan(
                                  text:
                                      'Available on ${loadedContent.platform}',
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Description of ${loadedContent.name}:",
                      style: const TextStyle(fontSize: 25),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(loadedContent.description),
                    ),
                    loadedContent.isFavorite
                        ? const Text("Favorite")
                        : const Text("Not fav"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
