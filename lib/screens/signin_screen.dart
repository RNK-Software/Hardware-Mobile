import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hardwaremobile/shop/shop.dart';
import '../widgets/label_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  var _signinFormKey = GlobalKey<FormState>();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _codeController = TextEditingController();

  var _isLoading = false;

  Future<void> handleSignin(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
        phoneNumber: _numberController.text.trim(),
        verificationCompleted: (AuthCredential authCredential) {
          auth
              .signInWithCredential(authCredential)
              .then((AuthResult result) => {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Shop()))
                  })
              .catchError((e) {
            print(e);
          });
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                    title: Text("Enter OTP Code"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _codeController,
                        )
                      ],
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          FirebaseAuth auth = FirebaseAuth.instance;
                          var _smsCode = _codeController.text.trim();
                          var _credential = PhoneAuthProvider.getCredential(
                              verificationId: verificationId,
                              smsCode: _smsCode);
                          auth
                              .signInWithCredential(_credential)
                              .then((AuthResult result) => {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Shop()))
                                  })
                              .catchError((e) {
                            print(e);
                          });
                        },
                        child: Text("Done"),
                      )
                    ],
                  ));
        },
        timeout: Duration(seconds: 60),
        verificationFailed: (AuthException e) {
          print(e.message);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("Timout");
        });
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;
    AssetImage assetImage = AssetImage('asset/images/signin.png');
    Image image = Image(
      image: assetImage,
      width: screenWidth * 0.7,
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
                  keyboardType: TextInputType.phone,
                ),
                Center(child: Text("Eg: +94711234567")),

                //Login button
                if (_isLoading)
                  Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  ))
                else
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.18, vertical: 10.0),
                    child: ButtonTheme(
                      height: 30,
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
                            //Navigator.pushNamed(context, '/shop');
                            handleSignin(context);
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
