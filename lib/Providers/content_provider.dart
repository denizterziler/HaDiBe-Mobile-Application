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
      description: "The Matrix is a 1999 science fiction action film written and directed by the Wachowskis. It is the first installment in The Matrix film series, starring Keanu Reeves, Laurence Fishburne, Carrie-Anne Moss, Hugo Weaving, and Joe Pantoliano, and depicts a dystopian future in which humanity is unknowingly trapped inside the Matrix, a simulated reality that intelligent machines have created to distract humans while using their bodies as an energy source.When computer programmer Thomas Anderson, under the hacker alias \"Neo\", uncovers the truth, he joins a rebellion against the machines along with other people who have been freed from the Matrix.",
      rate: 10.0,
      rateCount: 1,
      hadiBe: 0,
    ),
    Content(
      name: "Dracula",
      type: "Movies",
      platform: "Disney+",
      category: "Animation",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/tr/6/60/Dracula_afiş.jpg",
      length: 100,
      description: "Dracula was theatrically released in the United States on November 13, 1992, to positive reviews,though Keanu Reeves' performance and English accent received criticism.The film opened at #1 in the United States, and grossed \$215 million against a production budget of \$40 million. It was nominated for four Academy Awards, of which it won three for Best Costume Design, Best Sound Editing, and Best Makeup while also being nominated for Best Art Direction. Its score was composed by Wojciech Kilar and its closing credits theme \"Love Song for a Vampire\", written and performed by Annie Lennox, became an international success.",
      rate: 7.4,
      rateCount: 1,
      hadiBe: 0,
    ),
    Content(
      name: "Titanic",
      type: "Movies",
      platform: "Disney+",
      category: "Animation",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/tr/b/b3/Titanik_film.jpg",
      length: 150,
      description:
          "Titanic is a 1997 American epic romance and disaster film directed, written, produced, and co-edited by James Cameron. Incorporating both historical and fictionalized aspects, it is based on accounts of the sinking of the RMS Titanic and stars Kate Winslet and Leonardo DiCaprio as members of different social classes who fall in love aboard the ship during its ill-fated maiden voyage. Also starring are Billy Zane, Kathy Bates, Frances Fisher, Gloria Stuart, Bernard Hill, Jonathan Hyde, Victor Garber, and Bill Paxton.",
      rate: 7.9,
      rateCount: 1,
      hadiBe: 0,
    ),
    Content(
      name: "Simpsons",
      type: "Series",
      platform: "Disney+",
      category: "Animation",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/tr/thumb/e/ed/Bart_Simpson.svg/200px-Bart_Simpson.svg.png",
      length: 70,
      description:
          "The Simpsons is an American animated sitcom created by Matt Groening for the Fox Broadcasting Company. The series is a satirical depiction of American life, epitomized by the Simpson family, which consists of Homer, Marge, Bart, Lisa, and Maggie.",
      rate: 8.4,
      rateCount: 1,
      hadiBe: 0,
    ),
    Content(
      name: "Batman Begins",
      type: "Movies",
      platform: "Netflix",
      category: "Action",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/en/a/af/Batman_Begins_Poster.jpg",
      length: 140,
      description:
          "Batman Begins is a 2005 superhero film directed by Christopher Nolan and written by Nolan and David S. Goyer. The film is based on the DC Comics character Batman, it stars Christian Bale as Bruce Wayne / Batman, with Michael Caine, Liam Neeson, Katie Holmes, Gary Oldman, Cillian Murphy, Tom Wilkinson, Rutger Hauer, Ken Watanabe, and Morgan Freeman in supporting roles. The film reboots the Batman film series, telling the origin story of Bruce Wayne from the death of his parents to his journey to become Batman and his fight to stop Ra's al Ghul and the Scarecrow from plunging Gotham City into chaos.",
      rate: 8.2,
      rateCount: 1,
      hadiBe: 0,
    ),
    Content(
      name: "The Dark Knight",
      type: "Movies",
      platform: "Netflix",
      category: "Action",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/en/1/1c/The_Dark_Knight_%282008_film%29.jpg",
      length: 152,
      description:
          "The Dark Knight is a 2008 superhero film directed by Christopher Nolan from a screenplay he co-wrote with his brother Jonathan. Based on the DC Comics superhero, Batman, it is the sequel to Batman Begins (2005) and the second installment in The Dark Knight Trilogy. The plot follows the vigilante Batman, police lieutenant James Gordon, and district attorney Harvey Dent, who form an alliance to dismantle organized crime in Gotham City. Their efforts are derailed by the Joker, an anarchistic mastermind who seeks to test how far Batman will go to save the city from chaos. The ensemble cast includes Christian Bale, Michael Caine, Heath Ledger, Gary Oldman, Aaron Eckhart, Maggie Gyllenhaal, and Morgan Freeman.",
      rate: 9.0,
      rateCount: 1,
      hadiBe: 0,
    ),
    Content(
      name: "The Dark Knight Rises",
      type: "Movies",
      platform: "Netflix",
      category: "Action",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/en/8/83/Dark_knight_rises_poster.jpg",
      length: 165,
      description:
          "The Dark Knight Rises is a 2012 superhero film directed by Christopher Nolan, who co-wrote the screenplay with his brother Jonathan Nolan, and the story with David S. Goyer.[5] The film is based on the DC Comics character Batman, it is the final installment in Nolan's The Dark Knight trilogy, and the sequel to The Dark Knight (2008). The film stars Christian Bale as Bruce Wayne / Batman, alongside Michael Caine, Gary Oldman, Anne Hathaway, Tom Hardy, Marion Cotillard, Joseph Gordon Levitt, and Morgan Freeman. Eight years after the events of The Dark Knight, the revolutionary Bane forces Bruce Wayne to resume his role as Batman and save Gotham City from nuclear destruction.",
      rate: 8.4,
      rateCount: 1,
      hadiBe: 0,
    ),
  ];
  List<Content> sort(List<Content> list){
    list.sort((a, b){
      return b.rate.compareTo(a.rate);
    });
    return list;
  }
  final List<Content> favList = [];

  void addFavsList(Content content, bool isAdded) {
    if (isAdded) {
      favList.remove(content);
    } else {
      favList.add(content);
    }
    notifyListeners();
  }
  
  bool isAddedFavList(Content content) {
    return favList.contains(content);
  }

  final List<Content> watchList = [];

  void addWatchList(Content content, bool isAdded) {
    if (isAdded) {
      watchList.remove(content);
    } else {
      watchList.add(content);
    }
    notifyListeners();
  }

  bool isAdded(Content content) {
    return watchList.contains(content);
  }

  List<Content> get items {
    return [..._items];
  }
}
