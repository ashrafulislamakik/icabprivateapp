import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_providers.dart';


class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 900;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isMobile ? 20 : size.width * 0.1,
      ),
      color: isDark ? Colors.black.withOpacity(0.1) : Colors.white,
      child: isMobile
          ? Column(
        children: _buildContent(context, isDark, isMobile),
      )
          : Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // বাম পাশ: টেক্সট কন্টেন্ট
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildContent(context, isDark, isMobile),
            ),
          ),
          const SizedBox(width: 50),
          // ডান পাশ: ইমেজ বা গ্রাফিক
          Expanded(
            flex: 1,
            child: _buildAboutImage(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildContent(BuildContext context, bool isDark, bool isMobile) {
    return [
      // ছোট ট্যাগ
      Text(
        'আমাদের সম্পর্কে জানুন',
        style: TextStyle(
          color: Colors.green.shade700,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          fontSize: 14,
        ),
      ),
      const SizedBox(height: 15),
      // মেইন টাইটেল
      Text(
        'নৈতিক নেতৃত্ব গঠনে\nএকটি আদর্শিক কাফেলা',
        textAlign: isMobile ? TextAlign.center : TextAlign.start,
        style: TextStyle(
          fontSize: isMobile ? 32 : 45,
          fontWeight: FontWeight.w900,
          color: isDark ? Colors.white : Colors.black87,
          height: 1.2,
        ),
      ),
      const SizedBox(height: 25),
      // বর্ণনা
      Text(
        'ইসলামী ছাত্র আন্দোলন বাংলাদেশ, প্রাইভেট বিশ্ববিদ্যালয় উইং আদর্শ, নৈতিকতা ও নেতৃত্ব বিকাশে শিক্ষার্থীদের নিয়ে কাজ করে। আমরা বিশ্বাস করি একদল দক্ষ ও দেশপ্রেমিক তরুণই পারে একটি সুন্দর আগামীর বাংলাদেশ গড়তে।',
        textAlign: isMobile ? TextAlign.center : TextAlign.start,
        style: TextStyle(
          fontSize: 18,
          color: isDark ? Colors.white70 : Colors.black54,
          height: 1.6,
        ),
      ),
      const SizedBox(height: 35),
      // মূল বৈশিষ্ট্যসমূহ (Bullet points with icons)
      _buildPoint(Icons.check_circle_outline, 'নৈতিক ও মানবিক মূল্যবোধ তৈরি', isDark),
      _buildPoint(Icons.check_circle_outline, 'দক্ষ ও সৎ নেতৃত্ব বিকাশ', isDark),
      _buildPoint(Icons.check_circle_outline, 'দেশপ্রেমিক নাগরিক হিসেবে গড়ে তোলা', isDark),

      const SizedBox(height: 40),
      // বাটন
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade700,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 22),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 5,
        ),
        child: const Text(
          'আরও পড়ুন',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    ];
  }

  Widget _buildPoint(IconData icon, String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.green, size: 24),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // ব্যাকগ্রাউন্ড ডিজাইন এলিমেন্ট
        Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        // মেইন ইমেজ
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.network(
            'https://images.unsplash.com/photo-1523240795612-9a054b0db644?q=80&w=2070', // এখানে আপনার প্রজেক্টের ছবি দিতে পারেন
            width: 380,
            height: 380,
            fit: BoxFit.cover,
          ),
        ),
        // অভিজ্ঞতার ছোট একটি কার্ড (Modern touch)
        Positioned(
          bottom: 20,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))
              ],
            ),
            child: Column(
              children: [
                Text(
                  '৩০+',
                  style: TextStyle(color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text('বিশ্ববিদ্যালয় উইং', style: TextStyle(color: Colors.black54, fontSize: 12)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}