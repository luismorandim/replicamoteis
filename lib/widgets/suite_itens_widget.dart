import 'package:flutter/material.dart';
import '../models/categoria_item.dart';

class SuiteItensWidget extends StatelessWidget {
  final List<CategoriaItem> categoriaItens;
  final VoidCallback onVerTodos;

  const SuiteItensWidget({
    Key? key,
    required this.categoriaItens,
    required this.onVerTodos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onVerTodos,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 340,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categoriaItens
                        .where((item) => item.icone.isNotEmpty)
                        .map((item) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Image.network(
                        item.icone,
                        width: 36,
                        height: 36,
                      ),
                    ))
                        .toList(),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "ver",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "todos",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.expand_more, size: 16, color: Colors.grey),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
