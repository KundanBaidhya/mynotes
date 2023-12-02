import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/register_view.dart';



void main() {
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold( //inside the scaffold made a appbar and a body

      appBar: AppBar( //gave the app bar a text to display
        title: const Text("Home"),
        ),

      body: FutureBuilder(
        future: Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){

            case ConnectionState.done:

              final user = FirebaseAuth.instance.currentUser;
              
              print(user);

              // if(user?.emailVerified==true){
              //   return Text("The user is verified");
              // }
              // else{
                 return const LoginView();
                
              //}

            default:
             return const Text("Loading");
          }
        },
      )
    );
  }
}

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Column( children: [
        const Text("Please click the button below to verify your email"),
        TextButton(
          onPressed: () async{
          final user = FirebaseAuth.instance.currentUser;
          print(user);
          await user?.sendEmailVerification();
        }, child: Text("Click me to get verified"))
      ],
      );
  }
}