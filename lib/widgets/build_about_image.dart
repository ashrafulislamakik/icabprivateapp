import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_providers.dart';

class build_about_image extends StatelessWidget {
  const build_about_image({super.key});

  @override
  Widget build(BuildContext context) {

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
