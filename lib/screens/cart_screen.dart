import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hardwaremobile/modals/cartItem_model.dart';
import 'package:hardwaremobile/providers/ProductProvider.dart';
import 'package:hardwaremobile/shop/model/shop_model.dart';
import 'package:provider/provider.dart';
import '../widgets/label_text_form_field.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;

    var productProvider = Provider.of<ProductProvider>(context);
    List<CartItem> cartItems = productProvider.getCartItems();
    double price = 0;
    cartItems.forEach((element) {
      price = price + double.parse(element.price) * element.quantity;
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 500,
        title: Text(
          "MY CART",
          style: TextStyle(color: Colors.black54),
        ),
        iconTheme: new IconThemeData(color: Colors.black54),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '/shop');
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cartItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Theme.of(context).accentColor,
                  elevation: 2.0,
                  child: ListTile(
                    leading: Text(cartItems[index].quantity.toString(), //amount
                        style: TextStyle(color: Colors.black, fontSize: 25)),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_forever,
                      ),
                      iconSize: 30,
                      color: Colors.red,
                      splashColor: Colors.purple,
                      onPressed: () {
                        //Remove it
                        productProvider
                            .deleteCartItem(cartItems[index].itemName);
                      },
                    ),
                    title: Text(cartItems[index].itemName, //name
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                    subtitle: Text("Rs. ${cartItems[index].price}", //price
                        style: TextStyle(color: Colors.black54)),
                  ),
                );
              },
            ),
          ),
          Divider(),
          //Name
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Center(
                      child: Text("Total : Rs ${price.toString()}",
                          style:
                              TextStyle(color: Colors.black54, fontSize: 18))),
                ),
                Expanded(
                  flex: 5,
                  child: ButtonTheme(
                    height: 30,
                    minWidth: screenWidth * 0.47,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.black54,
                      textColor: Colors.white,
                      child: Text(
                        'PLACE ORDER',
                        textScaleFactor: 1,
                      ),
                      onPressed: cartItems.length > 0
                          ? () {
                              Navigator.pushNamed(context, '/order');
                            }
                          : null,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
