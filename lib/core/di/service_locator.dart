import 'package:appcompanion/services/acesso_service.dart';
import 'package:appcompanion/services/usuario_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<IUsuarioService>(() => UsuarioService());
  getIt.registerLazySingleton<IAcessoService>(() => AcessoService());
}