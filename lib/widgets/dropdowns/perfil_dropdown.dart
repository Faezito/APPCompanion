import 'package:flutter/material.dart';

class PerfilDropdown extends StatelessWidget {
  final int? value;
  final ValueChanged<int?> onChanged;

  const PerfilDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(
        labelText: 'Perfil',
      ),
      initialValue: null,
      items: const [
        DropdownMenuItem(
          value: 1,
          child: Text('Administrador'),
        ),
        DropdownMenuItem(
          value: 5,
          child: Text('Usuário'),
        ),
      ],
      onChanged: onChanged,
    );
  }
}