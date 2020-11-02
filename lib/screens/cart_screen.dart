import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: Colors.grey[300],
      ),
      body: ListView(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Theme.of(context).accentColor,
                  elevation: 2.0,
                  child: ListTile(
                    leading: Text("5", //amount
                        style: TextStyle(color: Colors.black, fontSize: 25)),
                    title: Text("Hammer", //name
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                    subtitle: Text("Rs 500", //price
                        style: TextStyle(color: Colors.black54)),
                  ),
                );
              },
            ),
          ),
          Divider(),
          //Name

          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ButtonTheme(
                height: 30,
                minWidth: screenWidth * 0.47,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: Colors.grey,
                  textColor: Colors.white,
                  child: Text(
                    'Rs 4000', //total
                    textScaleFactor: 1,
                  ),
                  onPressed: () {},
                ),
              ),
              ButtonTheme(
                height: 30,
                minWidth: screenWidth * 0.47,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text(
                    'PLACE ORDER',
                    textScaleFactor: 1,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/order');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
