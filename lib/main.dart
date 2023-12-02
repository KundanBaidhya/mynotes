import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/views/Verify_email_view.dart';
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
      routes: {
        "/login" :(context) => const LoginView(),
        "/register" :(context) => const RegisterView()
      },
    ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
      
            case ConnectionState.done:
      
              final user = FirebaseAuth.instance.currentUser;
              
                if(user!=null){
                  if(user.emailVerified){
                    print("yay I'm verified");
                  }
                  else{
                    return const VerifyEmailView();
                  }
                }
                else{
                  return const LoginView();
                }

              return Scaffold(
                appBar: AppBar(title: const Text("Welcome"),),
                body: const SizedBox(child: Center(
                  child: Text("Done"),
                ),),
              );
      

            default:
            return const SizedBox(
              child: Center(
                child: CircularProgressIndicator(),),
            );
          }
        },
      );
  }
}

