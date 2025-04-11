import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketapp/data/constants.dart';
import 'package:marketapp/main.dart';
import 'package:marketapp/screens/emailVerification.dart';
import 'package:marketapp/screens/forgotpassword.dart';
import 'package:marketapp/screens/mainscreen.dart';
import 'package:marketapp/screens/signupscreen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Constants.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              title: Text("Liszt Müzik Market"),
              backgroundColor: Constants.backgroundColor,
              centerTitle: true,
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: Size.infinite.width,
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 50),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Divider(height: 20.h, color: Colors.transparent),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "Email",
                        ),
                      ),
                    ),
                    Divider(height: 20.h, color: Colors.transparent),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "Password",
                        ),
                        obscureText: true,
                      ),
                    ),
                    Divider(height: 20.h, color: Colors.transparent),
                    TextButton(
                      onPressed: () {
                        Constants.push(
                          context: context,
                          destination: SignupScreen(),
                        );
                      },
                      child: Text("I don't have an account"),
                    ),
                    TextButton(
                      onPressed: () {
                        Constants.push(
                          context: context,
                          destination: ForgotPassword(),
                        );
                      },
                      child: Text("Forgot Password"),
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        String email = emailController.text;
                        String password = passwordController.text;
                        try {
                          await auth.signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );

                          Constants.pushAndRemoveUntil(
                            context: context,
                            destination: auth.currentUser!.emailVerified ?  MainScreen() : EmailVerification(),
                          );
                        } on FirebaseAuthException catch (error) {
                          print(error.code);
                          if (error.code == "network-request-failed") {
                            Constants.showSnackBar(
                              context: context,
                              message: "Please check your internet connection",
                            );
                          } else if (error.code == "invalid-credential" ||
                              error.code == "invalid-email") {
                            Constants.showSnackBar(
                              context: context,
                              message: "Please check your email or password",
                            );
                          }
                        }
                      },
                      child: Text("Login"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
