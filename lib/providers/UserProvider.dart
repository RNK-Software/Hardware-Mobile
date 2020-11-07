import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:hardwaremobile/modals/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel userSaved = UserModel(name: '', address: '', phone: '');

  Future<void> fetchUser() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      if (user != null) {
        userSaved.phone = user.phoneNumber;
        Firestore.instance
            .collection('users')
            .where("phoneNumber", isEqualTo: user.phoneNumber)
            .getDocuments()
            .then((document) {
          document.documents.forEach((element) {
            userSaved.address = element['address'];
            userSaved.name = element['name'];
          });
        });
      }
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  UserModel getUser() {
    return userSaved;
  }
}
