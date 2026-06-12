import 'package:flutter/material.dart';

class MobileDrawer extends StatelessWidget {
  // প্রতিটি আইটেমের জন্য আলাদা ফাংশন রিসিভ করার ভ্যারিয়েবল
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onLeadershipTap;
  final VoidCallback onActivitiesTap;
  final VoidCallback onNewsTap;
  final VoidCallback onGalleryTap;
  final VoidCallback onContactTap;
  final VoidCallback onJoinTap;

  const MobileDrawer({
    super.key,
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onLeadershipTap,
    required this.onActivitiesTap,
    required this.onNewsTap,
    required this.onGalleryTap,
    required this.onContactTap,
    required this.onJoinTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ইসলামী ছাত্র আন্দোলন বাংলাদেশ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18, // ফন্ট সাইজ একটু ছোট করা হয়েছে যাতে মোবাইল স্ক্রিনে ধরে
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'প্রাইভেট বিশ্ববিদ্যালয় উইং',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // এখানে ফাংশনগুলো পাস করা হচ্ছে
          _drawerItem('হোম', onHomeTap),
          _drawerItem('আমাদের সম্পর্কে', onAboutTap),
          _drawerItem('নেতৃত্ব', onLeadershipTap),
          _drawerItem('কার্যক্রম', onActivitiesTap),
          _drawerItem('সংবাদ', onNewsTap),
          _drawerItem('গ্যালারি', onGalleryTap),
          _drawerItem('যোগাযোগ', onContactTap),
          _drawerItem('সদস্য হোন', onJoinTap),
        ],
      ),
    );
  }

  // হেল্পার উইজেট (স্ট্যাটিক রাখা হয়নি যাতে সরাসরি ফাংশন এক্সেস করা যায়)
  Widget _drawerItem(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      onTap: onTap, // মেইন পেজের ফাংশনটি এখান থেকে কল হবে
    );
  }
}