import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketapp/data/constants.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        title: Text("Liszt Müzik Market"),
        backgroundColor: Constants.backgroundColor,
        centerTitle: true,
      ),
      body: Form(
        child: Column(
          children: [
            Divider(
              height: 100.h,
              color: Colors.transparent,
            ),
            SizedBox(
              width: 412.w,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 50),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Divider(height: 20.h,color: Colors.transparent,),
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
              onPressed: () {},
              child: Text("I don't have an account"),
            ),
            TextButton(onPressed: () {}, child: Text("Forgot Password")),

            ElevatedButton(onPressed: () {}, child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
