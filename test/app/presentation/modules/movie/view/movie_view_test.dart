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

Future<void> _initApp(WidgetTester tester) {
  return tester.pumpWidget(
    Root(
      initialRoute: Routes.movie,
      overrideRoutes: [
        GoRoute(
          name: Routes.movie,
          path: '/moviee',
          builder: (_, __) => const MovieView(
            movieId: 123,
          ),
        )
      ],
    ),
  );
}
