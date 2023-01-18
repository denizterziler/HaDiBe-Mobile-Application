import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se_380_project/Firebase/auth.dart';
import 'package:se_380_project/FirebaseContent/firebaseRate.dart';

import '../Screens/comments.dart';


class ContentDetailFb extends StatefulWidget {
  static const routeName = '/content-detail-fb';

  const ContentDetailFb({super.key});

  @override
  State<ContentDetailFb> createState() => _ContentDetailFbState();
}

class _ContentDetailFbState extends State<ContentDetailFb> {
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

  @override
  Widget build(BuildContext context) {
    var content = ModalRoute.of(context)?.settings.arguments as Map;
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.75),
        centerTitle: true,
        title: Text(content['content_name']),
        actions: [
          StreamBuilder<Object>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(firebaseUser.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                return FutureBuilder(
                    future: isFavorite(content['content_name']),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == true) {
                        return IconButton(
                            onPressed: () {
                              setState(() {
                                _authService
                                    .addToFirebaseFavs(content['content_name']);
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
                                    .addToFirebaseFavs(content['content_name']);
                              });
                            },
                            icon: const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ));
                      }
                    });
              }),
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
                      arguments: content);
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
                  Navigator.of(context).pushNamed(FirebaseRate.routeName,
                      arguments: content);
                },
                child: const Text("Rate"),
              ),
            ),
            Expanded(
              child: StreamBuilder<Object>(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(firebaseUser.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return FutureBuilder(
                        future: isInWatchList(content['content_name']),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == true) {
                            return ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
                                onPressed: () {
                                  setState(() {
                                    _authService
                                        .addToFirebaseWatchList(content['content_name']);
                                  });
                                },
                              child: const Text("- List"),);
                          } else {
                            return ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
                              onPressed: () {
                                  setState(() {
                                    _authService
                                        .addToFirebaseWatchList(content['content_name']);
                                  });
                                },
                                child: const Text("+ List"),);
                          }
                        });
                  }),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey,
        child: ListView(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.only(top: 8.0),
                width: 300,
                height: 350,
                child: Image.network(
                  content['image_url'],
                  //scale: 1.2,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('Contents').doc(content['con_id']).snapshots(),
                      builder:(context, snapshot) {
                        if(snapshot.hasData){
                          return Padding(
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
                                            Icons.alarm,
                                            color: Colors.amber,
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
                                        content['con_type'] == 'Movies' ? '${content['con_length'].toString()} Minutes': '${content['con_length'].toString()} Episodes',
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        }
                        else{
                          return const Text("Error");
                        }
                      }),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('Contents').doc(content['con_id']).snapshots(),
                      builder:(context, snapshot) {
                        if(snapshot.hasData){
                          return Padding(
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
                                        'Rate : ${content['content_rate'].toStringAsFixed(2)}/10',
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        }
                        else{
                          return const Text("Error");
                        }
                      }),
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
                                    'Available on ${content['content_platform']}',
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
                  StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(firebaseUser.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return FutureBuilder(
                            future: isInWatchList(content['content_name']),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.data == true) {
                                return Padding(
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
                                                  Icons.list,
                                                  color: Colors.red,
                                                  size: 20,
                                                )),
                                            WidgetSpan(
                                                child: Container(
                                                  color: Colors.black,
                                                  padding:
                                                  const EdgeInsets.all(1.0),
                                                  child: const Text("   "),
                                                )),
                                            const TextSpan(
                                              text:
                                              'In your List',
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
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
                                                  Icons.list,
                                                  color: Colors.white,
                                                  size: 20,
                                                )),
                                            WidgetSpan(
                                                child: Container(
                                                  color: Colors.black,
                                                  padding:
                                                  const EdgeInsets.all(1.0),
                                                  child: const Text("   "),
                                                )),
                                            const TextSpan(
                                              text:
                                              'Not in your List',
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            });
                      }),
                  StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(firebaseUser.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return FutureBuilder(
                            future: isFavorite(content['content_name']),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.data == true) {
                                return Padding(
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
                                              Icons.favorite,
                                              color: Colors.red,
                                              size: 20,
                                            )),
                                            WidgetSpan(
                                                child: Container(
                                              color: Colors.black,
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: const Text("   "),
                                            )),
                                            const TextSpan(
                                              text:
                                                  'In your Favorites',
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
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
                                              Icons.favorite_border_outlined,
                                              color: Colors.white,
                                              size: 20,
                                            )),
                                            WidgetSpan(
                                                child: Container(
                                              color: Colors.black,
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: const Text("   "),
                                            )),
                                            const TextSpan(
                                              text:
                                                  'Not in your Favorites',
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            });
                      }),
                  StreamBuilder<Object>(
                    stream: FirebaseFirestore.instance.collection('Contents').doc(content['con_id']).snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return Padding(
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
                                      text:
                                      '${content['con_hadiBe'].toString()} HaDiBe',
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      }else
                      {
                        return const Text("Some error");
                      }
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.black54.withOpacity(.75),
                            title: Center(
                                child: Text(
                              content['content_name'],
                              style: const TextStyle(color: Colors.white),
                            )),
                            content: Container(
                              height: 300,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                              ),
                              child: SingleChildScrollView(
                                child: Center(
                                  child: Text(
                                    content['con_description'],
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Center(
                                    child: Text(
                                  "Close",
                                  style: TextStyle(color: Colors.white),
                                )),
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
                              const TextSpan(
                                text:
                                    'Description',
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
    );
  }
}
