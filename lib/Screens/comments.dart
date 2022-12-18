import 'package:flutter/material.dart';

class Comments extends StatelessWidget {
  static const routeName = '/comment';
  const Comments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Comments"),
      ),
      body: Container(
        color: Colors.black38,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text("Comments"),
            ],
          ),
        ),
      ),
    );
  }
}
