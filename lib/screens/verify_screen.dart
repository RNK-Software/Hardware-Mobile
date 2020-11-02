import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter_verification_code/flutter_verification_code.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  Timer _timer;
  int _start = 100;
  bool _loading = false;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;
    AssetImage assetImage = AssetImage('asset/images/verification.png');
    Image image = Image(
      image: assetImage,
      width: screenWidth * 0.8,
      height: screenHeight * 0.3,
    );

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: screenHeight * 0.1,
        ),
        child: Center(
          child: ListView(
            children: [
              Center(
                child: Container(
                  child: image,
                ),
              ),
              Center(
                child: Text(
                  "Verification",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 30),
                ),
              ),
              Container(height: 20),
              Center(
                child: Text(
                  "Enter the verification code we just sent you",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              Center(
                child: Text(
                  "on your mobile number",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              Container(height: 20),
              Center(
                child: Text(
                  "Remaining time : $_start secs",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              Center(
                child: VerificationCode(
                  textStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                  underlineColor: Theme.of(context).primaryColor,
                  keyboardType: TextInputType.number,
                  length: 6,
                  onCompleted: (String value) {
                    //on complete get code
                  },
                  onEditing: (bool value) {
                    setState(() {
                      //edit
                    });
                  },
                ),
              ),
              if (_loading)
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
                        'Verify',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        //verify function
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
