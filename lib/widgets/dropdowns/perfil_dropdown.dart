import 'package:appcompanion/core/di/service_locator.dart';
import 'package:appcompanion/services/auth_service.dart';
import 'package:flutter/material.dart';

class PerfilDropdown extends StatelessWidget {
  final int? value;
  final ValueChanged<int?> onChanged;
  final String? label;

  const PerfilDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.label
  });

  @override
  Widget build(BuildContext context) {
    final auth = getIt<IAuthService>();
    return DropdownButtonFormField<int>(
      decoration: InputDecoration(
        labelText: label ?? 'Perfil',
      ),
      initialValue: value,
      items: [
        DropdownMenuItem(
          value: 1,
          enabled: auth.isAdmin,
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