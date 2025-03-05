import 'package:mockito/mockito.dart';
import 'package:waaaaaaaaaa/app/domain/models/user/user.dart';
import 'package:waaaaaaaaaa/app/inject_repositories.dart';

void stubsSignedIn() {
  when(Repositories.connectivity.hasInternet).thenReturn(true);
  when(Repositories.authentication.isSignedIn).thenAnswer(
    (_) async => true,
  );
  when(Repositories.account.getUserData()).thenAnswer(
    (_) async => const User(
      id: 123,
      username: 'username',
    ),
  );
}
