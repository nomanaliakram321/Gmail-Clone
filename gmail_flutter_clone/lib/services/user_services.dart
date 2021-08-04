import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:gmail_flutter_clone/models/user_model.dart';

class UserServices {
  var user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  firebase_storage.Reference imageUrl =
      firebase_storage.FirebaseStorage.instance.ref().child('profilePicture');
  // User user = FirebaseAuth.instance.currentUser;
  storeUserData({user, email, username, password, imageUrl}) {
    users.doc(email).set({
      'email': email,
      'username': username,
      'password': password,
      // 'imageUrl': imageUrl,
      'uid': user.uid
    });
  }
}
