import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_380_project/Models/content.dart';
import 'package:se_380_project/Providers/content_provider.dart';
import 'package:se_380_project/Screens/comments.dart';
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
          backgroundColor: Colors.black.withOpacity(.75),
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
                provider.addFavsList(
                    loadedContent, provider.isAddedFavList(loadedContent));
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
                  onPressed: () {
                    Navigator.of(context).pushNamed(Comments.routeName,
                        arguments: loadedContent.name);
                    loadedContent.addListener(() {
                      setState(() {});
                    });
                  },
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
                    setState(() {});
                    provider.addLikeList(
                        loadedContent, provider.isAddedLikeList(loadedContent));
                    loadedContent.likeStatus();
                    loadedContent.notifyListeners();
                  },
                  child: const Text("Like"),
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
              /*Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black)),
                  onPressed: null,
                  child: const Text("Other",
                      style: TextStyle(color: Colors.white)),
                ),
              ),*/
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
                                      'Rate of ${loadedContent.name} is ${loadedContent.rate.toStringAsFixed(2)}/10',
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
                                WidgetSpan(
                                    child: Icon(
                                  loadedContent.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  color: loadedContent.isFavorite
                                      ? Colors.red
                                      : Colors.white,
                                  size: 20,
                                )),
                                TextSpan(
                                  text: loadedContent.isFavorite
                                      ? '${loadedContent.name} is in your Favorites'
                                      : '${loadedContent.name} is not in your Favorites',
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
                                  Icons.warning_amber,
                                  color: Colors.redAccent,
                                  size: 20,
                                )),
                                WidgetSpan(
                                    child: Container(
                                  color: Colors.black,
                                  padding: const EdgeInsets.all(1.0),
                                  child: const Text("   "),
                                )),
                                TextSpan(
                                  text: '${loadedContent.hadiBe} HaDiBe',
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Center(child: Text(loadedContent.name)),
                              content: Container(
                                height: 300,
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: SingleChildScrollView(
                                  child: Center(
                                    child: Text(
                                      loadedContent.description,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Center(child: Text("Close",style: TextStyle(color: Colors.black54),)),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        child: Container(
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
                                  Icons.description,
                                  color: Colors.blue,
                                  size: 20,
                                )),
                                WidgetSpan(
                                    child: Container(
                                  color: Colors.black,
                                  padding: const EdgeInsets.all(1.0),
                                  child: const Text("   "),
                                )),
                                TextSpan(
                                  text: 'Description of ${loadedContent.name}',
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
                                WidgetSpan(
                                    child: Icon(
                                      loadedContent.isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border_outlined,
                                      color: loadedContent.isLiked
                                          ? Colors.red
                                          : Colors.white,
                                      size: 20,
                                    )),
                                TextSpan(
                                  text: loadedContent.isLiked
                                      ? ' You liked ${loadedContent.name}'
                                      : ' You did not like ${loadedContent.name}',
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
