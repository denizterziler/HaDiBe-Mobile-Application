import 'package:flutter/material.dart';

class Content with ChangeNotifier{
  final String name;
  final String type;
  final String platform;
  final String category;
  final String imageUrl;
  final double length;
  final String description;
  bool isFavorite;
  late double rate;

  Content({
    required this.name,
    required this.type,
    required this.platform,
    required this.category,
    required this.imageUrl,
    required this.length,
    required this.description,
    this.isFavorite = false,
    required this.rate,
  });
  void favoriteStatus(){
    isFavorite = !isFavorite;
    notifyListeners();
  }
}