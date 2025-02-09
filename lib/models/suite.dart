import 'categoria_item.dart';
import 'suite_item.dart';
import 'periodo.dart';

class Suite {
  final String nome;
  final int qtd;
  final bool exibirQtdDisponiveis;
  final List<String> fotos;
  final List<SuiteItem> itens;
  final List<CategoriaItem> categoriaItens;
  final List<Periodo> periodos;

  Suite({
    required this.nome,
    required this.qtd,
    required this.exibirQtdDisponiveis,
    required this.fotos,
    required this.itens,
    required this.categoriaItens,
    required this.periodos,
  });

  factory Suite.fromJson(Map<String, dynamic> json) {
    return Suite(
      nome: json["nome"],
      qtd: json["qtd"],
      exibirQtdDisponiveis: json["exibirQtdDisponiveis"],
      fotos: List<String>.from(json["fotos"]),
      itens: (json["itens"] as List).map((item) => SuiteItem.fromJson(item)).toList(),
      categoriaItens: (json["categoriaItens"] as List)
          .map((item) => CategoriaItem.fromJson(item))
          .toList(),
      periodos: (json["periodos"] as List).map((p) => Periodo.fromJson(p)).toList(),
    );
  }
}