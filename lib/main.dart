import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketapp/screens/loginscreen.dart';
import 'package:marketapp/screens/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
FirebaseAuth auth = FirebaseAuth.instance;
SharedPreferences? pref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(412, 915),
      builder: (context, widget) {
        return MaterialApp(
          title: 'Material App',
          home:
              pref!.getBool("remember") == true ? MainScreen() : LoginScreen(),
        );
      },
    );
  }
}
