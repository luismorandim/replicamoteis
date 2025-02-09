import 'package:flutter/material.dart';
import '../models/suite.dart';

class SuiteDetailsScreen extends StatelessWidget {
  final Suite suite;

  const SuiteDetailsScreen({Key? key, required this.suite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          suite.nome,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("principais itens"),
            const SizedBox(height: 8),
            _buildMainItems(),
            const SizedBox(height: 20),
            _buildSectionTitle("tem também"),
            const SizedBox(height: 8),
            _buildOtherItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.black)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(title, style: const TextStyle( fontSize: 22)),
        ),
        const Expanded(child: Divider(color: Colors.black)),
      ],
    );
  }

  Widget _buildMainItems() {
    return Column(
      children: suite.categoriaItens.map((item) {
        return Row(
          children: [
            Image.network(item.icone, width: 24, height: 24),
            const SizedBox(width: 8),
            Text(item.nome, style: const TextStyle(fontSize: 16)),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildOtherItems() {
    String itensFormatados = suite.itens.map((item) => item.nome).join(", ");

    return Text(
      itensFormatados,
      style: const TextStyle(fontSize: 14),
    );
  }
}
