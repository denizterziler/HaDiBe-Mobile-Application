import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se_380_project/Firebase/auth.dart';
import 'package:se_380_project/FirebaseContent/contentDetailFb.dart';
import 'package:se_380_project/Screens/content_detail_page.dart';
import 'package:se_380_project/Screens/search.dart';
import 'package:se_380_project/Widgets/content_grid.dart';
import 'Screens/filter_by.dart';
import 'Screens/menu.dart';

class ListOfContents extends StatefulWidget {
  static const routeName = '/list-of-contents';

  ListOfContents({Key? key}) : super(key: key);

  @override
  State<ListOfContents> createState() => _ListOfContentsState();
}

class _ListOfContentsState extends State<ListOfContents> {
  final CollectionReference _referenceContents =
      FirebaseFirestore.instance.collection('Contents');
  late Stream<QuerySnapshot> _streamData;
  final Auth _authService = Auth();

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
  //late Future<QuerySnapshot> _futureData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamData = _referenceContents.snapshots();
    // _futureData = _referenceContents.get();
    /*_futureData.then((value) {
      setState(() {
        _items = parseData(value);
      });
    });*/
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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black.withOpacity(.75),
          title: const Text("HaDiBe!"),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Menu(),
              ));
            },
            iconSize: 40,
            icon: const Icon(
              Icons.account_box,
            ),
          ),
          actions: [
            IconButton(
              iconSize: 30,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ));
              },
              icon: const Icon(Icons.search),
            ),
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
        /*body: Container(
        color: Colors.black38,
        child:  const ContentGrid(),
      ),*/
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
                //return buildListView(items);
                return buildGridView(items);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }

  GridView buildGridView(List<Map<dynamic, dynamic>> items) {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
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
                    thisItem['content_rate'].toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Icon(
                    Icons.star,
                    size: 9,
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
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == true) {
                            return IconButton(
                                onPressed: () {
                                  setState(() {
                                    _authService
                                        .addToFirebaseFavs(thisItem['content_name']);
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
                                    _authService
                                        .addToFirebaseFavs(thisItem['content_name']);
                                  });
                                },
                                icon: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ));
                          }
                        });
                  }),
              title: Text(thisItem['content_name']),
              backgroundColor: Colors.black54,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(ContentDetailFb.routeName, arguments: thisItem);
              },
              child: Image.network(
                thisItem['image_url'],
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
