import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  Future<void> toggleFavoriteStatus() async {
    isFavorite = !isFavorite;
    notifyListeners();
    var url = Uri.parse(
        'https://shop-app-d7e86-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json');
    try {
      final response = await http.patch(url,
          body: json.encode({
            "isFavorite": isFavorite,
          }));
      if (response.statusCode > 400) {
        isFavorite = !isFavorite;
        notifyListeners();
      }
    } catch (error) {
      isFavorite = !isFavorite;
      notifyListeners();
    }
  }
}
