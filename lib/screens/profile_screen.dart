import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/label_text_form_field.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _signinFormKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
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
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.grey[300],
      ),
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

                //Phone Number
                LabelTextFormField(
                  labelText: "Number",
                  controller: _numberController,
                  keyboardType: TextInputType.number,
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
                      height: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: Text(
                          'UPDATE',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (_signinFormKey.currentState.validate()) {
                            //Update
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
