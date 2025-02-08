import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/motel.dart';

class MotelService {
  final String apiUrl = "https://api.npoint.io/e728bb91e0cd56cc0711";

  Future<List<Motel>> fetchMoteis() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['sucesso'] == true) {
          List<dynamic> moteisData = jsonResponse['data']['moteis'];
          return moteisData.map((motel) => Motel.fromJson(motel)).toList();
        } else {
          throw Exception("Erro na resposta da API");
        }
      } else {
        throw Exception("Falha ao conectar à API: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao buscar motéis: $e");
      throw Exception("Erro ao carregar os motéis");
    }
  }
}
