import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:hardwaremobile/modals/product.dart';
import 'package:hardwaremobile/modals/product_model.dart';
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
            imageUrl: product['pictureUrl'],
            description: product['description'],
            price: product['price'],
            category: product['category']));
      });
      _products = loadedProducts;
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  ProductModal getProduct(String name) {
    ProductModal product =
        _products.firstWhere((element) => element.name == name);
    return product;
  }

  List<ProductModel> getProducts() {
    /*
    returns 

    productList = [
      {
        categoryName: ...,
        products: [
          {
            name: 
            imageUrl: 
            description:
            price: 
            category:
          },
          {
            name: 
            imageUrl: 
            description:
            price: 
            category:
          }
        ]
      },
      {
        categoryName: ...,
        products: [
          {
            name: 
            imageUrl: 
            description:
            price: 
            category:
          },
          {
            name: 
            imageUrl: 
            description:
            price: 
            category:
          }
        ]
      },
    ]


    */
    List<ProductModel> productList = [];
    List<String> categories = [];
    _products.forEach((product) {
      if (!categories.contains(product.category)) {
        categories.add(product.category);
      }
    });

    categories.forEach((category) {
      List<ProductModal> products = [];

      _products.forEach((product) {
        if (product.category == category) {
          products.add(product);
        }
      });
      productList.add(ProductModel(categoryName: category, products: products));
    });

    return productList;
  }
}
