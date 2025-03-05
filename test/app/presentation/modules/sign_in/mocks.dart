import 'package:mockito/annotations.dart';
import 'package:waaaaaaaaaa/app/presentation/global/controllers/favorites/favorites_controller.dart';
import 'package:waaaaaaaaaa/app/presentation/global/controllers/session_controller.dart';

@GenerateNiceMocks(
  [
    MockSpec<SessionController>(),
    MockSpec<FavoritesController>(),
  ],
)
export 'mocks.mocks.dart';
