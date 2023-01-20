import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se_380_project/Firebase/auth.dart';

class FirebaseLiked extends StatefulWidget {
  static const routeName = '/firebase-favorites';

  const FirebaseLiked({Key? key}) : super(key: key);

  @override
  State<FirebaseLiked> createState() => _FirebaseLikedState();
}

class _FirebaseLikedState extends State<FirebaseLiked> {
  final CollectionReference _referenceContents =
  FirebaseFirestore.instance.collection('Comments');
  late Stream<QuerySnapshot> _streamData;
  final Auth _authService = Auth();

  Future<bool> isLiked(String comment) async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Users').doc(firebaseUser.uid);
    DocumentSnapshot doc = await documentReference.get();
    List likedCT = doc['likedCT'];
    if (likedCT.contains(comment) == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Map>> likedItems(List<Map> comments) async {
    List<Map> likedComments = <Map>[];
    for (int i = 0; i < comments.length; i++) {
      if (await isLiked(comments[i]['comment_text'])) {
        likedComments.add(comments[i]);
      }
    }
    return likedComments;
  }

  @override
  void initState() {
    super.initState();
    _streamData = _referenceContents.snapshots();
  }

  List<Map> parseData(QuerySnapshot querySnapshot) {
    List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;
    List<Map> listItems = listDocs
        .map((e) =>
    {
      'comment_author': e['authorComment'],
      'comment_id': e['commentId'],
      'comment_text': e['commentText'],
      'comment_content_name': e['name'],
    })
        .toList();
    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(.75),
          centerTitle: true,
          title: const Text("Liked Comments"),
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
                List<Map> comments = parseData(snapshot.data);
                return FutureBuilder(
                    future: likedItems(comments),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return snapshot.hasData
                          ? buildGridView(snapshot.data)
                          : const Center(
                        child: CircularProgressIndicator(),
                      );
                    });
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }

  buildGridView(List<Map<dynamic, dynamic>> items) {
    return items.isNotEmpty
        ? ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        Map thisComment = items[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              FutureBuilder(
                future: isLiked(thisComment['comment_text']),
                builder: (context, snapshot) {
                  if (snapshot.data == true) {
                    return ListTile(
                        title: Text(
                          thisComment['comment_text'],
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        subtitle: Text('${thisComment['comment_author']} said to : ${thisComment['comment_content_name']}',
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              _authService
                                  .addToFirebaseLiked(
                                  thisComment['comment_text']);
                            });
                          },
                          icon: const Icon(
                            Icons
                                .insert_emoticon_rounded,
                            color: Colors.amber,
                          ),
                        ),
                    );
                  }else{
                    return ListTile(
                      title: Text(
                        thisComment['comment_text'],
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      subtitle: Text(
                        thisComment['comment_author'],
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            _authService
                                .addToFirebaseLiked(
                                thisComment['comment_text']);
                          });
                        },
                        icon: const Icon(
                          Icons
                              .emoji_emotions_outlined,
                        ),
                      ),
                    );
                  }
                },
              ),
              const Divider(),
            ],
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
                      "You don't have any liked comment",
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
                      "You can add comments to this page with Like buttons",
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
