import 'package:flutter/material.dart';

PreferredSizeWidget buildAppBar() {
  return AppBar(
    title: const Text("Ir Agora"),
    actions: [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          // Implementar pesquisa posteriormente
        },
      ),
    ],
  );
}
