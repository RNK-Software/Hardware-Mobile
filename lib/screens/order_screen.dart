import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hardwaremobile/modals/cartItem_model.dart';
import 'package:hardwaremobile/modals/user_model.dart';
import 'package:hardwaremobile/providers/ProductProvider.dart';
import 'package:hardwaremobile/providers/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _signinFormKey = GlobalKey<FormState>();
  var _isLoading = false;
  //map
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  Location _location = Location();
  List<Marker> marker = [];
  //marker location
  LatLng position;

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.getLocation().then((value) => {
          setState(() {
            marker.add(Marker(
                markerId: MarkerId('delivery location'),
                draggable: true,
                onDragEnd: (LatLng location) {
                  position = location;
                },
                position: LatLng(value.latitude, value.longitude)));
          }),
          position = LatLng(value.latitude, value.longitude)
        });
  }

  void submitHandler(UserModel user, List<CartItem> cartItems) {
    print(cartItems[0].itemName);
    Map<String, dynamic> newOrder;

    var items = [];
    cartItems.forEach((element) {
      var newItem = {
        "itemName": element.itemName,
        "price": element.price,
        "quantity": element.quantity
      };
      items.add(newItem);
    });

    newOrder = {
      "userName": user.name,
      "address": user.address,
      "contactNumber": user.phone,
      "lat": position.latitude,
      "lon": position.longitude,
      "cartItems": items,
    };

    Firestore.instance
        .collection('orders')
        .add(newOrder)
        .then((value) => {print("order submitted!!!!!!!!!!!!!!")})
        .catchError((error) => print("errorr!!!!!!!!!" + error));
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

    var userProvider = Provider.of<UserProvider>(context);
    UserModel user = userProvider.getUser();
    var productProvider = Provider.of<ProductProvider>(context);
    var cartItems = productProvider.getCartItems();

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
                user.name.isEmpty || user.address.isEmpty
                    ? Center(
                        child: Text(
                          "Please update name and address in profile screen before placing an order",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    : Column(
                        children: [
                          Center(
                            child: Text("Name: ${user.name}"),
                          ),
                          Center(
                            child: Text("Address: ${user.address}"),
                          ),
                        ],
                      ),

                Container(
                  width: screenWidth,
                  height: 350,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    onTap: (location) {
                      setState(() {
                        marker.add(Marker(
                            markerId: MarkerId('delivery location'),
                            draggable: true,
                            onDragEnd: (LatLng location) {
                              position = location;
                            },
                            position: location));
                      });
                      position = location;
                    },
                    markers: Set.from(marker),
                    myLocationEnabled: true,
                    gestureRecognizers: Set()
                      ..add(Factory<ScaleGestureRecognizer>(
                          () => ScaleGestureRecognizer())),
                    initialCameraPosition:
                        CameraPosition(target: _initialcameraposition),
                    onMapCreated: _onMapCreated,
                  ),
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
                        onPressed: user.name.isEmpty || user.address.isEmpty
                            ? null
                            : () {
                                if (_signinFormKey.currentState.validate()) {
                                  submitHandler(user, cartItems);
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
