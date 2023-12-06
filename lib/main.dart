import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/views/Verify_email_view.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:logger/logger.dart';



void main() {
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        loginRoute :(context) => const LoginView(),
        registerRoute:(context) => const RegisterView(),
        notesRoute:(context) => const NotesView()
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
                    logger.d("yay I'm verified");
                  }
                  else{
                    return const VerifyEmailView();
                  }
                }
                else{
                  return const LoginView();
                }

              return const NotesView();
      

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


enum MenuAction{
  logOut,
  setting;
  
}

var logger = Logger();

class NotesView extends StatefulWidget {
  const NotesView({super.key});


  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: [
          PopupMenuButton(
            onSelected: (value) async{
              switch(value){
                
                case MenuAction.logOut:
                  final shouldLogout = await showLogOutDialog(context);
                  if(shouldLogout){
                    await FirebaseAuth.instance.signOut();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  }
                  break;

                case MenuAction.setting:
                  logger.e("No Settings for now shit");
              }
            },
            itemBuilder: (context){
              return [
                const PopupMenuItem(value:MenuAction.logOut, child: Text("Log Out")),
                const PopupMenuItem(value:MenuAction.setting, child: Text("Settings")),
              ];}
          )
        ],

        ),
      body: const Text("hello world!"),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context){
  return showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: (){ Navigator.of(context).pop(true);}, 
            child: const Text("Logoout")),
          TextButton(
            onPressed: (){Navigator.of(context).pop(false);}, 
            child: const Text("Cancel")),
        ],
      );
    }
    ).then((value) => value ?? false);
}