class SuiteItem {
  final String nome;

  SuiteItem({required this.nome});

  factory SuiteItem.fromJson(Map<String, dynamic> json) {
    return SuiteItem(nome: json["nome"]);
  }
}