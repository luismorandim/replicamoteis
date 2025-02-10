import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:replicamoteis/widgets/filtro_widget.dart';
import 'package:replicamoteis/screens/filter_screen.dart';

void main() {
  group("FiltersBar - Testes Unitários", () {
    testWidgets("Filtros padrão devem ser exibidos", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FiltersBar(
            selectedFilters: {
              'suiteItens': [],
              'onlyDiscounted': false,
              'onlyAvailable': false,
            },
            onFilterChanged: (filters) {},
            onFilterPressed: () {},
          ),
        ),
      ));

      expect(find.text("Filtros"), findsOneWidget);
      expect(find.text("Com Desconto"), findsOneWidget);
      expect(find.text("Disponíveis"), findsOneWidget);
    });

    testWidgets("Selecionar um filtro ativa a cor vermelha", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FiltersBar(
            selectedFilters: {
              'suiteItens': ["Hidro"],
              'onlyDiscounted': false,
              'onlyAvailable': false,
            },
            onFilterChanged: (filters) {},
            onFilterPressed: () {},
          ),
        ),
      ));

      await tester.tap(find.text("Hidro"));
      await tester.pump();

      expect(find.text("Hidro"), findsOneWidget);
    });

    testWidgets("Ao clicar em 'Filtros', deve abrir a FiltersScreen", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return FiltersBar(
                selectedFilters: {
                  'suiteItens': [],
                  'onlyDiscounted': false,
                  'onlyAvailable': false,
                },
                onFilterChanged: (filters) {},
                onFilterPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FiltersScreen(
                      initialFilters: {},
                      onApplyFilters: (filters) {},
                    )),
                  );
                },
              );
            },
          ),
        ),
      ));

      await tester.tap(find.text("Filtros"));
      await tester.pumpAndSettle();

      expect(find.byType(FiltersScreen), findsOneWidget);
    });
  });
}
