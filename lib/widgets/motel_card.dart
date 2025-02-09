import 'package:flutter/material.dart';
import 'package:replicamoteis/widgets/suite_carrousel.dart';
import '../models/motel.dart';
import '../screens/suite_details_screen.dart';
import '../widgets/suite_itens_widget.dart';
import '../widgets/periodos_widget.dart';

class MotelCard extends StatelessWidget {
  final Motel motel;

  const MotelCard({Key? key, required this.motel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    motel.logo,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        motel.fantasia,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${motel.distancia} km - ${motel.bairro}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          Text(" ${motel.media} • ${motel.qtdAvaliacoes} avaliações"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 550,
              child: PageView.builder(
                itemCount: motel.suites.length,
                controller: PageController(viewportFraction: 0.9),
                itemBuilder: (context, index) {
                  final suite = motel.suites[index];
                  return Column(
                    children: [
                      SuiteCarousel(suites: motel.suites[index]),
                      SizedBox(height: 10),
                      SuiteItensWidget(
                        categoriaItens: motel.suites.first.categoriaItens,
                        onVerTodos: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SuiteDetailsScreen(suite: suite),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      PeriodosWidget(periodos: suite.periodos),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
