import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';


var logger = Logger();


class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Email"),),
      body: Column( children: [
          const Text("Please click the button below to verify your email"),
          TextButton(
            onPressed: () async{
            final user = FirebaseAuth.instance.currentUser;
            logger.e(user);
            await user?.sendEmailVerification();
          }, child: const Text("Click me to get verified"))
        ],
        ),
    );
  }
}