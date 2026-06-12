import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        children: [
          const Text(
            'আমাদের সম্পর্কে',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'ইসলামী ছাত্র আন্দোলন বাংলাদেশ, প্রাইভেট বিশ্ববিদ্যালয় উইং আদর্শ, নৈতিকতা ও নেতৃত্ব বিকাশে শিক্ষার্থীদের নিয়ে কাজ করে।',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text('আরও পড়ুন'),
          ),
        ],
      ),
    );
  }
}