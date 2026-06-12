import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: double.infinity,
      color: Colors.green.shade700,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'নৈতিক নেতৃত্ব গঠনে\nতরুণদের ঐক্যবদ্ধ প্ল্যাটফর্ম',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'ইসলামী মূল্যবোধ, জ্ঞানচর্চা এবং নেতৃত্ব বিকাশের মাধ্যমে দেশ ও জাতির কল্যাণে নিবেদিত একটি ছাত্র সংগঠন।',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 20,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('সদস্য হোন'),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Text('বিস্তারিত জানুন'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}