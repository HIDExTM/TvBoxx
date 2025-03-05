import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../inject_repositories.dart';
import '../../../global/widgets/my_scaffold.dart';
import '../../../routes/routes.dart';
import '../controller/home_controller.dart';
import '../controller/state/home_state.dart';
import 'widgets/movies_and_series/trending_list.dart';
import 'widgets/performers/trending_performers.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;

    return ChangeNotifierProvider(
      key: Key('home-$languageCode'),
      create: (_) => HomeController(
        HomeState(),
        trendingRepository: Repositories.trending,
      )..init(),
      child: MyScaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => context.pushNamed(Routes.favorites),
              icon: const Icon(Icons.favorite),
            ),
            IconButton(
              onPressed: () => context.pushNamed(Routes.profile),
              icon: const Icon(Icons.person),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const TrendingList(),
                const SizedBox(height: 20),
                const TrendingPerformers(), // 🔹 Se mantiene dentro de la columna
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
