import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/data/http/http.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/domain/repositories/preferences_repository.dart';
import 'app/generated/translations.g.dart';
import 'app/inject_repositories.dart';
import 'app/my_app.dart';
import 'app/presentation/global/controllers/favorites/favorites_controller.dart';
import 'app/presentation/global/controllers/favorites/state/favorites_state.dart';
import 'app/presentation/global/controllers/session_controller.dart';
import 'app/presentation/global/controllers/theme_controller.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  print('🔄 Iniciando configuración...');

  final secureStorage = !kIsWeb ? const FlutterSecureStorage() : null;
  final apiKey = !kIsWeb
      ? await secureStorage!.read(key: 'api_key') ??
          '5bed77d45c8c0c13c37c7800f7af6aa1'
      : '5bed77d45c8c0c13c37c7800f7af6aa1';

  final http = Http(
    client: Client(),
    baseUrl: 'https://api.themoviedb.org/3',
    apiKey: apiKey,
  );

  print('🔄 Inyectando dependencias...');
  await injectRepositories(
    systemDarkMode: false, // En Web no usamos `platformBrightness`
    http: http,
    languageCode: LocaleSettings.currentLocale.languageCode,
    secureStorage: FlutterSecureStorage(),
    preferences: await SharedPreferences.getInstance(),
    connectivity: Connectivity(),
    internetChecker: InternetChecked(),
  );
  print('🎉 injectRepositories finalizó correctamente.');

  print('✅ Repositorios cargados. Ejecutando app...');
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({
    super.key,
    this.initialRoute,
    this.overrideRoutes,
  });

  final String? initialRoute;
  final List<GoRoute>? overrideRoutes;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeController>(
          create: (context) {
            final PreferencesRepository preferencesRepository =
                Repositories.preferences;
            return ThemeController(
              preferencesRepository.darkMode,
              preferencesRepository: preferencesRepository,
            );
          },
        ),
        ChangeNotifierProvider<SessionController>(
          create: (context) => SessionController(
            authenticationRepository: Repositories.authentication,
          ),
        ),
        ChangeNotifierProvider<FavoritesController>(
          create: (context) => FavoritesController(
            FavoritesState.loading(),
            accountRepository: Repositories.account,
          ),
        ),
      ],
      child: TranslationProvider(
        child: MyApp(
          initialRoute: initialRoute,
          overrideRoutes: overrideRoutes,
        ),
      ),
    );
  }
}
