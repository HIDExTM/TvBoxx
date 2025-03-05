import 'package:mockito/mockito.dart';
import 'package:waaaaaaaaaa/app/domain/repositories/account_repository.dart';
import 'package:waaaaaaaaaa/app/domain/repositories/authentication_repository.dart';
import 'package:waaaaaaaaaa/app/domain/repositories/connectivity_repository.dart';
import 'package:waaaaaaaaaa/app/domain/repositories/movies_repository.dart';
import 'package:waaaaaaaaaa/app/domain/repositories/preferences_repository.dart';
import 'package:waaaaaaaaaa/app/domain/repositories/trending_repository.dart';
import 'package:waaaaaaaaaa/app/presentation/service_locator/service_locator.dart';

import 'mocks.dart';

void injectTestRepositories({
  bool defaultStubs = true,
}) {
  ServiceLocator.instance.clear();

  final preferencesRepository = MockPreferencesRepository();

  if (defaultStubs) {
    when(preferencesRepository.darkMode).thenReturn(false);
  }

  ServiceLocator.instance.put<PreferencesRepository>(
    preferencesRepository,
  );

  ServiceLocator.instance.put<AuthenticationRepository>(
    MockAuthenticationRepository(),
  );

  ServiceLocator.instance.put<AccountRepository>(
    MockAccountRepository(),
  );

  ServiceLocator.instance.put<ConnectivityRepository>(
    MockConnectivityRepository(),
  );

  ServiceLocator.instance.put<TrendingRepository>(
    MockTrendingRepository(),
  );

  ServiceLocator.instance.put<MoviesRepository>(
    MockMoviesRepository(),
  );
}
