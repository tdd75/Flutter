import 'package:flutter/cupertino.dart';

import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Book',
      description: 'Chinese martial arts book',
      price: 10,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/d/d0/Liji2_no_bg.png',
    ),
    Product(
        id: 'p2',
        title: 'Shoe',
        description: 'Biti\'s Hunter X',
        price: 35,
        imageUrl:
            'https://image.voso.vn/users/vosoimage/images/215c006f94e0987c894f5c8c7a809cd2?t%5B0%5D=compress%3Alevel%3D100&accessToken=80b761605a3a5be335b60e3eb4d3117d56e26bebb6cdedddb52119643ba3b16e'),
    Product(
      id: 'p3',
      title: 'Watch',
      description: 'Apple Watch Series 7',
      price: 10,
      imageUrl:
          'https://cdn.tgdd.vn/Files/2021/05/20/1353189/apple-watch-series-7-1_800x450.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Laptop',
      description: 'Macbook Pro 16\" 2019',
      price: 2000,
      imageUrl:
          'https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/QuanLNH2/macbook-pro-16-1.JPG',
    ),
    Product(
      id: 'p5',
      title: 'Cake',
      description: 'Chocopie (20 packs)',
      price: 4,
      imageUrl:
          'https://salt.tikicdn.com/cache/w1200/ts/product/61/94/4c/8d0ad8659d4f2d003cde811995e833b3.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void addProduct(Product product) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    _items.add(newProduct);
    // _items.insert(0, newProduct);
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
