import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se_380_project/Firebase/auth.dart';

class Like {
  bool isLiked;

  Like({required this.isLiked});
}

class Comments extends StatefulWidget {
  static const routeName = '/comments';
  final String commentText;
  final int commentId;
  final String authorComment;
  final String name;

  const Comments(
      {Key? key,
      this.commentText = "",
      this.commentId = 0,
      this.authorComment = "",
      this.name = ""})
      : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final Auth _authService = Auth();
  String _username = '';
  String _commentText = '';
  int _commentId = 0;
  String _authorComment = '';
  String _name = '';

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseUser.uid)
        .get()
        .then((value) {
      _username = value.get('userName');
    });
  }

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

  List<String> commentArray = [];
  List<String> usersArray = [];

  final TextEditingController _controller = TextEditingController();
  List<Like> likes = [];

  @override
  void initState() {
    super.initState();
    _commentText = widget.commentText ?? '';
    _commentId = widget.commentId ?? 0;
    _authorComment = widget.authorComment ?? '';
    _name = '';
  }

  _getContentComments() async {
    if (_name != null && _name.isNotEmpty) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Comments')
          .where('name', isEqualTo: _name)
          .get();
      if (snapshot.docs.isNotEmpty) {
        setState(() {
          commentArray = snapshot.docs
              .map((doc) => doc['commentText'])
              .cast<String>()
              .toList();
          if (likes.length < commentArray.length) {
            for (int i = likes.length; i < commentArray.length; i++) {
              likes.add(Like(isLiked: false));
            }
          }
        });
      }
    }
  }

  _getContentCommentsUsers() async {
    if (_name != null && _name.isNotEmpty) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Comments')
          .where('name', isEqualTo: _name)
          .get();
      if (snapshot.docs.isNotEmpty) {
        setState(() {
          usersArray = snapshot.docs
              .map((doc) => doc['authorComment'])
              .cast<String>()
              .toList();
          if (likes.length < commentArray.length) {
            for (int i = likes.length; i < commentArray.length; i++) {
              likes.add(Like(isLiked: false));
            }
          }
        });
      }
    }
  }

  void addComment() {
    setState(() {
      commentArray.add(_controller.text);
      likes.add(Like(isLiked: false));
      saveComments(
          commentText: _controller.text,
          commentId: commentArray.length - 1,
          authorComment: _username,
          name: _name);
    });
  }

  void saveComments(
      {required String commentText,
      required int commentId,
      required String authorComment,
      required String name}) async {
    try {
      await FirebaseFirestore.instance.collection("Comments").add({
        "commentText": commentText,
        "commentId": commentId,
        "authorComment": authorComment,
        "name": name,
      });
    } catch (e) {
// Handle errors here
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    var content = ModalRoute.of(context)?.settings.arguments as Map;
    _name = content["content_name"];
    _getContentComments();
    _getContentCommentsUsers();
    _fetch();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(.75),
          centerTitle: true,
          title: const Text("Comments"),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.black12,
          child: Center(
            child: Column(
              children: [
                Column(
                  children: [
                    const Text(
                      "Make a Comment: ",
                      style: TextStyle(color: Colors.black, fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    Card(
                      child: Column(
                        children: [
                          TextField(
                            decoration: const InputDecoration(
                                prefixIcon:
                                    Icon(Icons.comment, color: Colors.black)),
                            controller: _controller,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              addComment();
                            },
                            child: const Text('Add Comment'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Comments: ",
                  style: TextStyle(color: Colors.black, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.black38,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: commentArray.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(commentArray.elementAt(index)),
                                  subtitle: Text(usersArray.elementAt(index)),
                                  trailing: StreamBuilder<Object>(
                                      stream: FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(firebaseUser.uid)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        return FutureBuilder(
                                            future: isLiked(
                                                commentArray.elementAt(index)),
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              if (snapshot.data == true) {
                                                return IconButton(
                                                  onPressed: () {
                                                    setState(() {

                                                      _authService
                                                          .addToFirebaseLiked(
                                                              commentArray.elementAt(index));
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons
                                                        .insert_emoticon_rounded,
                                                    color: Colors.amber,
                                                  ),
                                                );
                                              } else {
                                                return IconButton(
                                                  onPressed: () {
                                                    setState(() {

                                                      _authService
                                                          .addToFirebaseLiked(
                                                          commentArray.elementAt(index));
                                                    });
                                                  },
                                                  icon: const Icon(Icons
                                                      .emoji_emotions_outlined),
                                                );
                                              }
                                            });
                                      }),
                                ),
                                const Divider(
                                  thickness: 2,
                                  color: Colors.black,
                                ),
                              ],
                            );
                          },
                          physics: const ScrollPhysics()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
