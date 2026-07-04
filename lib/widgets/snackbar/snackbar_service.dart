import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState>
    scaffoldMessengerKey =
        GlobalKey<ScaffoldMessengerState>();

class SnackbarService {
  static void snackErro(String message){
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message, 
          style: const TextStyle(color: Color.fromARGB(255, 92, 6, 0))
          ),
        backgroundColor: Color.fromARGB(255, 255, 192, 192),  
        // persist: true,
        showCloseIcon: true,
        closeIconColor: Color.fromARGB(255, 92, 6, 0),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void snackSucesso(String message){
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message, 
          style: const TextStyle(color: Color.fromARGB(255, 113, 250, 113))
          ),
        // persist: true,
        showCloseIcon: true,
        duration: const Duration(seconds: 20),
      ),
    );
  }

  static void snackInfo(String message){
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message, 
          style: const TextStyle(color: Color.fromARGB(255, 127, 127, 253))
          ),
        backgroundColor: Color.fromARGB(255, 0, 109, 225),  
        // persist: true,
        showCloseIcon: true,
        closeIconColor: Color.fromARGB(255, 127, 127, 253),
        duration: const Duration(seconds: 20),
      ),
    );
  }

  static void snackAviso(String message){
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message, 
          style: const TextStyle(color: Color.fromARGB(255, 250, 250, 184))
          ),
        backgroundColor: Color.fromARGB(255, 233, 233, 2),  
        // persist: true,
        showCloseIcon: true,
        closeIconColor: Color.fromARGB(255, 250, 250, 184),
        duration: const Duration(seconds: 20),
      ),
    );
  }
}