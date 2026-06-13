import 'package:flutter/material.dart';

class ActivitiesSection extends StatelessWidget {
  const ActivitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    // ডার্ক মোড চেক করার জন্য
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // কার্যক্রমের লিস্ট এবং সাথে আইকন
    final List<Map<String, dynamic>> activities = [
      {'title': 'দাওয়াতি কার্যক্রম', 'icon': Icons.mosque_rounded},
      {'title': 'শিক্ষা কার্যক্রম', 'icon': Icons.menu_book_rounded},
      {'title': 'সামাজিক কার্যক্রম', 'icon': Icons.groups_rounded},
      {'title': 'সেমিনার', 'icon': Icons.record_voice_over_rounded},
      {'title': 'ওয়ার্কশপ', 'icon': Icons.handyman_rounded},
      {'title': 'ক্যাম্পেইন', 'icon': Icons.campaign_rounded},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: isDark ? const Color(0xFF0F0F0F) : Colors.white,
      child: Column(
        children: [
          // আধুনিক শিরোনাম ডিজাইন
          Text(
            'আমাদের কার্যক্রম',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : Colors.green.shade900,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 5,
            width: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.green, Colors.lightGreenAccent],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 60),

          // কার্যক্রমের কার্ডগুলো
          Wrap(
            spacing: 25,
            runSpacing: 25,
            alignment: WrapAlignment.center,
            children: activities.map((activity) {
              return _buildActivityCard(
                activity['title'],
                activity['icon'],
                isDark,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // আধুনিক অ্যাক্টিভিটি কার্ড ডিজাইন
  Widget _buildActivityCard(String title, IconData icon, bool isDark) {
    return Container(
      width: 260,
      height: 180,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        // ডার্ক মোডে কার্ডের কালার হালকা ধূসর
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.green.withOpacity(0.1),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black45 : Colors.green.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // আইকন সেকশন (সার্কেল ব্যাকগ্রাউন্ডসহ)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 35,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 20),
          // টাইটেল
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}