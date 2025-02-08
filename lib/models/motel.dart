import 'suite.dart';

class Motel {
  final String fantasia;
  final String logo;
  final String bairro;
  final double distancia;
  final double media;
  final List<Suite> suites;

  Motel({
    required this.fantasia,
    required this.logo,
    required this.bairro,
    required this.distancia,
    required this.media,
    required this.suites,
  });

  factory Motel.fromJson(Map<String, dynamic> json) {
    return Motel(
      fantasia: json['fantasia'] ?? "Sem Nome",
      logo: json['logo'] ?? "",
      bairro: json['bairro'] ?? "Sem Bairro",
      distancia: (json['distancia'] as num).toDouble(),
      media: (json['media'] as num).toDouble(),
      suites: (json['suites'] as List<dynamic>).map((suite) => Suite.fromJson(suite)).toList(),
    );
  }
}
