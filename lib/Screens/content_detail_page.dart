import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    var contentName = ModalRoute.of(context)?.settings.arguments as String;
    var loadedContent = Provider.of<ContentProvider>(context)
        .items
        .firstWhere((element) => element.name == contentName);
    return ChangeNotifierProvider(
      create: (BuildContext context) => ContentProvider(),
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
        body: Container(
          color: Colors.black38,
          child: ListView(
            children: [
              Center(
                child: Image.network(loadedContent.imageUrl),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        color: Colors.orange,
                        alignment: Alignment.center,
                        constraints: const BoxConstraints(
                          maxWidth: 300,
                          maxHeight: 100,
                        ),
                        child: Text.rich(
                          TextSpan(
                            children: <InlineSpan>[
                              const WidgetSpan(
                                  child: Icon(
                                Icons.star,
                                color: Colors.red,
                                size: 30,
                              )),
                              TextSpan(
                                text:
                                    'Rate of ${loadedContent.name} is:${loadedContent.rate}/10',
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          color: Colors.pink,
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(
                            maxWidth: 250,
                            maxHeight: 50,
                          ),
                          child: Text.rich(
                            TextSpan(
                              children: <InlineSpan>[
                                const WidgetSpan(
                                    child: Icon(
                                  Icons.info_outline,
                                  color: Colors.teal,
                                  size: 30,
                                )),
                                TextSpan(
                                  text: 'Available on ${loadedContent.platform}',
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Description of ${loadedContent.name}",
                      style: const TextStyle(fontSize: 30),
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
              ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.amber)),

                        onPressed: null,
                        child: const Text("Comment"),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.amber)),
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
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.amber)),

                        onPressed: null,
                        child: const Text("+ List"),
                      ),
                    ),
                     Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.amber)),

                        onPressed: null,
                        child: const Text("Other"),
                      ),
                    ),
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
