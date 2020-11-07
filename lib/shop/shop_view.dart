import 'package:flutter/material.dart';
import 'package:hardwaremobile/providers/ProductProvider.dart';
import 'package:provider/provider.dart';

import '../modals/product_view_model.dart';
import 'state/tabbar_change.dart';
import 'widget/shop_card.dart';

class ShopView extends ProductViewModel {
  var _isLoading = false;
  var isLoaded = false;
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration.zero).then((_) => {
          Provider.of<ProductProvider>(context, listen: false)
              .fetchProducts()
              .then((_) {
            setState(() {
              _isLoading = false;
            });
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(shopList[0]);
    //var productProvider = Provider.of<ProductProvider>(context);
    //var products = productProvider.getProducts();
    //print(products);

    //methana products tika array ekaka save wenawa
    /*
      me format eken 

      products = [
        {
          name: ...,
          imageUrl; ...,
          price: ...,
          description: ...,
          category: ...
        },
        {
          name: ...,
          imageUrl; ...,
          price: ...,
          description: ...,
          category: ...,
        },
      ];

      isLoading eka true wenawa load weddi eka false da kiyala balala ita passe products array eken products render karanna. is loading true nan spinner ekak danna
    */
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 500,
        title: TextField(
          onChanged: (value) {
            setState(() {
              // searchTerm = value;
            });
          },
          decoration: InputDecoration(
              hintText: "Search Item",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.black12,
              isDense: true,
              contentPadding: EdgeInsets.all(8)),
        ),
        iconTheme: new IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              //search
            },
            color: Colors.black54,
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            color: Colors.black54,
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            color: Colors.black54,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.purple,
              ),
            )
          : ChangeNotifierProvider.value(
              value: tabBarNotifier,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Consumer<TabBarChange>(
                        builder: (context, value, child) => ListView.builder(
                          itemCount: productList.length,
                          controller: headerScrollController,
                          padding: EdgeInsets.all(10),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: RaisedButton(
                              color: tabBarNotifier.index == index
                                  ? Theme.of(context).accentColor
                                  : Colors.grey[300],
                              onPressed: () => headerListChangePosition(index),
                              child: Text("${productList[index].categoryName}"),
                            ),
                          ),
                        ),
                      )),
                  Divider(),
                  Expanded(
                      flex: 9,
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: productList.length + 1,
                        itemBuilder: (context, index) {
                          print(index);
                          if (index == productList.length)
                            return Container(height: oneItemHeight * 2);
                          else
                            return ShopCard(
                              model: productList[index],
                              index: index,
                              onHeight: (val) {
                                fillListPositionValues(val);
                              },
                            );
                        },
                      )),
                ],
              ),
            ),
    );
  }

  /*ChangeNotifierProvider<TabBarChange> buildChangeBody() {
    return ChangeNotifierProvider.value(
      value: tabBarNotifier,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: buildListViewHeader),
          Divider(),
          Expanded(flex: 9, child: buildListViewShop),
        ],
      ),
    );
  }

  ListView get buildListViewShop {
    return ListView.builder(
      controller: scrollController,
      itemCount: shopListAndSpaceAreaLength,
      itemBuilder: (context, index) {
        print(index);
        if (index == shopListLastIndex)
          return emptyWidget;
        else
          return ShopCard(
            model: shopList[index],
            index: index,
            onHeight: (val) {
              fillListPositionValues(val);
            },
          );
      },
    );
  }

  int get shopListAndSpaceAreaLength => shopList.length + 1;

  int get shopListLastIndex => shopList.length;

  Container get emptyWidget => Container(height: oneItemHeight * 2);

  Widget get buildListViewHeader {
    return Consumer<TabBarChange>(
      builder: (context, value, child) => ListView.builder(
        itemCount: products.length,
        controller: headerScrollController,
        padding: EdgeInsets.all(10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => buildPaddingHeaderCard(index),
      ),
    );
  }

  Padding buildPaddingHeaderCard(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: RaisedButton(
        color: tabBarNotifier.index == index
            ? Theme.of(context).accentColor
            : Colors.grey[300],
        onPressed: () => headerListChangePosition(index),
        child: Text("${products[index].category}"),
      ),
    );
  }*/
}
