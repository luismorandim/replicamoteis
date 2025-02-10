import 'package:flutter/material.dart';
import '../models/motel.dart';
import '../models/suite.dart';
import '../service/motel_service.dart';
import '../widgets/app_bar_custom.dart';
import '../widgets/filtro_widget.dart';
import '../widgets/motel_highlight_card.dart';
import '../widgets/motel_card.dart';
import 'filter_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Motel>> _futureMoteis;
  List<Motel> _allMoteis = [];
  List<Motel> _filteredMoteis = [];
  bool _isLoading = false;

  Map<String, dynamic> _selectedFilters = {
    'minPrice': 30,
    'maxPrice': 2030,
    'periodo': null,
    'suiteItens': [],
    'onlyDiscount': false,
    'onlyAvailable': false,
  };

  @override
  void initState() {
    super.initState();
    _futureMoteis = MotelService().fetchMoteis();
  }

  void _applyFilters(Map<String, dynamic> filters) {
    setState(() {
      _selectedFilters = filters;
      print("🔎 Filtros Aplicados: $_selectedFilters");
    });



    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _filteredMoteis = _allMoteis.map((motel) {
          List<Suite> filteredSuites = motel.suites.where((suite) {
            if (_selectedFilters['onlyDiscount'] == true &&
                !suite.periodos.any((p) => p.desconto != null)) {
              return false;
            }

            if (_selectedFilters['onlyAvailable'] == true && suite.qtd <= 0) {
              return false;
            }

            if (_selectedFilters['suiteItens'] != null &&
                _selectedFilters['suiteItens'].isNotEmpty) {
              List<String> selectedItens =
              List<String>.from(_selectedFilters['suiteItens']);

              bool containsAll = selectedItens.every((item) =>
                  suite.itens.any((suiteItem) =>
                  suiteItem.nome.toLowerCase() == item.toLowerCase()));

              if (!containsAll) return false;
            }

            return true;
          }).toList();

          return filteredSuites.isNotEmpty
              ? motel.copyWith(suites: filteredSuites)
              : null;
        }).where((motel) => motel != null).cast<Motel>().toList();

        print("📊 Total de Suítes Após Filtro: ${_filteredMoteis.fold(0, (sum, motel) => sum + motel.suites.length)}");

        _isLoading = false;
      });
    });
  }

  void _openFiltersScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FiltersScreen(
          initialFilters: _selectedFilters,
          onApplyFilters: _applyFilters,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: FutureBuilder<List<Motel>>(
        future: _futureMoteis,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar os motéis"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhum motel disponível"));
          }

          if (_allMoteis.isEmpty) {
            _allMoteis = snapshot.data!;
            _filteredMoteis = _allMoteis;
          }

          return Column(
            children: [
              MotelHighlightCard(
                motel: _filteredMoteis.isNotEmpty
                    ? _filteredMoteis.first
                    : _allMoteis.first,
              ),
              FiltersBar(
                selectedFilters: _selectedFilters,
                onFilterChanged: _applyFilters,
                onFilterPressed: _openFiltersScreen,
              ),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : (_filteredMoteis.isNotEmpty
                    ? ListView.builder(
                  itemCount: _filteredMoteis.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        MotelCard(motel: _filteredMoteis[index]),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                )
                    : const Center(
                  child: Text(
                    "Nenhuma suíte encontrada com os filtros selecionados",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )),
              ),
            ],
          );
        },
      ),
    );
  }
}
