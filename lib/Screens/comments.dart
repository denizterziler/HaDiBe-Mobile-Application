import 'package:flutter/material.dart';

class Comments extends StatelessWidget {
  static const routeName = '/comment';

  const Comments({Key? key}) : super(key: key);

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
                  children: const [
                    TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.comment,
                            color: Colors.black,
                          )),
                    ),
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
                    Column(
                      children: const [
                        Text('Name Placeholder'),
                      ],
                    ),
                    const SizedBox(height: 50),
                    const Text('Comment Placeholder', style: TextStyle(fontWeight: FontWeight.w300),),
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