import 'package:flutter/material.dart';

class Likes extends StatelessWidget {
  const Likes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Likes"),
      ),
      body: const Text("Likes Page"),
    );
  }
}