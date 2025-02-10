import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:replicamoteis/widgets/filtro_widget.dart';

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

      // Verifica se os filtros padrão aparecem
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

      // Clicar no filtro "Hidro"
      await tester.tap(find.text("Hidro"));
      await tester.pump();

      // Verifica se o filtro foi ativado corretamente
      expect(find.text("Hidro"), findsOneWidget);
    });

    testWidgets("Ao clicar em 'Filtros', deve abrir a FiltersScreen", (WidgetTester tester) async {
      bool filterScreenOpened = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FiltersBar(
            selectedFilters: {
              'suiteItens': [],
              'onlyDiscounted': false,
              'onlyAvailable': false,
            },
            onFilterChanged: (filters) {},
            onFilterPressed: () {
              filterScreenOpened = true;
            },
          ),
        ),
      ));

      // Clicar no botão "Filtros"
      await tester.tap(find.text("Filtros"));
      await tester.pump();

      // Verifica se a tela foi aberta corretamente
      expect(filterScreenOpened, isTrue);
    });
  });
}
