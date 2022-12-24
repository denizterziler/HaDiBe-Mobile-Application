import 'package:se_380_project/Firebase/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Auth _authService = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Hoş geldiniz!"),
              InkWell(
                onTap: (){
                  _authService.signOut();
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        //color: colorPrimaryShade,
                        borderRadius: const BorderRadius.all(Radius.circular(30))),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Center(
                          child: Text(
                            "Çıkış yap",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),));
  }
}