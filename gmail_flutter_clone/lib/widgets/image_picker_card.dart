import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gmail_flutter_clone/providers/auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({Key key}) : super(key: key);

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File _image;
  @override
  Widget build(BuildContext context) {
    var _authProvider = Provider.of<AuthProvider>(context);
    return InkWell(
      onTap: () {
        _authProvider
            .pickImageSource(imageSource: ImageSource.gallery, context: context)
            .then((image) {
          setState(() {
            _image = image;
          });
          if (image != null) {
            _authProvider.isPicAvailable = true;
          }
        });
      },
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.red[700])),
        child: _image == null
            ? Icon(
                Icons.camera_alt,
                color: Colors.red[700],
              )
            : SizedBox(
                height: 120,
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image(
                    fit: BoxFit.fill,
                    image: FileImage(_image),
                  ),
                ),
              ),
      ),
    );
  }
}
