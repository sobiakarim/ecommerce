import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselogin/postscreen.dart';
import 'package:firebaselogin/roundbutton.dart';
import 'package:firebaselogin/signup.dart';
import 'package:firebaselogin/utilities.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'forgotpass.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  @override

  void login(){
    setState(() {
      loading = true;
    });
    auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value){
      //     Utils().toastMessage(value.user!.email.toString());
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>postScreen()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTracer){
      setState(() {
        loading = false;
      });
      Utils().toastMessage(error.toString());
    });
  }

  void loginWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return;
      }
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => postScreen()),
        );
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
      // Handle error (show message to the user, log the error, etc.)
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(child: Text("Login", style: TextStyle(color: Colors.white))),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Form(
              key: formKey,
              child: Column(

                children: [

                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.alternate_email)
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter the email";
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock)
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please enter the Password";
                        }
                        else{
                          return null;
                        }
                      }
                  ),
                  SizedBox(height: 50,),
                ],
              ),
            ),

            Roundbutton(
              title: "Login",
              loading: loading,
              onTap: (){
                if(formKey.currentState!.validate()){
                  login();
                }
              },
            ),
            //         SizedBox(height: 4,),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ForgotpasswordScreen())
                );
              }, child: Text("Forgot Password?")),
            ),
            //        SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen())
                  );
                }, child: Text("Sign Up"))
              ],
            ),

          ],
        ),
      ),
    );
  }
}
