import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../global/widgets/request_failed.dart';
import '../../../controller/home_controller.dart';
import '../../../controller/state/home_state.dart';
import 'performer_tile.dart';

class TrendingPerformers extends StatefulWidget {
  const TrendingPerformers({super.key});

  @override
  State<TrendingPerformers> createState() => _TrendingPerformersState();
}

class _TrendingPerformersState extends State<TrendingPerformers> {
  final PageController _pageController = PageController(viewportFraction: 1);
  int _currentPage = 0; // 🔹 Guardar la página actual

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage =
            _pageController.page!.round(); // 🔹 Detectar cambios de página
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// 🔹 Método para cambiar de página
  void _jumpToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller = context.watch();
    final performers = controller.state.performers;
    final double screenWidth = MediaQuery.of(context).size.width;

    // 🔹 Ajuste dinámico de tamaño
    double containerHeight;
    double containerWidth;
    if (screenWidth < 600) {
      containerHeight = 300; // Celular
      containerWidth = 300;
    } else if (screenWidth < 1024) {
      containerHeight = 400; // Tablet
      containerWidth = 400;
    } else {
      containerHeight = 500; // PC
      containerWidth = 500;
    }

    // 🔹 Detectar el modo del sistema
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: SizedBox(
        width: containerWidth,
        height: containerHeight,
        child: performers.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          failed: () => RequestFailed(
            onRetry: () {
              controller.loadPerformers(
                  performers: const PerformersState.loading());
            },
          ),
          loaded: (list) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final performer = list[index];
                    return PerformerTile(performer: performer);
                  },
                ),
              ),
              const SizedBox(height: 10),

              /// 🔹 Indicador de página con colores dinámicos
              SmoothPageIndicator(
                controller: _pageController,
                count: list.length,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor:
                      isDarkMode ? Colors.white : Colors.black, // Modo dinámico
                  dotColor: isDarkMode
                      ? Colors.grey[700]!
                      : Colors.grey[400]!, // Modo dinámico
                ),
                onDotClicked: (index) =>
                    _jumpToPage(index), // 🔹 Permitir tocar los puntos
              ),
            ],
          ),
        ),
      ),
    );
  }
}
