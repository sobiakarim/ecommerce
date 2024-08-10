import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselogin/CategoryScreen.dart';
import 'package:firebaselogin/roundbutton.dart';
import 'package:firebaselogin/utilities.dart';
import 'package:flutter/material.dart';
import 'loginscreen.dart';
import 'shutter_animation.dart';

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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ShutterAnimation(nextScreen: CategoryScreen())),
        );
        setState(() {
          loading = false;
        });
      }).onError((error, stackTrace) {
        setState(() {
          loading = false;
          this.error = error.toString();
        });
        Utils().toastMessage(error.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text("Sign Up", style: TextStyle(color: Colors.white))),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          // Background image
          // Positioned.fill(
          //   child: Image.asset(
          //     'assets/shutter.jpg',
          //     fit: BoxFit.cover,
          //   ),
          // ),
          // // Semi-transparent overlay
          // Positioned.fill(
          //   child: Container(
          //     color: Colors.black.withOpacity(0.5),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.black),
                              prefixIcon: Icon(Icons.alternate_email, color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
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
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.black),
                              prefixIcon: Icon(Icons.lock, color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter the Password";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          if (error != null)
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
                        Text("Already have an account?", style: TextStyle(color: Colors.black)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => LoginScreen())
                            );
                          },
                          child: Text("Login", style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
