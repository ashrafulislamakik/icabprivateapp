import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GallerySection extends StatefulWidget {
  const GallerySection({super.key});

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection> {
  final String username = "ashrafulislamakik";
  final String repo = "my_gallery";
  final String folderPath = "";

  Future<List<String>> _fetchGitHubImages() async {
    final url = 'https://api.github.com/repos/$username/$repo/contents/$folderPath';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data
            .where((file) =>
        file['name'].toLowerCase().endsWith('.png') ||
            file['name'].toLowerCase().endsWith('.jpg') ||
            file['name'].toLowerCase().endsWith('.jpeg'))
            .map((file) => file['download_url'] as String)
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F0F0F) : Colors.white,
      ),
      child: Column(
        children: [
          // আধুনিক হেডলাইন ডিজাইন
          Column(
            children: [
              Text(
                'আমাদের গ্যালারি',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  color: isDark ? Colors.white : Colors.black87,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.green, Colors.lightGreenAccent]),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),

          FutureBuilder<List<String>>(
            future: _fetchGitHubImages(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildShimmerLoading(isDark);
              }

              if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                return _buildEmptyState(isDark);
              }

              final images = snapshot.data!;

              return Wrap(
                spacing: 30,
                runSpacing: 30,
                alignment: WrapAlignment.center,
                children: images.map((url) => _buildModernImageCard(context, url, isDark)).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  // আধুনিক ইমেজ কার্ড ডিজাইন
  Widget _buildModernImageCard(BuildContext context, String url, bool isDark) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: GestureDetector(
            onTap: () => _showFullImage(context, url),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: 320,
              height: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.4 : 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // ইমেজ উইজেট
                    Image.network(
                      url,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return _buildShimmerEffect(isDark);
                      },
                    ),
                    // হোভ্যার ইফেক্ট ওভারলে
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: isHovered ? 1.0 : 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.green.withOpacity(0.6),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Icon(Icons.zoom_in, color: Colors.white, size: 50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // শিমার লোডিং ইফেক্ট
  Widget _buildShimmerLoading(bool isDark) {
    return Wrap(
      spacing: 30,
      runSpacing: 30,
      children: List.generate(3, (index) => _buildShimmerEffect(isDark)),
    );
  }

  Widget _buildShimmerEffect(bool isDark) {
    return Container(
      width: 320,
      height: 240,
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(28),
      ),
      child: const Center(
        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.green),
      ),
    );
  }

  // খালি অবস্থার ডিজাইন
  Widget _buildEmptyState(bool isDark) {
    return Column(
      children: [
        Icon(Icons.image_not_supported_outlined, size: 80, color: Colors.grey.withOpacity(0.5)),
        const SizedBox(height: 20),
        Text(
          'গ্যালারি বর্তমানে খালি',
          style: TextStyle(fontSize: 18, color: isDark ? Colors.white54 : Colors.black45),
        ),
      ],
    );
  }

  // প্রিমিয়াম ফুল স্ক্রিন ভিউ
  void _showFullImage(BuildContext context, String url) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.9),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(url, fit: BoxFit.contain),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 30,
                child: IconButton(
                  icon: const Icon(Icons.close_fullscreen_rounded, color: Colors.white, size: 35),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: ScaleTransition(scale: anim1, child: child),
        );
      },
    );
  }
}