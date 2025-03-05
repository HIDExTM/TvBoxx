import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../domain/models/peformer/performer.dart';
import '../../../../../global/utils/get_image_url.dart';

class PerformerTile extends StatelessWidget {
  final Performer performer;

  const PerformerTile({
    super.key,
    required this.performer,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // 🔹 Definir el ancho de la imagen según el tamaño de pantalla
    double imageWidth;
    if (screenWidth < 600) {
      // Celular
      imageWidth = 100;
    } else if (screenWidth < 1024) {
      // Tablet
      imageWidth = 100;
    } else {
      // PC
      imageWidth = 100;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width:
            imageWidth, // 🔹 Se ajusta el ancho de la imagen según la pantalla
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Stack(
            children: [
              // Imagen del actor
              Positioned.fill(
                child: ExtendedImage.network(
                  getImageUrl(performer.profilePath,
                      imageQuality: ImageQuality.original),
                  fit: BoxFit.cover,
                  loadStateChanged: (state) {
                    if (state.extendedImageLoadState == LoadState.loading) {
                      return Container(color: Colors.black12);
                    }
                    return null;
                  },
                ),
              ),

              // Contenedor de información
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        performer.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            performer.popularity.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 18,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
