import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:hardwaremobile/modals/product.dart';
import 'package:hardwaremobile/shop/model/shop_model.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModal> _products = [];

  Future<void> fetchProducts() async {
    try {
      final List<ProductModal> loadedProducts = [];
      final responce =
          await Firestore.instance.collection('products').getDocuments();
      responce.documents.forEach((product) {
        loadedProducts.add(ProductModal(
            name: product['name'],
            imageUrl: product['imageUrl'],
            description: product['description'],
            price: product['price']));
      });
      _products = loadedProducts;
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  List<ProductModal> getProducts() {
    return _products;
  }
}
