import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider with ChangeNotifier {
  File imagePath;
  String imagePickerError = '';
  bool isPicAvailable = false;
  String error = '';
  String email;
  //imagePicker Function
  Future pickImageSource({ImageSource imageSource, context}) async {
    final picker = ImagePicker();
    final image = await picker.getImage(
      source: imageSource,
    );
    if (image != null) {
      this.imagePath = File(image.path);
      // Navigator.pop(context);
      notifyListeners();
    } else {
      this.imagePickerError = 'No Image Selected';
      notifyListeners();
    }
    return this.imagePath;
  }
  //

  // Future<Widget> pickImageDialogue(context) {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return SimpleDialog(
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //           children: [
  //             SimpleDialogOption(
  //               onPressed: () {
  //                 pickImageSource(
  //                     imageSource: ImageSource.gallery, context: context);
  //               },
  //               child: Row(
  //                 children: [
  //                   Icon(Icons.image),
  //                   SizedBox(
  //                     width: 15,
  //                   ),
  //                   Text('From Gallery'),
  //                 ],
  //               ),
  //             ),
  //             SimpleDialogOption(
  //               onPressed: () {
  //                 pickImageSource(
  //                     imageSource: ImageSource.camera, context: context);
  //               },
  //               child: Row(
  //                 children: [
  //                   Icon(Icons.camera_alt),
  //                   SizedBox(
  //                     width: 15,
  //                   ),
  //                   Text('From Camera'),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         );
  //       });
  // }

  Future<UserCredential> registerUser(email, password) async {
    this.email = email;
    notifyListeners();
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        this.error = 'The password provided is too weak';
        notifyListeners();
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        this.error = 'The account already exists for that email';
        notifyListeners();
        print('The account already exists for that email.');
      }
    } catch (e) {
      this.error = e.toString();
      notifyListeners();
      print(e);
    }
    return userCredential;
  }

  Future<void> UploadDataToFirebase(
      {String url,
      String firstName,
      String lastName,
      String email,
      String phone}) {
    User user = FirebaseAuth.instance.currentUser;
    DocumentReference _users =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    _users.set({
      'firstName': firstName,
      'lastName': lastName,
      'email': this.email,
      'imagUrl': url,
      'uid': user.uid,
      'phone': phone
    });
    return null;
  }

  Future<UserCredential> loginUser(email, password) async {
    this.email = email;
    notifyListeners();
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      this.error = e.code;
      notifyListeners();
    } catch (e) {
      this.error = e.code;
      notifyListeners();
      print(e);
    }
    return userCredential;
  }
}
