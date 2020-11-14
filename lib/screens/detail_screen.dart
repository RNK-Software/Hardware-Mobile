import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hardwaremobile/modals/cartItem_model.dart';
import 'package:hardwaremobile/providers/ProductProvider.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _n = 0;

  void addtoCartHandler(ProductProvider productProvider, String productName,
      String productPrice, int productQuantity) {
    CartItem item = new CartItem(
        itemName: productName, price: productPrice, quantity: productQuantity);
    productProvider.setCartItems(item);
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;

    final name = ModalRoute.of(context).settings.arguments;
    var productProvider = Provider.of<ProductProvider>(context);
    final product = productProvider.getProduct(name);

    void add() {
      setState(() {
        _n = _n + 1;
      });

      print(_n);
    }

    void minus() {
      setState(() {
        if (_n != 0) _n--;
      });
    }

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        title: Text(product.name),
        backgroundColor: Colors.grey[300],
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: 20, left: screenWidth * 0.06, right: screenWidth * 0.06),
        child: Center(
          child: ListView(
            children: [
              Container(
                height: 20,
              ),
              Image.network(product.imageUrl),
              Container(
                height: 20,
              ),
              Center(
                child: Text(product.name, //Name
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 25)),
              ),
              Center(
                child: Text(product.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54, fontSize: 15)),
              ),
              Container(
                height: 20,
              ),
              Center(
                child: Text("Rs.${product.price}", //Price
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 20)),
              ),
              Container(
                height: 50,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: ButtonTheme(
                      height: 30,
                      minWidth: screenWidth * 0.38,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FloatingActionButton(
                              heroTag: "btn1",
                              onPressed: add,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.grey,
                            ),
                            Text('$_n',
                                style: TextStyle(
                                    fontSize: 40.0, color: Colors.grey)),
                            FloatingActionButton(
                              heroTag: "btn2",
                              onPressed: minus,
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: ButtonTheme(
                      height: 50,
                      minWidth: screenWidth * 0.38,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        color: Colors.black54,
                        textColor: Colors.white,
                        child: Text(
                          '+ ADD TO CART',
                          textScaleFactor: 1.3,
                        ),
                        onPressed: _n > 0
                            ? () {
                                this.addtoCartHandler(
                                    productProvider, name, product.price, _n);
                              }
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
