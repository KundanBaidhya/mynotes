
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email; //works as a container for the value given by the user in the textfield
  late final TextEditingController _password;

  @override
  void initState() { //initiating the containers
    
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() { // disposing the containers after use
    
    _email.dispose();
    _password.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold( //inside the scaffold made a appbar and a body

      appBar: AppBar( //gave the app bar a text to display
        title: const Text("Register"),
        ),

      body: FutureBuilder(
        future: Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){

            case ConnectionState.done:
              return Column(
            children: [
              TextField(
                controller: _email,
                decoration: const InputDecoration(hintText: "Enter your Email"),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                enableSuggestions: false,
        
              ),
              TextField(
                controller: _password,
                decoration: const InputDecoration(hintText: "Enter your Password"),
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
              ),
              TextButton(onPressed: () async{ //
        
              
              final myEmail = _email.text;
              final myPassword = _password.text;

              try{
              final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: myEmail, password: myPassword);
              print(userCredential);
              }
              on FirebaseAuthException catch(e){
                print(e.code);
              }
        
              }, child: const Text("Register"),),
            ],
          );

            default:
             return const Text("Loading");
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
              
          }
          
        },
      )
    );
  }
}