import 'package:flutter/material.dart';
import '../models/suite.dart';
import '../screens/suite_details_screen.dart';

class SuiteCarousel extends StatelessWidget {
  final List<Suite> suites;

  const SuiteCarousel({Key? key, required this.suites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: PageView.builder(
        itemCount: suites.length,
        controller: PageController(viewportFraction: 0.9),
        itemBuilder: (context, index) {
          final suite = suites[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SuiteDetailsScreen(suite: suite),
                ),
              );
            },
            child: Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.network(
                      suite.fotos.isNotEmpty ? suite.fotos.first : "",
                      width: double.infinity,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          suite.nome,
                          textAlign: TextAlign.center,
                        ),
                        if (suite.exibirQtdDisponiveis) ...[
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (suite.qtd < 5)
                                const Icon(Icons.warning, color: Colors.red, size: 16),
                              Text(
                                suite.qtd < 5 ? " Só mais ${suite.qtd} pelo app" : "",
                                style: TextStyle(
                                  color: suite.qtd < 5 ? Colors.red : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: suite.categoriaItens
                                        .where((item) => item.icone.isNotEmpty)
                                        .map((item) => Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                      child: Image.network(
                                        item.icone,
                                        width: 36,
                                        height: 36,
                                      ),
                                    ))
                                        .toList(),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SuiteDetailsScreen(suite: suite),
                                    ),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "ver",
                                      style: TextStyle(fontSize: 12, color: Colors.grey),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          "todos",
                                          style: TextStyle(fontSize: 12, color: Colors.grey),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(Icons.expand_more, size: 16, color: Colors.grey),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
