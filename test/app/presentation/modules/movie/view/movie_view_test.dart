import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:waaaaaaaaaa/app/presentation/global/controllers/favorites/favorites_controller.dart';
import 'package:waaaaaaaaaa/app/presentation/global/dialogs/show_loader.dart';
import 'package:waaaaaaaaaa/app/presentation/global/widgets/request_failed.dart';
import 'package:waaaaaaaaaa/app/presentation/modules/movie/views/movie_view.dart';
import 'package:waaaaaaaaaa/app/presentation/routes/routes.dart';
import 'package:waaaaaaaaaa/main.dart';

import '../../../../../inject_test_repositories.dart';
import 'when/when.dart';

void main() {
  setUp(injectTestRepositories);
  testWidgets(
    'MovieView > load > success',
    (tester) async {
      mockMovieViewSuccess();
      await _initApp(tester);
      final scaffoldState = tester.state(
        find.byType(Scaffold),
      );

      final FavoritesController favoritesController =
          scaffoldState.context.read();

      favoritesController.init();

      expect(
        find.byKey(
          const Key('movie-loading'),
        ),
        findsOneWidget,
      );

      await tester.pumpAndSettle();
      expect(
        find.byKey(
          const Key('movie-loading'),
        ),
        findsNothing,
      );

      final movieCastRequestFailedFinder = find.byKey(
        const Key('movie-cast-request-failed'),
      );
      expect(
        movieCastRequestFailedFinder,
        findsOneWidget,
      );

      await tester.ensureVisible(movieCastRequestFailedFinder);

      await tester.tap(
        find.descendant(
          of: movieCastRequestFailedFinder,
          matching: find.byType(MaterialButton),
        ),
      );
      await tester.pump();
      expect(
        find.byKey(const Key('cast-loading')),
        findsOneWidget,
      );
      await tester.pumpAndSettle();
      expect(
        find.text('Cast'),
        findsOneWidget,
      );
      expect(
        find.byIcon(Icons.favorite),
        findsNothing,
      );
      await tester.tap(
        find.byKey(
          const Key('favorite-button'),
        ),
      );
      await tester.pump();
      expect(
        find.byType(ProgressDialog),
        findsOneWidget,
      );
      await tester.pumpAndSettle();
      expect(
        find.byIcon(Icons.favorite),
        findsOneWidget,
      );
    },
  );
}

Future<void> _initApp(WidgetTester tester) {
  return tester.pumpWidget(
    Root(
      initialRoute: Routes.movie,
      overrideRoutes: [
        GoRoute(
          name: Routes.movie,
          path: '/movie',
          builder: (_, __) => const MovieView(
            movieId: 123,
          ),
        )
      ],
    ),
  );
}
