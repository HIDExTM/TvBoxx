import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../global/widgets/request_failed.dart';
import '../../../controller/home_controller.dart';
import '../../../controller/state/home_state.dart';
import 'trending_tile.dart';
import 'trending_time_window.dart';

class TrendingList extends StatelessWidget {
  const TrendingList({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = context.watch();
    final moviesAndSeries = controller.state.moviesAndSeries;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Definir la altura máxima en pantallas grandes
    double maxHeight = screenHeight * 0.3; // Máximo 30% de la pantalla
    if (screenWidth > 1200) {
      maxHeight = 350; // Fijo en pantallas muy grandes
    } else if (screenWidth > 800) {
      maxHeight = 250; // Fijo en pantallas medianas
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TrendingTimeWindow(
          timeWindow: moviesAndSeries.timeWindow,
          onChanged: controller.onTimeWindowChanged,
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: maxHeight,
          child: LayoutBuilder(
            builder: (_, constraints) {
              double width = constraints.maxHeight * 0.65;

              // Limitar el ancho en pantallas grandes
              if (screenWidth > 1200) {
                width = 300;
              } else if (screenWidth > 800) {
                width = 200;
              }

              return Center(
                child: moviesAndSeries.when(
                  loading: (_) => const CircularProgressIndicator(),
                  failed: (_) => RequestFailed(
                    onRetry: () {
                      controller.loadMoviesAndSeries(
                        moviesAndSeries: MoviesAndSeriesState.loading(
                          moviesAndSeries.timeWindow,
                        ),
                      );
                    },
                  ),
                  loaded: (_, list) => ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (_, index) {
                      final media = list[index];
                      return SizedBox(
                        width: width,
                        height: constraints.maxHeight,
                        child: TrendingTile(
                          media: media,
                          width: width,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
