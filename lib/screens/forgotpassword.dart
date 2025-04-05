import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketapp/data/constants.dart';
import 'package:marketapp/screens/signupscreen.dart';

// ignore: must_be_immutable
class ForgotPassword extends StatelessWidget {

  TextEditingController emailController = TextEditingController();
   ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,

      body:  SafeArea(
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
                      width:Size.infinite.width,
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
                      onPressed: ()  {
                        
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