import 'suite.dart'; // Certifique-se de importar a classe Suite

class Motel {
  final String nome;
  final String fantasia;
  final String bairro;
  final double distancia;
  final String logo;
  final double media;
  final int qtdAvaliacoes;
  final List<Suite> suites;
  final double? desconto; // Desconto pode ser nulo

  Motel({
    required this.nome,
    required this.fantasia,
    required this.bairro,
    required this.distancia,
    required this.logo,
    required this.media,
    required this.qtdAvaliacoes,
    required this.suites,
    this.desconto,
  });

  Motel copyWith({List<Suite>? suites}) {
    return Motel(
      nome: this.nome,
      fantasia: this.fantasia,
      bairro: this.bairro,
      distancia: this.distancia,
      logo: this.logo,
      media: this.media,
      qtdAvaliacoes: this.qtdAvaliacoes,
      suites: suites ?? this.suites,
      desconto: this.desconto,
    );
  }

  factory Motel.fromJson(Map<String, dynamic> json) {
    return Motel(
      nome: json["nome"] ?? "", // Se for null, define como ""
      fantasia: json["fantasia"] ?? "",
      bairro: json["bairro"] ?? "",
      distancia: (json["distancia"] as num?)?.toDouble() ?? 0.0, // Se for null, define 0.0
      logo: json["logo"] ?? "",
      media: (json["media"] as num?)?.toDouble() ?? 0.0,
      qtdAvaliacoes: json["qtdAvaliacoes"] ?? 0,
      suites: (json["suites"] as List?)?.map((suite) => Suite.fromJson(suite)).toList() ?? [],
      desconto: json["desconto"] != null ? (json["desconto"] as num).toDouble() : null,
    );
  }
}
