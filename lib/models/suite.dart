import 'package:replicamoteis/models/periodo.dart';

class Suite {
  final String nome;
  final int qtd;
  final bool exibirQtdDisponiveis;
  final List<String> fotos;
  final List<String> itens;
  final List<Map<String, String>> categoriaItens;
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
      nome: json['nome'] ?? '',
      qtd: json['qtd'] ?? 0,
      exibirQtdDisponiveis: json['exibirQtdDisponiveis'] ?? false,
      fotos: List<String>.from(json['fotos'] ?? []),
      itens: (json['itens'] as List<dynamic>).map((e) => e['nome'].toString()).toList(),
      categoriaItens: (json['categoriaItens'] as List<dynamic>)
          .map((e) => {'nome': e['nome'].toString(), 'icone': e['icone'].toString()})
          .toList(),
      periodos: (json['periodos'] as List<dynamic>).map((e) => Periodo.fromJson(e)).toList(),
    );
  }
}


