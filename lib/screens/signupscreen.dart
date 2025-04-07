import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketapp/data/constants.dart';
import 'package:marketapp/main.dart';
import 'package:marketapp/screens/mainscreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  bool allowed = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();

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
                                    controller: nameController,
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
                                    controller: surnameController,
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
                          onPressed: () async {
                            if (allowed == true) {
                              try {
                                if (validatePassword(
                                      context,
                                      passwordController.text,
                                    ) ==
                                    true) {
                                  await auth.createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  Constants.pushAndRemoveUntil(
                                    context: context,
                                    destination: MainScreen(),
                                  );
                                }
                              } on FirebaseAuthException catch (error) {
                                if (error.message ==
                                    "The email address is already in use by another account.") {
                                  Constants.showSnackBar(
                                    context: context,
                                    message:
                                        "This email adress is already taken",
                                  );
                                } else if (error.message ==
                                    "The email address is badly formatted.") {
                                  Constants.showSnackBar(
                                    context: context,
                                    message: "Please write a valid email",
                                  );
                                }
                                print(error.message);
                              }
                            } else {
                              Constants.showSnackBar(
                                context: context,
                                message: "Please check the box firstly.",
                              );
                            }
                          },
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

bool validatePassword(BuildContext context, String password) {
  List<String> errors = [];

  if (password.length < 6) {
    errors.add("at least 6 characters");
  }
  if (!RegExp(r'[a-z]').hasMatch(password)) {
    errors.add("at least one lowercase letter");
  }
  if (!RegExp(r'[A-Z]').hasMatch(password)) {
    errors.add("at least one uppercase letter");
  }
  if (!RegExp(r'\d').hasMatch(password)) {
    errors.add("at least one number");
  }
  if (!RegExp(r'[\W_]').hasMatch(password)) {
    errors.add("at least one special character");
  }

  if (errors.isNotEmpty) {
    final message = "Password must contain:\n• " + errors.join("\n• ");
    Constants.showSnackBar(context: context, message: message);
    return false;
  } else {
    return true;
  }
}
