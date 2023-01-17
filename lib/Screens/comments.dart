import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se_380_project/Models/content.dart';

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


  const Comments({Key? key, this.commentText ="",  this.commentId = 0, this.authorComment = "", this.name = ""}) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments>{
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


  List<String> commentArray = [];
  TextEditingController _controller = TextEditingController();
  List<Like> likes = [];

  @override
  void initState() {
    super.initState();
    _commentText = widget.commentText ?? '';
    _commentId = widget.commentId ?? 0;
    _authorComment = widget.authorComment ?? '';
    _name = '';
  }

  void addComment() {
    setState(() {
      commentArray.add(_controller.text);
      likes.add(Like(isLiked: false));
      saveComments(commentText: _controller.text, commentId: commentArray.length -1, authorComment: _username, name: _name);
    });
  }
  void saveComments({required String commentText, required int commentId, required String authorComment, required String name}) async {
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
    var content = ModalRoute.of(context)?.settings.arguments as Map;
    _name = content["content_name"];
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
    child: ListView(
    children: [
    const SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(0, 10, 0, 40),
    child: Text(
    "Make a Comment: ",
    style: TextStyle(color: Colors.black, fontSize: 24
    ),
    textAlign: TextAlign.center,
    ),
    ),
    Card(
    child: Column(
    children:  [
    TextField(
    decoration: InputDecoration(
    prefixIcon: Icon(Icons.comment, color: Colors.black)
    ),
    controller: _controller,
    ),
    ElevatedButton(
    onPressed: (){
    addComment();
    },
    child: Text('Add Comment'),
    )
    ],
    ),
    ),
    const SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
    child: Text(
    "Comments: ",
    style: TextStyle(color: Colors.black, fontSize: 24),
    textAlign: TextAlign.center,
    ),
    ),
    Card(
    child: Column(
    children: [
    ListView.builder(
    shrinkWrap: true,
    itemCount: commentArray.length,
    itemBuilder: (BuildContext context, int index) {
    return Column(
    children: [
    Text('$_username: ${commentArray.elementAt(index)}'),
    ElevatedButton(
    onPressed: () {
    setState(() {
    likes[index].isLiked = !likes[index].isLiked;
    });
    },
    child: Text(likes[index].isLiked ? 'Unlike' : 'Like'),
    ),
    ],
    );
    },
    physics: ScrollPhysics()
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    )
    );
  }
}



