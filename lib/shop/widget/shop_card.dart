import 'package:flutter/material.dart';
import '../model/shop_helper.dart';
import '../model/shop_model.dart';

class ShopCard extends StatelessWidget {
  final ShopModel model;
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
        Text("${model.categoryName} $index"),
        Card(
          child: buildGridViewProducts(index, model.products),
        ),
      ],
    );
  }

  GridView buildGridViewProducts(int index, List<Product> products) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: ShopHelper.GRID_COLUMN_VALUE),
      itemBuilder: (context, index) {
        return  GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/detail');
          },
          child: Card(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://thumbs.dreamstime.com/b/red-hammer-white-background-isolated-34702875.jpg"), //products[index].image
                      fit: BoxFit.cover)),
              child: Text(products[index].name+"\nRs 500",),
            ),

          ),
        );

      },
    );
  }
}
