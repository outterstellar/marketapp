import 'package:flutter/material.dart';
import 'package:marketapp/data/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        title: Text("Liszt Müzik Market"),
        centerTitle: true,
      ),
    );
  }
}
