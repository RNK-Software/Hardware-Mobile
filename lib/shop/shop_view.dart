import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './shop_view_model.dart';
import 'state/tabbar_change.dart';
import 'widget/shop_card.dart';

class ShopView extends ShopViewModel {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: buildChangeBody(),
    );
  }

  ChangeNotifierProvider<TabBarChange> buildChangeBody() {
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
        itemCount: shopList.length,
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
        color: tabBarNotifier.index == index ? Theme.of(context).accentColor : Colors.grey[300],
        onPressed: () => headerListChangePosition(index),
        child: Text("${shopList[index].categoryName} $index"),

      ),
    );
  }
}
