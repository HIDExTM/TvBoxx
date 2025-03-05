import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:waaaaaaaaaa/app/inject_repositories.dart';
import 'package:waaaaaaaaaa/app/presentation/modules/offline/views/offline_view.dart';
import 'package:waaaaaaaaaa/app/presentation/routes/routes.dart';
import 'package:waaaaaaaaaa/main.dart';

import '../../../../inject_test_repositories.dart';

void main() {
  setUp(injectTestRepositories);

  testWidgets(
    'OfflineView',
    (tester) async {
      when(Repositories.connectivity.onInternetChanged).thenAnswer(
        (_) => Stream.value(true),
      );
      when(Repositories.connectivity.hasInternet).thenReturn(true);
      when(Repositories.authentication.isSignedIn).thenAnswer(
        (_) async => false,
      );
      await tester.pumpWidget(
        const Root(
          initialRoute: Routes.offline,
        ),
      );
      expect(
        find.byType(OfflineView),
        findsOneWidget,
      );
      await tester.pumpAndSettle();
      expect(
        find.byType(OfflineView),
        findsNothing,
      );
    },
  );
}
