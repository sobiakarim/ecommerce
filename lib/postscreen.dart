import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'loginscreen.dart';

class postScreen extends StatefulWidget {
  const postScreen({super.key});

  @override
  State<postScreen> createState() => _postScreenState();
}

class _postScreenState extends State<postScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Posts", style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(onPressed: (){
            final auth = FirebaseAuth.instance;
            auth.signOut();
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
          } , icon: Icon(Icons.login_outlined))
        ],

        //   automaticallyImplyLeading: false,
      ),
    );
  }
}
