import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waaaaaaaaaa/app/data/services/remote/internet_checker.dart';
import 'package:waaaaaaaaaa/app/domain/repositories/account_repository.dart';
import 'package:waaaaaaaaaa/app/domain/repositories/authentication_repository.dart';
import 'package:waaaaaaaaaa/app/domain/repositories/connectivity_repository.dart';
import 'package:waaaaaaaaaa/app/domain/repositories/movies_repository.dart';
import 'package:waaaaaaaaaa/app/domain/repositories/preferences_repository.dart';
import 'package:waaaaaaaaaa/app/domain/repositories/trending_repository.dart';

@GenerateMocks(
  [
    Client,
    FlutterSecureStorage,
    Connectivity,
    InternetChecked,
    SharedPreferences,
    PreferencesRepository,
    AuthenticationRepository,
    AccountRepository,
    ConnectivityRepository,
    TrendingRepository,
    MoviesRepository,
  ],
)
export 'mocks.mocks.dart';
