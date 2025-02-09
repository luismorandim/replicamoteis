import 'package:flutter/material.dart';
import '../models/motel.dart';
import '../models/periodo.dart';
import '../models/suite.dart';
import 'package:intl/intl.dart';
import '../screens/suite_reserva_screen.dart';

class PeriodosWidget extends StatelessWidget {
  final Suite suite;
  final List<Periodo> periodos;
  final Motel motel;

  const PeriodosWidget({Key? key, required this.suite, required this.periodos, required this.motel}) : super(key: key);

  String formatCurrency(double value) {
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return currencyFormat.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: periodos.map((periodo) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SuiteReservaScreen(
                  suite: suite,
                  periodo: periodo,
                  motel: motel
                ),
              ),
            );
          },
          child: Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 4),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Container(
              width: 340,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        periodo.tempoFormatado,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        formatCurrency(periodo.valorTotal),
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
