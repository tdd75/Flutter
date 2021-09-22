import 'package:flutter/cupertino.dart';
import '../providers/cart.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  final String? authToken;
  final String? userId;
  List<OrderItem> _orders = [];

  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
        'https://shop-app-d7e86-default-rtdb.asia-southeast1.firebasedatabase.app/orders/$userId.json?auth=$authToken');
    try {
      final response = await http.get(url);
      if (response.body == 'null') {
        _orders = [];
        notifyListeners();
        return;
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<OrderItem> loadedOrders = [];
      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(OrderItem(
          id: orderId,
          dateTime: DateTime.parse(orderData['dateTime']),
          amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                    id: item['id'],
                    price: item['price'],
                    quantity: item['quantity'],
                    title: item['title'],
                  ))
              .toList(),
        ));
      });
      _orders = loadedOrders;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    try {
      final url = Uri.parse(
          'https://shop-app-d7e86-default-rtdb.asia-southeast1.firebasedatabase.app/orders/$userId.json?auth=$authToken');
      final response = await http.post(url,
          body: json.encode({
            "amount": total,
            "products": cartProducts
                .map((cp) => {
                      "id": cp.id,
                      "title": cp.title,
                      "price": cp.price,
                      "quantity": cp.quantity,
                    })
                .toList(),
            "dateTime": DateTime.now().toIso8601String(),
          }));
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartProducts,
          dateTime: DateTime.now(),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
