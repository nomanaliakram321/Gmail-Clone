import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmail_flutter_clone/screens/compose_email_screen.dart';
import 'package:gmail_flutter_clone/screens/signup_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home-screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Material(

          borderRadius: BorderRadius.circular(6),
          elevation: 8,
          child: TextFormField(
            cursorColor: Colors.red,
            decoration: InputDecoration(
                border: InputBorder.none,

                prefixIcon: IconButton(
                  icon: Icon(Icons.dehaze),
                ),
                hintText: 'Search in mail',
                suffixIcon: Container(
                  margin: EdgeInsets.all(7),
                  decoration: BoxDecoration(

                  ),
                  child: CircleAvatar(
                    radius: 5,
                    backgroundImage:NetworkImage('https://upload.wikimedia.org/wikipedia/commons/9/9a/Mahesh_Babu_in_Spyder_%28cropped%29.jpg'),),
                )),
          ),
        ),),
        backgroundColor: Colors.white,
        body: ListView.builder(
            itemCount: 8,
            itemBuilder: (BuildContext context,int index){
          return ListTile(
            leading: CircleAvatar(

              backgroundImage:NetworkImage('https://upload.wikimedia.org/wikipedia/commons/9/9a/Mahesh_Babu_in_Spyder_%28cropped%29.jpg'),),
          title: Text('New Emails',style: TextStyle(fontWeight: FontWeight.w600),),
            subtitle:Text('New Emails',style:TextStyle(fontSize: 12),) ,

trailing: Column(

  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Text('5:24PM',style: TextStyle(fontSize: 10),),
    Icon(Icons.star_border_outlined,size: 20,)
  ],
),
          );
        }),
        floatingActionButton: TextButton.icon(
          style: TextButton.styleFrom(
            primary: Colors.red.shade800,
            elevation: 8,
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
          icon: Icon(Icons.edit_outlined),
          label: Text('Compose'),
          onPressed: (){
            Navigator.pushNamed(context, ComposeEmailScreen.id);
          },

        ),
      ),
    );
  }
}
