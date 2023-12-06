import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/Utilities/dialogs.dart';
import 'package:mynotes/constants/routes.dart';

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
                  // ignore: use_build_context_synchronously
                  showErrorDialog(context, "Error : No settings for now!");
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


enum MenuAction{
  logOut,
  setting;
}