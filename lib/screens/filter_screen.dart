import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  final Map<String, dynamic> initialFilters;
  final Function(Map<String, dynamic>) onApplyFilters;

  const FiltersScreen({
    Key? key,
    required this.initialFilters,
    required this.onApplyFilters,
  }) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  double _selectedMinPrice = 30.0;
  double _selectedMaxPrice = 2030.0;
  String? _selectedPeriod;
  bool _onlyDiscounted = false;
  bool _onlyAvailable = false;
  List<String> _selectedSuiteItems = [];

  @override
  void initState() {
    super.initState();
    _loadInitialFilters();
  }

  void _loadInitialFilters() {
    setState(() {
      _selectedMinPrice = (widget.initialFilters['minPrice'] ?? 30).toDouble();
      _selectedMaxPrice = (widget.initialFilters['maxPrice'] ?? 2030).toDouble();

      _selectedPeriod = widget.initialFilters['periodo'];

      _onlyDiscounted = widget.initialFilters['onlyDiscounted'] ?? false;
      _onlyAvailable = widget.initialFilters['onlyAvailable'] ?? false;

      _selectedSuiteItems = List<String>.from(widget.initialFilters['suiteItens'] ?? []);
    });
  }

  void _applyFilters() {
    widget.onApplyFilters({
      'minPrice': _selectedMinPrice,
      'maxPrice': _selectedMaxPrice,
      'periodo': _selectedPeriod,
      'suiteItens': _selectedSuiteItems,
      'onlyDiscounted': _onlyDiscounted,
      'onlyAvailable': _onlyAvailable,
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Filtros"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPriceSlider(),
            _buildPeriodos(),
            _buildSuiteItens(),
            _buildSwitch("Somente suítes com desconto", _onlyDiscounted, (value) {
              setState(() {
                _onlyDiscounted = value;
              });
            }),
            _buildSwitch("Somente suítes disponíveis", _onlyAvailable, (value) {
              setState(() {
                _onlyAvailable = value;
              });
            }),
            _buildApplyButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Faixa de preço"),
        RangeSlider(
          values: RangeValues(_selectedMinPrice, _selectedMaxPrice),
          min: 30,
          max: 2030,
          onChanged: (values) {
            setState(() {
              _selectedMinPrice = values.start;
              _selectedMaxPrice = values.end;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("R\$ ${_selectedMinPrice.toInt()}"),
            Text("R\$ ${_selectedMaxPrice.toInt()}"),
          ],
        ),
      ],
    );
  }

  Widget _buildPeriodos() {
    List<String> periodos = [
      "1 hora", "2 horas", "3 horas", "4 horas", "5 horas", "6 horas",
      "7 horas", "8 horas", "9 horas", "10 horas", "11 horas", "12 horas",
      "perdia", "pernoite"
    ];

    return _buildSection("Períodos", Wrap(
      spacing: 8,
      children: periodos.map((p) {
        bool isSelected = _selectedPeriod == p;
        return FilterChip(
          label: Text(p),
          selected: isSelected,
          onSelected: (_) {
            setState(() {
              _selectedPeriod = isSelected ? null : p;
            });
          },
        );
      }).toList(),
    ));
  }

  Widget _buildSuiteItens() {
    List<String> suiteItens = [
      "Hidro", "Piscina", "Sauna", "Ofurô",
      "Decoração Erótica", "Decoração Temática",
      "Cadeira Erótica", "Pista de Dança",
      "Garagem Privativa", "Frigobar",
      "Internet Wi-Fi", "Suíte para Festas",
      "Suíte com Acessibilidade"
    ];

    return _buildSection("Itens da Suíte", Wrap(
      spacing: 8,
      children: suiteItens.map((item) {
        bool isSelected = _selectedSuiteItems.contains(item);
        return FilterChip(
          label: Text(item),
          selected: isSelected,
          onSelected: (_) {
            setState(() {
              if (isSelected) {
                _selectedSuiteItems.remove(item);
              } else {
                _selectedSuiteItems.add(item);
              }
            });
          },
        );
      }).toList(),
    ));
  }

  Widget _buildSwitch(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          content,
        ],
      ),
    );
  }

  Widget _buildApplyButton() {
    return Container(
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _applyFilters,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade700),
        child: const Text("VERIFICAR DISPONIBILIDADE", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
