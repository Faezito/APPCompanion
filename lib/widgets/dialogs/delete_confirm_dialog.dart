import 'package:flutter/material.dart';

Future<bool> showDeleteConfirmDialog(
  BuildContext context, {
  required String title,
  required String content,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Excluir"),
          ),
        ],
      );
    },
  );

  return result ?? false;
}