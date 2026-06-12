import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final VoidCallback? onHomeTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onLeadershipTap;
  final VoidCallback? onActivitiesTap;
  final VoidCallback? onNewsTap;
  final VoidCallback? onGalleryTap;
  final VoidCallback? onJoinTap;
  final VoidCallback? onMenuTap; // ড্রয়ার খোলার জন্য

  const Navbar({
    super.key,
    this.onHomeTap,
    this.onAboutTap,
    this.onLeadershipTap,
    this.onActivitiesTap,
    this.onNewsTap,
    this.onGalleryTap,
    this.onJoinTap,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        children: [
          const Text(
            'ICAB Private Wing',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Spacer(),
          if (width > 1000) ...[ // ডেক্সটপ ভিউ
            _navItem("হোম", onHomeTap),
            _navItem("আমাদের সম্পর্কে", onAboutTap),
            _navItem("নেতৃত্ব", onLeadershipTap),
            _navItem("কার্যক্রম", onActivitiesTap),
            _navItem("সংবাদ", onNewsTap),
            _navItem("গ্যালারি", onGalleryTap),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: onJoinTap,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("সদস্য হোন", style: TextStyle(color: Colors.white)),
            ),
          ] else // মোবাইল ভিউ
            IconButton(
              icon: const Icon(Icons.menu, size: 30, color: Colors.black),
              onPressed: onMenuTap, // এখানে ফাংশনটি কল করা হয়েছে
            ),
        ],
      ),
    );
  }

  Widget _navItem(String title, VoidCallback? onTap) {
    return TextButton(
      onPressed: onTap,
      child: Text(title, style: const TextStyle(color: Colors.black)),
    );
  }
}