import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context,String text){
  return showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: const Text("oops something went wrong!"),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: (){Navigator.of(context).pop();} , 
            child: const Text("Ok?")),
        ],
      );
  });
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