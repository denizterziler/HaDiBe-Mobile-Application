import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se_380_project/Firebase/auth.dart';
import 'package:se_380_project/FirebaseContent/contentDetailFb.dart';

class FirebaseWatchList extends StatefulWidget {
  static const routeName = '/firebase_watch-list';

  const FirebaseWatchList({Key? key}) : super(key: key);

  @override
  State<FirebaseWatchList> createState() => _FirebaseWatchListState();
}

class _FirebaseWatchListState extends State<FirebaseWatchList> {
  final CollectionReference _referenceContents =
      FirebaseFirestore.instance.collection('Contents');
  late Stream<QuerySnapshot> _streamData;
  final Auth _authService = Auth();

  Future<bool> isInWatchList(String contentName) async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Users').doc(firebaseUser.uid);
    DocumentSnapshot doc = await documentReference.get();
    List watchList = doc['watchList'];
    if (watchList.contains(contentName) == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isFavorite(String contentName) async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Users').doc(firebaseUser.uid);
    DocumentSnapshot doc = await documentReference.get();
    List favList = doc['favs'];
    if (favList.contains(contentName) == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Map>> wListItems(List<Map> items) async {
    List<Map> watchList = <Map>[];
    for (int i = 0; i < items.length; i++) {
      if (await isInWatchList(items[i]['content_name'])) {
        watchList.add(items[i]);
      }
    }
    return watchList;
  }

  @override
  void initState() {
    super.initState();
    _streamData = _referenceContents.snapshots();
  }

  List<Map> parseData(QuerySnapshot querySnapshot) {
    List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;
    List<Map> listItems = listDocs
        .map((e) => {
              'content_name': e['name'],
              'content_platform': e['platform'],
              'image_url': e['imageUrl'],
              'content_rate': e['rate'],
              'con_category': e['category'],
              'con_description': e['description'],
              'con_hadiBe': e['hadiBe'],
            })
        .toList();
    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(.75),
          centerTitle: true,
          title: const Text("Watch List"),
        ),
        body: Container(
          color: Colors.black38,
          child: StreamBuilder<QuerySnapshot>(
            stream: _streamData,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return const Text("Some error");
              }
              if (snapshot.hasData) {
                List<Map> items = parseData(snapshot.data);
                return StreamBuilder<Object>(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(firebaseUser.uid)
                        .snapshots(),
                  builder: (context, snapshot) {
                    return FutureBuilder(
                        future: wListItems(items),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          return snapshot.hasData
                              ? buildGridView(snapshot.data)
                              : const Center(
                                  child: CircularProgressIndicator(),
                                );
                        });
                  }
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }

  buildGridView(List<Map<dynamic, dynamic>> items) {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    return items.isNotEmpty
        ? GridView.builder(
            padding: const EdgeInsets.only(
                top: 5.0, bottom: 5.0, left: 3.0, right: 3.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 2 / 2.2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              Map thisItem = items[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GridTile(
                  footer: GridTileBar(
                    trailing: Row(
                      children: [
                        Text(
                          thisItem['content_rate'].toStringAsFixed(2),
                          style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color:Colors.white),
                        ),
                        const Icon(
                          Icons.star,
                          size: 15,
                        ),
                      ],
                    ),
                    leading: StreamBuilder<Object>(
                        stream: FirebaseFirestore.instance
                            .collection('Users')
                            .doc(firebaseUser.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          return FutureBuilder(
                              future: isFavorite(thisItem['content_name']),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.data == true) {
                                  return IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _authService.addToFirebaseFavs(
                                              thisItem['content_name']);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      ));
                                } else {
                                  return IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _authService.addToFirebaseFavs(
                                              thisItem['content_name']);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                      ));
                                }
                              });
                        }),
                    title: Text(thisItem['content_name'],style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                    backgroundColor: Colors.black54,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(ContentDetailFb.routeName,
                          arguments: thisItem);
                    },
                    child: Image.network(
                      thisItem['image_url'],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
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
                        child: Text(
                          "You don't have any content to watch",
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
                          "You can add contents from the Content Detail Pages",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
        );
  }
}
