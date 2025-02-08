import 'suite.dart';

class Motel {
  final String fantasia;
  final String logo;
  final String bairro;
  final double distancia;
  final double media;
  final List<Suite> suites;
  final int qtdAvaliacoes;
  final double desconto;

  Motel({
    required this.fantasia,
    required this.logo,
    required this.bairro,
    required this.distancia,
    required this.media,
    required this.suites,
    required this.qtdAvaliacoes,
    required this.desconto,
  });

  factory Motel.fromJson(Map<String, dynamic> json) {
    return Motel(
      desconto: (json['desconto'] ?? 0).toDouble(),
      fantasia: json['fantasia'] ?? "Sem Nome",
      logo: json['logo'] ?? "",
      bairro: json['bairro'] ?? "Sem Bairro",
      distancia: (json['distancia'] as num).toDouble(),
      media: (json['media'] ?? 0.0).toDouble(),
      qtdAvaliacoes: json['qtdAvaliacoes'] ?? 0,
      suites: (json['suites'] as List<dynamic>).map((suite) => Suite.fromJson(suite)).toList(),
    );
  }
}
