import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketapp/data/constants.dart';
import 'package:marketapp/screens/mainscreen.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  late Timer _timer;
  late Future<bool> _checkEmailVerifiedFuture;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _checkEmailVerifiedFuture = _checkEmailVerified();
    _startEmailCheckTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startEmailCheckTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final isVerified = await _checkEmailVerified();
      if (isVerified) {
        timer.cancel();
        if (mounted) {
          Constants.pushAndRemoveUntil(
            context: context,
            destination: MainScreen(),
          );
        }
      } else {
        setState(() {
          _checkEmailVerifiedFuture = _checkEmailVerified();
        });
      }
    });
  }

  Future<bool> _checkEmailVerified() async {
    await user?.reload(); // Firebase'ten kullanıcıyı güncelle
    return FirebaseAuth.instance.currentUser?.emailVerified ?? false;
  }

  Future<void> _resendVerificationEmail() async {
    try {
      await user?.sendEmailVerification();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Verification email sent.')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error sending email: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: _checkEmailVerifiedFuture,
        builder: (context, snapshot) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Please verify your email',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 48),
                      const CircularProgressIndicator(),
                      const SizedBox(height: 48),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _resendVerificationEmail,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          child: const Text('Resend Email'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
