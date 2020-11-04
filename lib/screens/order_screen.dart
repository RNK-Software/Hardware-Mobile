import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/label_text_form_field.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _signinFormKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;
    AssetImage assetImage = AssetImage('asset/images/signin.png');
    Image image = Image(
      image: assetImage,
      width: screenWidth * 0.4,
    );
    return Scaffold(
      body: Builder(
        builder: (context) => Form(
          key: _signinFormKey,
          child: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Container(height: 50),
                Center(
                  child: Container(
                    child: image,
                  ),
                ),
                Container(
                  height: 30,
                ),

                //Name
                LabelTextFormField(
                  labelText: "Name",
                  controller: _nameController,
                ),

                //Name
                LabelTextFormField(
                  labelText: "Address",
                  controller: _addressController,
                ),

                //State Number
                LabelTextFormField(
                  labelText: "State",
                  controller: _stateController,
                ),

                //City
                LabelTextFormField(
                  labelText: "City",
                  controller: _cityController,
                ),

                //Login button
                if (_isLoading)
                  Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor,
                      ))
                else
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.18, vertical: 30.0),
                    child: ButtonTheme(
                      height: 30,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        color: Colors.black54,
                        textColor: Colors.white,
                        child: Text(
                          'SUBMIT ORDER',
                          textScaleFactor: 1.3,
                        ),
                        onPressed: () {
                          if (_signinFormKey.currentState.validate()) {
                            //Order
                          }
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
