import 'package:flutter/material.dart';

class ComposeEmailScreen extends StatefulWidget {
  static const String id='compose-email';
  @override
  _ComposeEmailScreenState createState() => _ComposeEmailScreenState();
}

class _ComposeEmailScreenState extends State<ComposeEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
       iconTheme: IconThemeData(color: Colors.black),
        title: Text('Compose',style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w400),),
        actions: [
          IconButton(icon: Icon(Icons.send), onPressed: (){}),
          IconButton(icon: Icon(Icons.attach_file_outlined), onPressed: (){})
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'TO:'
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Subject:'
              ),
            ),
            Expanded(
              child: TextFormField(
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                    hintText: 'Mail:',


                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
