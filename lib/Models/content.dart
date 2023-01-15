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
  bool isLiked;
  late double rate;
  late double rateCount;
  late int hadiBe;

  Content({
    required this.name,
    required this.type,
    required this.platform,
    required this.category,
    required this.imageUrl,
    required this.length,
    required this.description,
    this.isFavorite = false,
    this.isLiked = false,
    required this.rate,
    required this.rateCount,
    required this.hadiBe,
  });

  void favoriteStatus(){
    isFavorite = !isFavorite;
    notifyListeners();
  }
  void likeStatus(){
    isLiked = !isLiked;
    notifyListeners();
  }
}