import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaselogin/roundbutton.dart';
import 'package:firebaselogin/utilities.dart';
import 'package:flutter/material.dart';

class ForgotpasswordScreen extends StatefulWidget {
  const ForgotpasswordScreen({super.key});

  @override
  State<ForgotpasswordScreen> createState() => _ForgotpasswordScreenState();
}

class _ForgotpasswordScreenState extends State<ForgotpasswordScreen> {

  final EmailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Forgot Password", style: TextStyle(color: Colors.white),)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: EmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.alternate_email_outlined)
              ),

            ),
          ),
          SizedBox(height: 50,),
          Roundbutton(
              title: "Forgot",
              onTap: (){
                auth.sendPasswordResetEmail(email: EmailController.text.toString(),).then((value){
                  Utils().toastMessage("We have sent you an email to recover password. Please check your email");
                }).onError((error, stackTrace){
                  Utils().toastMessage(error.toString());

                });
              }
          )
        ],
      ),
    );
  }
}
