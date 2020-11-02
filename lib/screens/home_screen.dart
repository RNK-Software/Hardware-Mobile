import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    AssetImage assetImage = AssetImage('asset/images/signin.png');
    Image image = Image(image: assetImage, width: screenWidth * 0.4);

    return Scaffold(
      body: Column(
        children: [
          Container(height: 50,),
          Center(
            child: Container(
              child: image,
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Theme.of(context).accentColor,
                  elevation: 2.0,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.hardware,
                        color: Colors.grey,
                      ),
                    ),
                    title: Text("Category", //data.name[index]
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                    onTap: () {
                      Navigator.pushNamed(context, '/detail');
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
