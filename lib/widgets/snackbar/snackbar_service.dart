import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState>
    scaffoldMessengerKey =
        GlobalKey<ScaffoldMessengerState>();

class SnackbarService {
  static void snackErro(String message){
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Color.fromARGB(255, 250, 88, 77))),
        persist: true,
      ),
    );
  }

  static void snackSucesso(String message){
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Color.fromARGB(255, 0, 255, 0))),
        persist: true,
      ),
    );
  }

  static void snackInfo(String message){
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Color.fromARGB(255, 51, 51, 249))),
        persist: true,
      ),
    );
  }

  static void snackAviso(String message){
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Color.fromARGB(255, 255, 255, 0))),
        persist: true,
      ),
    );
  }
}