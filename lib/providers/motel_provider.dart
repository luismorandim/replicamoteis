import 'package:flutter/material.dart';
import '../models/motel.dart';
import '../service/motel_service.dart';

class MotelProvider extends ChangeNotifier {
  final MotelService _motelService = MotelService();
  List<Motel> _moteis = [];
  bool _isLoading = false;

  List<Motel> get moteis => _moteis;
  bool get isLoading => _isLoading;

  Future<void> fetchMoteis() async {
    _isLoading = true;
    notifyListeners();

    try {
      List<Motel> motels = await _motelService.fetchMoteis();
      debugPrint("Quantidade de motéis recebidos: ${motels.length}");
      debugPrint("Lista completa: $motels");

      if (motels.isNotEmpty) {
        _moteis = motels;
      } else {
        _moteis = [];
      }
    }
    catch (e) {
      debugPrint('Erro ao buscar motéis: $e');
      _moteis = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
