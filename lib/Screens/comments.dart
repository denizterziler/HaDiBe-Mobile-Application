import 'package:flutter/material.dart';

class Like {
  bool isLiked;

  Like({required this.isLiked});
}

class Comments extends StatefulWidget {
  static const routeName = '/comment';

  const Comments({Key? key}) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments>{
  List<String> commentArray = [];
  TextEditingController _controller = TextEditingController();
  List<Like> likes = [];

  @override
  void initState() {
    super.initState();
  }

  void addComment() {
    setState(() {
      commentArray.add(_controller.text);
      likes.add(Like(isLiked: false));
    });
  }

  @override
  Widget build(BuildContext context) {
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
    style: TextStyle(color: Colors.black, fontSize: 24),
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
            Text(commentArray[index]),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  likes[index].isLiked = !likes[index].isLiked;
                });
              },
              child: Column(
                children: <Widget>[
                  Icon(likes[index].isLiked ? Icons.thumb_up : Icons.thumb_up_outlined),
                  Text(likes[index].isLiked ? 'Unlike' : 'Like')
                ],
              ),
            ),
          ],
        );
      },
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



