import 'package:flutter/material.dart';
import 'package:hardwaremobile/modals/product.dart';
import 'package:hardwaremobile/modals/product_model.dart';
import '../model/shop_helper.dart';
import '../model/shop_model.dart';

class ShopCard extends StatelessWidget {
  final ProductModel model;
  final int index;
  final Function(double val) onHeight;

  const ShopCard({Key key, this.model, this.index, this.onHeight})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onHeight((context.size.height) /
          (model.products.length / ShopHelper.GRID_COLUMN_VALUE));
    });
    return Column(
      children: [
        Divider(),
        Text("${model.categoryName}"),
        Card(
          child: buildGridViewProducts(index, model.products),
        ),
      ],
    );
  }

  GridView buildGridViewProducts(int index, List<ProductModal> products) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: ShopHelper.GRID_COLUMN_VALUE),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/detail',
                arguments: products[index].name);
          },
          child: Card(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          products[index].imageUrl), //products[index].image
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  Text(
                    products[index].name,
                  ),
                  Text(
                    "Rs.${products[index].price}",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
