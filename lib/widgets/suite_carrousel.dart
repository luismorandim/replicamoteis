import 'package:flutter/material.dart';
import '../models/suite.dart';

class SuiteCarousel extends StatelessWidget {
  final List<Suite> suites;

  const SuiteCarousel({Key? key, required this.suites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230, // Ajustado para exibir tudo corretamente
      child: PageView.builder(
        itemCount: suites.length,
        controller: PageController(viewportFraction: 0.9), // Ajusta para uma suíte por vez
        itemBuilder: (context, index) {
          final suite = suites[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                  child: Image.network(
                    suite.fotos.isNotEmpty ? suite.fotos.first : "",
                    width: double.infinity,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(suite.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Text("Disponíveis: ${suite.qtd}"),
                          if (suite.qtd < 5)
                            const Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Icon(Icons.warning, color: Colors.red, size: 16),
                            ),
                        ],
                      ),
                      const SizedBox(height: 5),

                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
