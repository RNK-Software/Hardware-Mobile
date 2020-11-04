import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

int _n = 0;

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;

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
        title: Text("Hammer"),
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
              Image.network(
                'https://www.qy1.de/img/japanischer-klauenhammer-313410.jpg',
              ),
              Container(
                height: 20,
              ),
              Center(
                child: Text('Hammer', //Name
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 25)),
              ),
              Center(
                child: Text(
                    'Description is the pattern of narrative development that aims to make vivid a place, object, character, or group. Description is one of four rhetorical modes, along with exposition, argumentation, and narration. In practice it would be difficult to write literature that drew on just one of the four basic modes.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54, fontSize: 15)),
              ),
              Container(
                height: 20,
              ),
              Center(
                child: Text('Rs 500', //Price
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

                            Text('$_n', style: TextStyle(fontSize: 40.0, color: Colors.grey)),

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
                        onPressed: () {
                          //Cart
                        },
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
