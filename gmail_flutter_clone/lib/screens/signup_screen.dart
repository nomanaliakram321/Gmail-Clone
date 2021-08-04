import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gmail_flutter_clone/providers/auth_provider.dart';
import 'package:gmail_flutter_clone/screens/home_screen.dart';
import 'package:gmail_flutter_clone/screens/signin_screen.dart';
import 'package:gmail_flutter_clone/services/user_services.dart';
import 'package:gmail_flutter_clone/widgets/image_picker_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signup-screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  var _emailTextController = TextEditingController();
  var _passwordTextController = TextEditingController();
  var _firstName = TextEditingController();
  var _lastName = TextEditingController();
  var _number = TextEditingController();
  String countryCode = '';
  String password;
  var _confirmpasswordTextController = TextEditingController();
  UserServices _userServices = UserServices();
  User user = FirebaseAuth.instance.currentUser;

  var scaffoldkey = GlobalKey<ScaffoldState>();
  Future<String> uploadFile(filePath) async {
    File file = File(filePath);

    void _onCountryChange(CountryCode countryCode) {
      //TODO : manipulate the selected country code here
      print("New Country selected: " + countryCode.toString());
      countryCode = countryCode;
    }

    FirebaseStorage _storage = FirebaseStorage.instance;
    try {
      await _storage
          .ref('uploads/Profile/${_emailTextController.text}')
          .putFile(file);
    } on FirebaseException catch (e) {
      print(e.code);
      // e.g, e.code == 'canceled'
    }
    String downloadURL = await _storage
        .ref('uploads/Profile/${_emailTextController.text}')
        .getDownloadURL();
    return downloadURL;
  }
  // registerUser() async {
  //   try {
  //     // String downloadPic = imagePath == null
  //     //     ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/1024px-Circle-icons-profile.svg.png'
  //     //     : await uploadFile(imagePath.path);
  //     FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(
  //             email: _email.text + 'gmail.com', password: _password.text)
  //         .then((value) {
  //       _userServices.storeUserData(
  //           email: _email.text + 'gmail.com',
  //           user: user.uid,
  //           password: _password.text,
  //           username: _email.text,
  //           imageUrl: imagePath);
  //     });
  //   } catch (e) {
  //     SnackBar snackBar = SnackBar(content: Text(e.toString()));
  //     scaffoldkey.currentState.showSnackBar(snackBar);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    ProgressDialog progressDialog = ProgressDialog(
      context: context,
      backgroundColor: Colors.white,
      progressIndicatorColor: Colors.red,
      textColor: Colors.red,
    );
    var _auhtProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: scaffoldkey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Sign Up',
          style: TextStyle(color: Colors.red[700], fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                ),
                ProfilePicture(),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _firstName,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Enter First Name';
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: new InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 10),
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(15.0),
                              ),
                            ),
                            filled: true,
                            labelText: 'First Name',
                            hintStyle: new TextStyle(color: Colors.grey),
                            hintText: "First Name",
                            fillColor: Colors.white70),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _lastName,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Enter Last Name';
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: new InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 10),
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(15.0),
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(color: Colors.grey),
                            hintText: "Last Name",
                            labelText: 'Last Name',
                            fillColor: Colors.white70),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter UserName';
                    }
                    // final bool isvalid =
                    //     EmailValidator.validate(_emailTextController.text);
                    // if (!isvalid) {
                    //   return 'Invalid Email';
                    // }
                    return null;
                  },
                  controller: _emailTextController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: new InputDecoration(
                      suffix: Text('gmail.com'),
                      prefixIcon: Icon(CupertinoIcons.profile_circled),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(15.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(color: Colors.grey[800]),
                      hintText: "Type in your Username",
                      fillColor: Colors.white70),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter Password';
                    }
                    if (value.length < 6) {
                      return 'Minimum 6 characters';
                    }
                    return null;
                  },
                  obscureText: true,
                  controller: _passwordTextController,
                  decoration: new InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      prefixIcon: Icon(CupertinoIcons.lock),
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(15.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(color: Colors.grey[800]),
                      hintText: "Type in your Password",
                      fillColor: Colors.white70),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter Confirm Password';
                    }
                    if (_passwordTextController.text !=
                        _confirmpasswordTextController.text) {
                      return 'Password does not Match';
                    }
                    return null;
                  },
                  obscureText: true,
                  controller: _confirmpasswordTextController,
                  decoration: new InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.lock),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(15.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(color: Colors.grey[800]),
                      hintText: "Type in Confirm Password",
                      fillColor: Colors.white70),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(15.0),
                              )),
                          child: CountryCodePicker(
                            onChanged: (e) {
                              setState(() {
                                countryCode = e.toString();
                                print(countryCode.toString());
                              });

                              //   print(e.toString());
                            },
                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            initialSelection: 'IT',
                            favorite: ['+39', 'FR'],
                            // optional. Shows only country name and flag
                            showCountryOnly: false,
                            // optional. Shows only country name and flag when popup is closed.
                            showOnlyCountryWhenClosed: false,
                            // optional. aligns the flag and the Text left
                            alignLeft: false,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          flex: 5,
                          child: TextFormField(
                            controller: _number,
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              if (value.length == 10) {}
                            },
                            maxLength: 10,
                            decoration: InputDecoration(
                              counterText: "",
                              labelText: ' Phone Number',
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                              hintText: 'Enter Phone Number',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(15.0),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, SignInScreen.id);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Already Have a Account? ',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        ' Sign In',
                        style: TextStyle(
                            color: Colors.red[700],
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                FlatButton(
                  onPressed: () {
                    if (_auhtProvider.isPicAvailable == true) {
                      if (_formkey.currentState.validate()) {
                        setState(() {
                          progressDialog.show();
                        });
                        _auhtProvider
                            .registerUser(
                                _emailTextController.text + '@gmail.com',
                                _passwordTextController.text)
                            .then((credential) {
                          if (credential.user.uid != null) {
                            uploadFile(_auhtProvider.imagePath.path)
                                .then((url) {
                              if (url != null) {
                                _auhtProvider.UploadDataToFirebase(
                                    email: _emailTextController.text +
                                        '@gmail.com',
                                    firstName: _firstName.text,
                                    lastName: _lastName.text,
                                    phone:
                                        countryCode.toString() + _number.text,
                                    url: url);

                                setState(() {
                                  progressDialog.dismiss();
                                });

                                Navigator.pushReplacementNamed(
                                    context, HomeScreen.id);
                              } else {
                                setState(() {
                                  progressDialog.dismiss();
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Failed to Upload Picture'),
                                  ),
                                );
                              }
                            });
                          } else {
                            //register failed
                            setState(() {
                              progressDialog.dismiss();
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('User Already Exist'),
                              ),
                            );
                          }
                        });
                      }
                    } else {
                      setState(() {
                        progressDialog.dismiss();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profile Pictures needed.'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.lato(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  color: Colors.red[700],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
