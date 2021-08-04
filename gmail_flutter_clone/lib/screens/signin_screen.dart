import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmail_flutter_clone/providers/auth_provider.dart';
import 'package:gmail_flutter_clone/screens/home_screen.dart';
import 'package:gmail_flutter_clone/screens/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  static const String id = 'signin-screen';
  const SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Icon icon;
  bool _visible = true;
  final _formkey = GlobalKey<FormState>();
  var _emailTextController = TextEditingController();
  var _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ProgressDialog progressDialog = ProgressDialog(
      context: context,
      backgroundColor: Colors.white,
      progressIndicatorColor: Colors.red,
      textColor: Colors.red,
    );
    final _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Sign In',
          style: TextStyle(color: Colors.red[700], fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(child: Image.asset('assets/images/login2.png')),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTextController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Email';
                    }
                    final bool isvalid =
                        EmailValidator.validate(_emailTextController.text);
                    if (!isvalid) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                  decoration: new InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(color: Colors.grey[800]),
                      hintText: "Type in your Email",
                      fillColor: Colors.white70),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  obscureText: _visible,
                  controller: _passwordTextController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter Password';
                    }
                    if (value.length < 6) {
                      return 'Minimum 6 characters';
                    }
                    return null;
                  },
                  decoration: new InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.lock),
                      suffixIcon: IconButton(
                        icon: _visible
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _visible = !_visible;
                          });
                        },
                      ),
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
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
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, SignUpScreen.id);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Dont You Have a Account? ',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        ' Sign Up',
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
                    if (_formkey.currentState.validate()) {
                      setState(() {
                        progressDialog.show();
                      });
                      _authProvider
                          .loginUser(_emailTextController.text,
                              _passwordTextController.text)
                          .then((credential) {
                        if (credential != null) {
                          setState(() {
                            progressDialog.show();
                          });
                          Navigator.pushReplacementNamed(
                              context, HomeScreen.id);
                        } else {
                          setState(() {
                            progressDialog.dismiss();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(_authProvider.error),
                            ),
                          );
                        }
                      });
                    }
                  },
                  child: Text(
                    'Sign In',
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
