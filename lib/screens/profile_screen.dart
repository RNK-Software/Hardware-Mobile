import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hardwaremobile/modals/user_model.dart';
import 'package:hardwaremobile/providers/UserProvider.dart';
import 'package:hardwaremobile/screens/signin_screen.dart';
import 'package:hardwaremobile/widgets/label_text_form_field.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<UserProvider>(context, listen: false)
          .fetchUser()
          .then((_) {});
    });
    super.initState();
  }

  void updateNameHandler(String phone) {
    Firestore.instance
        .collection('users')
        .where('phoneNumber', isEqualTo: phone)
        .getDocuments()
        .then((documents) {
      documents.documents.forEach((element) {
        Firestore.instance
            .collection('users')
            .document(element.documentID)
            .updateData({'name': _nameController.text.trim()});
      });
    });
  }

  void updateAddressHandler(String phone) {
    Firestore.instance
        .collection('users')
        .where('phoneNumber', isEqualTo: phone)
        .getDocuments()
        .then((documents) {
      documents.documents.forEach((element) {
        Firestore.instance
            .collection('users')
            .document(element.documentID)
            .updateData({'address': _addressController.text.trim()});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    UserModel user = userProvider.getUser();
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 500,
          title: Text(
            "MY PROFILE",
            style: TextStyle(color: Colors.black54),
          ),
          iconTheme: new IconThemeData(color: Colors.black54),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushNamed(context, '/shop');
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
            ),
          ],
        ),
        body: new Stack(
          children: <Widget>[
            ClipPath(
              child: Container(color: Colors.black.withOpacity(0.8)),
              clipper: getClipper(),
            ),
            Positioned(
                width: 350.0,
                top: MediaQuery.of(context).size.height / 10,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://asisscientific.com.au/wp-content/uploads/2017/06/dummy-profile.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.all(Radius.circular(75.0)),
                              boxShadow: [
                                BoxShadow(blurRadius: 7.0, color: Colors.black)
                              ])),
                      SizedBox(height: 20.0),
                      Text(
                        'Name: ${user.name}',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        'Address: ${user.address}',
                        style: TextStyle(
                            fontSize: 17.0,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Montserrat'),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "Phone Number: ${user.phone}",
                        style:
                            TextStyle(fontSize: 17.0, fontFamily: 'Montserrat'),
                      ),
                      SizedBox(height: 15.0),
                      Center(
                        child: Text("Update Information"),
                      ),
                      LabelTextFormField(
                        labelText: "Enter Name",
                        controller: _nameController,
                      ),
                      FlatButton(
                          onPressed: () {
                            updateNameHandler(user.phone);
                          },
                          child: Text("Update Name")),

                      //Name
                      LabelTextFormField(
                        labelText: "Enter Address",
                        controller: _addressController,
                      ),
                      FlatButton(
                          onPressed: () {
                            updateAddressHandler(user.phone);
                          },
                          child: Text("Update Address")),
                      Container(
                        height: 30.0,
                        child: GestureDetector(
                          onTap: () {
                            //logout from here

                            FirebaseAuth.instance.signOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SigninScreen()));
                          },
                          child: Center(
                            child: Text(
                              'I want to log out',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'Montserrat',
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
