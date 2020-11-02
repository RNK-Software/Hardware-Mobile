import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/label_text_form_field.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  var _signinFormKey = GlobalKey<FormState>();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;
    AssetImage assetImage = AssetImage('asset/images/signin.png');
    Image image = Image(
      image: assetImage,
      width: screenWidth * 0.5,
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

                //Phone Number
                LabelTextFormField(
                  labelText: "Phone Number",
                  controller: _numberController,
                  keyboardType: TextInputType.number,
                ),

                //Password
                LabelTextFormField(
                  labelText: "Password",
                  controller: _passwordController,
                  isObscure: true,
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
                          'Sign In',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (_signinFormKey.currentState.validate()) {
                            Navigator.pushNamed(context, '/home');
                          }
                        },
                      ),
                    ),
                  ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1, vertical: 8.0),
                  child: Center(
                    child: Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1, vertical: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor),
                      ),
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
