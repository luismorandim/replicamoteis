import 'package:flutter/material.dart';
import '../models/suite.dart';
import '../screens/gallery_screen.dart';
import '../screens/suite_details_screen.dart';

class SuiteCarousel extends StatelessWidget {
  final Suite suites;

  const SuiteCarousel({Key? key, required this.suites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GalleryScreen(
                    images: suites.fotos,
                    suiteName: suites.nome,
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.network(
                suites.fotos.isNotEmpty ? suites.fotos.first : "",
                width: double.infinity,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      suites.nome,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: 20,
                  child: suites.exibirQtdDisponiveis
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (suites.qtd < 5)
                        const Icon(Icons.warning, color: Colors.red, size: 16),
                      Text(
                        suites.qtd < 5 ? " Só mais ${suites.qtd} pelo app" : "",
                        style: TextStyle(
                          color: suites.qtd < 5 ? Colors.red : Colors.black,
                        ),
                      ),
                    ],
                  )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
