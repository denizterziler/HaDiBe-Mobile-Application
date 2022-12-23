import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_380_project/Models/content.dart';
import 'package:se_380_project/Providers/content_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rate extends StatefulWidget {
  static const routeName = '/rate';

  const Rate({Key? key}) : super(key: key);

  @override
  State<Rate> createState() => _RateState();
}

class _RateState extends State<Rate> {
  late double _total;

  @override
  Widget build(BuildContext context) {
    var contentName = ModalRoute.of(context)?.settings.arguments as String;
    var loadedContent = Provider.of<ContentProvider>(context)
        .items
        .firstWhere((element) => element.name == contentName);
    _total = loadedContent.rate * loadedContent.rateCount;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Rating of ${loadedContent.name}",
        ),
      ),
      body: Container(
        color: Colors.black38,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "Current rate of ${loadedContent.name} is ${loadedContent.rate.toStringAsFixed(2)}"),
              RatingBar.builder(
                  minRating: 1,
                  initialRating: 1,
                  itemCount: 10,
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    setState(() {
                      print(rating);
                      rating == 10.0 ? loadedContent.hadiBe++ : null;
                      print("total before $_total");
                      loadedContent.rateCount++;
                      print("loaded rate before ${loadedContent.rate}");
                      loadedContent.rate = (_total + rating) / loadedContent.rateCount;
                      print("loaded rate after ${loadedContent.rate}");
                      _total += rating;
                      print("total after $_total");
                      //loadedContent.addListener(() { });
                      loadedContent.notifyListeners();
                    });
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    width: 300,
                    height: 100,
                    color: Colors.red,
                    child: Center(
                      child: Text(
                       "${loadedContent.hadiBe} HaDiBe",
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
