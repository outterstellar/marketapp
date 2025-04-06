import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketapp/data/constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  bool allowed = false;
  TextEditingController passwordController = TextEditingController();

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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: Size.infinite.width,
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 50),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Size.infinite.width,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      hintText: "Name",
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      hintText: "Surname",
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                        CheckboxListTile(
                          value: allowed,
                          onChanged: (value) {
                            setState(() {
                              allowed = value!;
                            });
                          },
                          title: Text(
                            "I understood that my data will be used.",
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Constants.secondaryBackgroundColor,
                          checkColor: Constants.buttonBackgroundColor,
                        ),
                        Divider(height: 20.h, color: Colors.transparent),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text("Sign Up"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
