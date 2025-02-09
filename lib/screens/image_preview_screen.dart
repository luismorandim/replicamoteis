import 'package:flutter/material.dart';

class ImagePreviewScreen extends StatefulWidget {
  final List<String> images;
  final int initialIndex;
  final String suiteName;

  const ImagePreviewScreen({
    Key? key,
    required this.images,
    required this.initialIndex,
    required this.suiteName,
  }) : super(key: key);

  @override
  _ImagePreviewScreenState createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  void _goToPrevious() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _goToNext() {
    if (_currentIndex < widget.images.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Center(
                child: Image.network(widget.images[index], fit: BoxFit.contain),
              );
            },
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.black, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_currentIndex > 0)
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 24),
                        onPressed: _goToPrevious,
                      ),
                    Text(widget.suiteName, style: const TextStyle(color: Colors.black, fontSize: 16)),
                    if (_currentIndex < widget.images.length - 1)
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 24),
                        onPressed: _goToNext,
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "${_currentIndex + 1}/${widget.images.length}",
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
