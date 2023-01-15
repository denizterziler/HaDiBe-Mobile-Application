import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  static const routeName = '/comment';

  const Comments({Key? key}) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments>{
  List<String> commentArray = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.75),
        centerTitle: true,
        title: Text("Comments"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.black12,
        child: Center(
          child: ListView(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 40),
                child: Text(
                  "Make a Comment: ",
                  style: TextStyle(color: Colors.black, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
              Card(
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.comment,
                            color: Colors.black,
                          )),
                      onChanged: (String value) {
                        commentArray.add(value);
                      },
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
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
                        Column(
                          children: [
                            if (commentArray.length > 0)
                            Text(commentArray.elementAt(0)),
                          ],
                        ),
                    SizedBox(height: 50),
                    Text('Comment Placeholder', style: TextStyle(fontWeight: FontWeight.w300),),
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

