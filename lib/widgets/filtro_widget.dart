import 'package:flutter/material.dart';
import '../screens/filter_screen.dart';

class FiltersBar extends StatefulWidget {
  final Function(Map<String, dynamic>) onFilterChanged;
  final Map<String, dynamic> selectedFilters;
  final VoidCallback onFilterPressed;

  const FiltersBar({
    Key? key,
    required this.onFilterChanged,
    required this.selectedFilters,
    required this.onFilterPressed,
  }) : super(key: key);

  @override
  _FiltersBarState createState() => _FiltersBarState();
}

class _FiltersBarState extends State<FiltersBar> {
  final List<String> staticFilters = ["Filtros", "Com Desconto", "Disponíveis"];

  final List<String> suiteItensFixos = [
    "Hidro",
    "Piscina",
    "Sauna",
    "Ofurô",
    "Decoração Erótica",
    "Decoração Temática",
    "Cadeira Erótica",
    "Pista de Dança",
    "Garagem Privativa",
    "Frigobar",
    "Internet Wi-Fi",
    "Suíte para Festas",
    "Suíte com Acessibilidade"
  ];

  List<String> get activeFilters {
    List<String> filters = List.from(staticFilters);

    filters.addAll(suiteItensFixos);

    return filters.toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: activeFilters.map((filter) {
            return _buildFilterChip(filter);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    bool isActive = widget.selectedFilters['suiteItens']?.contains(label) == true ||
        widget.selectedFilters['onlyDiscounted'] == true && label == "Com Desconto" ||
        widget.selectedFilters['onlyAvailable'] == true && label == "Disponíveis";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () async {
          if (label == "Filtros") {
            final updatedFilters = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FiltersScreen(
                  initialFilters: widget.selectedFilters,
                  onApplyFilters: widget.onFilterChanged,
                ),
              ),
            );

            if (updatedFilters != null) {
              widget.onFilterChanged(updatedFilters);
            }
          } else {
            Map<String, dynamic> newFilters = Map.from(widget.selectedFilters);

            if (label == "Com Desconto") {
              newFilters['onlyDiscounted'] = !(newFilters['onlyDiscounted'] ?? false);
            } else if (label == "Disponíveis") {
              newFilters['onlyAvailable'] = !(newFilters['onlyAvailable'] ?? false);
            } else {
              List<String> suiteItens = List<String>.from(newFilters['suiteItens'] ?? []);
              if (suiteItens.contains(label)) {
                suiteItens.remove(label);
              } else {
                suiteItens.add(label);
              }
              newFilters['suiteItens'] = suiteItens;
            }

            widget.onFilterChanged(newFilters);
          }
        },
        child: Chip(
          label: Text(label),
          backgroundColor: isActive ? Colors.redAccent : Colors.grey[200],
          labelStyle: TextStyle(color: isActive ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
