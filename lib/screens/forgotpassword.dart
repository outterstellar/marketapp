import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketapp/data/constants.dart';
import 'package:marketapp/main.dart';
import 'package:marketapp/screens/signupscreen.dart';

// ignore: must_be_immutable
class ForgotPassword extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  ForgotPassword({super.key});

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
                          "Forgot Password",
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
                    TextButton(
                      onPressed: () {
                        Constants.push(
                          context: context,
                          destination: SignupScreen(),
                        );
                      },
                      child: Text("I don't have an account"),
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await auth.sendPasswordResetEmail(
                            email: emailController.text,
                          );
                          Constants.showSnackBar(
                            context: context,
                            message: "Password Reset email sent successfully",
                          );
                        } on FirebaseAuthException catch (error) {
                          if (error.message ==
                              "A network error (such as timeout, interrupted connection or unreachable host) has occurred.") {
                            Constants.showSnackBar(
                              context: context,
                              message: "Please check your internet connection",
                            );
                          } else if (error.message ==
                              "The email address is badly formatted.") {
                            Constants.showSnackBar(
                              context: context,
                              message: "Please write a valid email adress",
                            );
                          }
                        }
                      },
                      child: Text("Send Email"),
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
