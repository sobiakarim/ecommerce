import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselogin/CategoryScreen.dart';
import 'package:firebaselogin/roundbutton.dart';
import 'package:firebaselogin/signup.dart';
import 'package:firebaselogin/utilities.dart';
import 'package:flutter/material.dart';
import 'forgotpass.dart';
import 'shutter_animation.dart';

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

  void login() {
    if (formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      auth.signInWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString()).then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ShutterAnimation(nextScreen: CategoryScreen())),
        );
        setState(() {
          loading = false;
        });
      }).onError((error, stackTracer) {
        setState(() {
          loading = false;
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
        title: Center(child: Text("Login", style: TextStyle(color: Colors.white))),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          // Positioned.fill(
          //   child: Image.asset(
          //     'assets/shutter.jpg',
          //     fit: BoxFit.cover,
          //   ),
          // ),
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
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
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
                          SizedBox(height: 50),
                          Roundbutton(
                            title: "Login",
                            loading: loading,
                            onTap: login,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ForgotpasswordScreen())
                        );
                      }, child: Text("Forgot Password?", style: TextStyle(color: Colors.black))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?", style: TextStyle(color: Colors.black)),
                        TextButton(onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SignUpScreen())
                          );
                        }, child: Text("Sign Up", style: TextStyle(color: Colors.black)))
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
