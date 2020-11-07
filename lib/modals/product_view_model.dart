import 'package:flutter/material.dart';
import 'package:hardwaremobile/modals/product.dart';
import 'package:hardwaremobile/modals/product_model.dart';
import 'package:hardwaremobile/providers/ProductProvider.dart';
import 'package:hardwaremobile/shop/model/shop_helper.dart';
import 'package:hardwaremobile/shop/shop.dart';
import 'package:hardwaremobile/shop/state/tabbar_change.dart';
import 'package:provider/provider.dart';

abstract class ProductViewModel extends State<Shop> {
  ScrollController scrollController = ScrollController();
  int currentCategoryIndex = 0;
  ScrollController headerScrollController = ScrollController();

  List<ProductModel> productList = [];

  @override
  void didChangeDependencies() {
    var productProvider = Provider.of<ProductProvider>(context);
    productList = productProvider.getProducts();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    //var productProvider = Provider.of<ProductProvider>(context);
    //productList = productProvider.getProducts();
    super.initState();
    /*productList = List.generate(
      10,
      (index) => ProductModel(
        categoryName: "Hello",
        products: List.generate(
          6,
          (index) => ProductModal(
              category: "cat",
              description: "des",
              name: "name",
              price: "price",
              imageUrl: "ff"),
        ),
      ),
    );*/

    scrollController.addListener(() {
      final index = productList
          .indexWhere((element) => element.position >= scrollController.offset);
      tabBarNotifier.changeIndex(index);

      headerScrollController.animateTo(
          index * (MediaQuery.of(context).size.width * 0.2),
          duration: Duration(seconds: 1),
          curve: Curves.decelerate);
    });
  }

  void headerListChangePosition(int index) {
    scrollController.animateTo(productList[index].position,
        duration: Duration(seconds: 1), curve: Curves.ease);
  }

  double oneItemHeight = 0;

  void fillListPositionValues(double val) {
    if (oneItemHeight == 0) {
      oneItemHeight = val;
      productList.asMap().forEach((key, value) {
        if (key == 0) {
          productList[key].position = 0;
        } else {
          productList[key].position = getShopListPosition(val, key);
        }
      });
    }
  }

  double getShopListPosition(double val, int index) =>
      val *
          (productList[index].products.length / ShopHelper.GRID_COLUMN_VALUE) +
      productList[index - 1].position;
}
