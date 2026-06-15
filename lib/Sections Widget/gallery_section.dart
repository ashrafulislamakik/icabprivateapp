import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/gallery_image_card.dart';

class GallerySection extends StatefulWidget {
  const GallerySection({super.key});

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection> {
  // আপনার GitHub তথ্য
  final String username = "ashrafulislamakik";
  final String repo = "my_gallery";
  final String folderPath = ""; // যদি রুট ফোল্ডারে থাকে তবে খালি রাখুন

  late Future<List<String>> _galleryFuture;

  @override
  void initState() {
    super.initState();
    // initState-এ কল করার কারণে বারবার API রিকোয়েস্ট যাবে না
    _galleryFuture = _fetchGitHubImages();
  }

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
      } else if (response.statusCode == 403) {
        debugPrint("GitHub API Limit Exceeded. Please wait or use a Token.");
        return [];
      } else {
        return [];
      }
    } catch (e) {
      debugPrint("Error fetching images: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: isDark ? const Color(0xFF0A0A0A) : Colors.grey.shade50,
      child: Column(
        children: [
          // শিরোনাম সেকশন
          Text(
            'আমাদের ফটো গ্যালারি',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.green.shade900,
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),

          const SizedBox(height: 15),
          Container(
            height: 4,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 50),

          // গ্যালারি গ্রিড
          FutureBuilder<List<String>>(
            future: _galleryFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.green),
                );
              }

              if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
                return _buildErrorState(isDark);
              }

              final images = snapshot.data!;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 900 ? 4 : (MediaQuery.of(context).size.width > 600 ? 3 : 2),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  // এখানে পরিবর্তন করা হয়েছে
                  return gallery_image_card(
                    imageUrl: images[index],
                    index: index,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }


  Widget _buildErrorState(bool isDark) {
    return Column(
      children: [
        Icon(Icons.photo_library_outlined, size: 60, color: Colors.grey.shade400),
        const SizedBox(height: 10),
        Text(
          "এখনও কোনো ছবি পাওয়া যায়নি\nঅথবা API লিমিট শেষ হয়েছে।",
          textAlign: TextAlign.center,
          style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
        ),
      ],
    );
  }
}