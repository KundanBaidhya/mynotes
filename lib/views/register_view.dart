
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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


var logger = Logger();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Column(
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
                logger.e(userCredential);
                }
                on FirebaseAuthException catch(e){
                logger.e(e.code);
                }
          
                }, child: const Text("Register"),),
                TextButton(onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
                }, child : const Text("Already registered?"))
              ],
            ),
    );
  }
}