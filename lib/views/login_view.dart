
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class LoginView extends StatefulWidget {  //made a stateless homepage class that returns scaffold
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
              final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: myEmail, password: myPassword);
              print(userCredential);
              
              }
              on FirebaseAuthException catch(e){
                print(e.code);
              }
              catch(e){
                print("Something bad happened");
                print(e.runtimeType);
                print(e);
              }
              }, child: const Text("Login"),
        ),
        TextButton(onPressed: (){

        }, child: Text("Not registered yet? Click here to register your account"))
      ],
    );
  }
}