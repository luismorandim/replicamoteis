import 'package:flutter/material.dart';
import 'package:replicamoteis/screens/suite_details_screen.dart';
import '../models/suite.dart';
import '../models/periodo.dart';
import '../models/motel.dart';

class SuiteReservaScreen extends StatefulWidget {
  final Suite suite;
  final Periodo periodo;
  final Motel motel;

  const SuiteReservaScreen({
    Key? key,
    required this.suite,
    required this.periodo,
    required this.motel,
  }) : super(key: key);

  @override
  _SuiteReservaScreenState createState() => _SuiteReservaScreenState();
}

class _SuiteReservaScreenState extends State<SuiteReservaScreen> {
  int _currentIndex = 0;
  late PageController _pageController;
  double taxa = 5.30;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _nextImage() {
    if (_currentIndex < widget.suite.fotos.length - 1) {
      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      _pageController.jumpToPage(0);
    }
  }

  void _prevImage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      _pageController.jumpToPage(widget.suite.fotos.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Card(
            color: Colors.white,
            margin: EdgeInsets.zero,
            elevation: 4,
            child: Column(
              children: [
                // **Carrossel de Imagens**
                Stack(
                  children: [
                    SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: widget.suite.fotos.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.network(
                              widget.suite.fotos[index],
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),

                    if (widget.suite.fotos.length > 1) ...[
                      Positioned(
                        left: 10,
                        top: 100,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: _prevImage,
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 100,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                          onPressed: _nextImage,
                        ),
                      ),
                    ],

                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          widget.suite.fotos.length,
                              (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _currentIndex == index ? 10 : 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: _currentIndex == index ? Colors.white : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // **Nome da Suíte e Quantidade Disponível**
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.suite.nome,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      if (widget.suite.exibirQtdDisponiveis)
                        Text(
                          "Só mais ${widget.suite.qtd} pelo app",
                          style: const TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                ),

                // **Itens da Suíte**
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuiteDetailsScreen(suite: widget.suite),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: widget.suite.categoriaItens
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "ver",
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Card(
            color: Colors.white,
            margin: EdgeInsets.zero,
            elevation: 4,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.motel.logo,
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
                        Row(
                          children: [
                            Text(
                              widget.motel.fantasia,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 5),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 16),
                                Text(" ${widget.motel.media}"),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          "${widget.motel.distancia} km - ${widget.motel.bairro}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: const [
                      Text("mais info", style: TextStyle(fontSize: 12, color: Colors.grey)),
                      SizedBox(width: 4),
                      Icon(Icons.expand_more, size: 16, color: Colors.grey),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            color: Colors.white,
            margin: EdgeInsets.zero,
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "início do período",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "IMEDIATO",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_forward, size: 24, color: Colors.black),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "período",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.periodo.tempoFormatado.toUpperCase(),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),

                        ],
                      ),
                    ],
                  ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.only(top: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPriceRow("valor da suíte", widget.periodo.valor),
                      const Divider(),
                      _buildPriceRow("taxa de serviço", taxa, hasInfoIcon: true),
                      const Divider(),
                      _buildPriceRow("valor total da reserva", (widget.periodo.valorTotal+taxa), isBold: true),
                      const SizedBox(height: 16),

                      // Seção de etapas de pagamento
                      buildEtapasPagamento(taxa, widget.periodo.valorTotal),
                    ],
                  ),
                ),
              ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

        ],
      ),
    );
  }
}


Widget _buildPriceRow(String label, double value, {bool isBold = false, bool hasInfoIcon = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (hasInfoIcon)
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(Icons.info_outline, size: 16, color: Colors.grey),
              ),
          ],
        ),
        Text(
          "R\$ ${value.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

Widget buildEtapasPagamento(double taxa, double valorTotal) {


  return Column(
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade700, width: 1.2),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade700,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Center(
                              child: Text(
                                "1",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "pague agora para reservar",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      Text(
                        "R\$ $taxa",
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(thickness: 1, color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade700,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Center(
                              child: Text(
                                "2",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "pague o restante no motel",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      Text(
                        "R\$ ${valorTotal}",
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "etapas de pagamento",
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
