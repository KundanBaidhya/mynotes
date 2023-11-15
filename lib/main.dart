import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';



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

              if(user?.emailVerified==true){
                return Text("The user is verified");
              }
              else{
                return Text("The user is not verified. Please verify the user to continue.");
              }

            default:
             return const Text("Loading");
          }
        },
      )
    );
  }
}

//general changes in code
//general changes in code
//general changes in code
//general changes in code
//general changes in code
//general changes in code
//general changes in code
//general changes in code
//general changes in code
//general changes in code
//general changes in code