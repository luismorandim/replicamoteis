import 'package:flutter/material.dart';

import 'image_preview_screen.dart';

class GalleryScreen extends StatelessWidget {
  final List<String> images;
  final String suiteName;

  const GalleryScreen({Key? key, required this.images, required this.suiteName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left, color: Colors.black, size: 32), // Ícone atualizado
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "$suiteName",
          style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImagePreviewScreen(
                      images: images,
                      initialIndex: index,
                      suiteName: suiteName,
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(images[index], fit: BoxFit.cover),
              ),
            );
          },
        ),
      ),
    );
  }
}
