import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselogin/postscreen.dart';
import 'package:flutter/material.dart';

import 'loginscreen.dart';

class SplashServices{


  void isLogin(BuildContext context){

    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user!=null){
      Timer(const Duration(seconds: 3),
              ()=> Navigator.push(context,
              MaterialPageRoute(builder: (context)=>postScreen()))
      );
    }
    else{
      Timer(const Duration(seconds: 3),
              ()=> Navigator.push(context,
              MaterialPageRoute(builder: (context)=>LoginScreen()))
      );
    }

  }
}

