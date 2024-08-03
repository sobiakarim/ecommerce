
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselogin/postscreen.dart';
import 'package:firebaselogin/roundbutton.dart';
import 'package:firebaselogin/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loginscreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  String? error;
  FirebaseAuth auth = FirebaseAuth.instance;

  void signUp() {
    if (formKey.currentState!.validate()) {
      setState(() {
        loading = true;
        error = null;
      });
      auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      ).then((value) {
        print("User created successfully");
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>postScreen()));
        setState(() {
          loading = false;
        });
      }).onError((error, stackTrace) {
        setState(() {
          loading = false;
          this.error = error.toString(); // Set the error variable
        });
        Utils().toastMessage(error.toString()); // Show a toast message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(child: Text("Sign Up", style: TextStyle(color: Colors.white))),
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter the email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock)
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter the Password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  if (error != null) // Display the error message if it exists
                    Text(
                      error!,
                      style: TextStyle(color: Colors.red),
                    ),
                  SizedBox(height: 20),
                  Roundbutton(
                    title: "Sign Up",
                    loading: loading,
                    onTap: signUp,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? "),
                TextButton(onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen())
                  );
                }, child: Text("Login"))
              ],
            ),

          ],
        ),
      ),
    );
  }
}
