import 'package:flutter/material.dart';
import 'package:se_380_project/Firebase/auth.dart';
import 'package:se_380_project/Screens/comments.dart';
import 'package:se_380_project/FirebaseContent/firebaseFavorites.dart';
import 'package:se_380_project/FirebaseContent/firebaseWatchList.dart';
import 'package:se_380_project/Screens/login_page.dart';
import 'package:se_380_project/Screens/profile_page.dart';
import 'package:se_380_project/Screens/user_comments.dart';


import 'likes.dart';

class Menu extends StatelessWidget {
  Menu({Key? key}) : super(key: key);
  final Auth _authService = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.75),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.home),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
            icon: const Icon(Icons.account_box),
          ),
        ],
        centerTitle: true,
        title: const Text("Menu"),
      ),
      body: Container(
        color: Colors.black38,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100,
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.amber)),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserComments(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.comment,
                        size: 50,
                      ),
                      SizedBox(width: 70,),
                      Text(
                        "Comments",
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100,
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.amber)),
                  onPressed: () {
                    /*Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Likes(),
                      ),
                    );*/
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.insert_emoticon,
                        size: 50,
                      ),
                      SizedBox(width: 105,),
                      Text(
                        "Likes",
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100,
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.amber)),
                  onPressed: () {
                    /*Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const WatchListPage(),
                      ),
                    );*/
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>  FirebaseWatchList(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.remove_red_eye_outlined,
                        size: 50,
                      ),
                      SizedBox(width: 70,),
                      Text(
                        "Watch List",
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100,
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.amber)),
                  onPressed: () {
                    /*Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Favorites(),
                        ),);*/
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FirebaseFavoriteList(),
                      ),);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.favorite,
                        size: 50,
                      ),
                      SizedBox(width: 80,),
                      Text(
                        "Favorites",
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100,
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.amber)),
                  onPressed: (){
                    _authService.signOut();
                    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.logout_outlined,
                        size: 50,
                      ),
                      SizedBox(width: 90,),
                      Text(
                        "Log Out",
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
