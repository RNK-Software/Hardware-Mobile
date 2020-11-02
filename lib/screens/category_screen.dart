import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bordered_text/bordered_text.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          elevation: 0,
          title: TextField(
            onChanged: (value) {
              setState(() {
                // searchTerm = value;
              });
            },
            decoration: InputDecoration(
                hintText: "Search Item",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.black12,
                isDense: true,
                contentPadding: EdgeInsets.all(8)),
          ),
          iconTheme: new IconThemeData(color: Colors.white),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //search
              },
              color: Colors.white,
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
              color: Colors.white,
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              color: Colors.white,
            ),
          ],
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(20, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/detail');
              },
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://www.qy1.de/img/japanischer-klauenhammer-313410.jpg"),
                          fit: BoxFit.cover)),
                  child: Center(
                    child: Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 30,
                          ),
                          BorderedText(
                            strokeWidth: 4.0,
                            strokeColor: Colors.black,
                            child: Text(
                              'Item ' + index.toString(), //name
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                                decoration: TextDecoration.none,
                                decorationColor: Colors.black,
                              ),
                            ),
                          ),
                          BorderedText(
                            strokeWidth: 4.0,
                            strokeColor: Colors.black,
                            child: Text(
                              'Rs 500', //price
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                decoration: TextDecoration.none,
                                decorationColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
