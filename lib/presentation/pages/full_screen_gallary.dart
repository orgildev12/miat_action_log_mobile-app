import 'dart:io';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';

class FullScreenGallery extends StatefulWidget {
  final List<File> images;
  final int initialIndex;

  const FullScreenGallery({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<FullScreenGallery> createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<FullScreenGallery> {
  late PageController _pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: widget.images.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final file = widget.images[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: InteractiveViewer(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(
                          file,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.close_rounded, color: primaryColor, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
