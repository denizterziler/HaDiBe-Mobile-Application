import 'package:flutter/material.dart';
import '../Models/content.dart';
class ContentProvider with ChangeNotifier {
  final List<Content> _items = [
    Content(
      name: "The Matrix",
      type: "Movies",
      platform: "Netlix",
      category: "Sci-fi",
      imageUrl:
      "https://upload.wikimedia.org/wikipedia/en/0/06/Ultimate_Matrix_Collection_poster.jpg",
      length: 136,
      description: "The matrix is amazing",
      rate: 10.0,
    ),
    Content(
      name: "Dracula",
      type: "Movies",
      platform: "Disney+",
      category: "Animation",
      imageUrl:
      "https://upload.wikimedia.org/wikipedia/tr/6/60/Dracula_afiş.jpg",
      length: 100,
      description: "Dracula is awesome",
      rate: 7.4,
    ),
    Content(
      name: "Titanic",
      type: "Movies",
      platform: "Disney+",
      category: "Animation",
      imageUrl:
      "https://upload.wikimedia.org/wikipedia/tr/b/b3/Titanik_film.jpg",
      length: 150,
      description: "Titanic was a British passenger liner, operated by the White Star Line, which sank in the North Atlantic Ocean ",
      rate: 7.9,
    ),
    Content(
      name: "Simpsons",
      type: "Series",
      platform: "Disney+",
      category: "Animation",
      imageUrl:
      "https://upload.wikimedia.org/wikipedia/tr/thumb/e/ed/Bart_Simpson.svg/200px-Bart_Simpson.svg.png",
      length: 70,
      description: "The Simpsons is an American animated sitcom created by Matt Groening for the Fox Broadcasting Company. The series is a satirical depiction of American life, epitomized by the Simpson family, which consists of Homer, Marge, Bart, Lisa, and Maggie.",
      rate: 8.4,
    ),
  ];
  List<Content> get items {
    return [..._items];
  }
  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }
}
