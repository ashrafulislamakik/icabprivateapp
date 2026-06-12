import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart'; // লিঙ্ক ওপেন করার জন্য
import '../providers/theme_providers.dart';

class LeadershipSection extends StatelessWidget {
  const LeadershipSection({super.key});

  // লিঙ্ক ওপেন করার ফাংশন
  // লিঙ্ক ওপেন করার সংশোধিত ফাংশন
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      // LaunchMode.externalApplication দিলে এটি ব্রাউজার বা অ্যাপে ওপেন হতে বাধ্য করবে
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      // যদি উপরে কাজ না করে তবে সাধারণ পদ্ধতিতে ট্রাই করবে
      if (!await launchUrl(uri)) {
        debugPrint('Could not launch $url');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount = 4;
    if (width < 650) {
      crossAxisCount = 1;
    } else if (width < 1100) {
      crossAxisCount = 2;
    }

    final leaders = [
      {
        'name': 'মোঃ আব্দুল্লাহ',
        'designation': 'সভাপতি',
        'fb': 'https://www.facebook.com/ashraful3195',
        'email': 'https://www.facebook.com/ashraful3195'
      },
      {
        'name': 'মোঃ হাসান',
        'designation': 'সহ-সভাপতি',
        'fb': 'https://facebook.com/username2',
        'email': 'mailto:vp@example.com'
      },
      {
        'name': 'মোঃ রহমান',
        'designation': 'সাধারণ সম্পাদক',
        'fb': 'https://facebook.com/username3',
        'email': 'mailto:gs@example.com'
      },
      {
        'name': 'মোঃ ইব্রাহিম',
        'designation': 'সাংগঠনিক সম্পাদক',
        'fb': 'https://facebook.com/username4',
        'email': 'mailto:os@example.com'
      },
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      decoration: BoxDecoration(
        color: isDark ? Colors.black.withOpacity(0.3) : Colors.white,
      ),
      child: Column(
        children: [
          // প্রিমিয়াম টাইটেল
          Column(
            children: [
              Text(
                'আমাদের নেতৃত্ব',
                style: TextStyle(
                  fontSize: width < 600 ? 32 : 42,
                  fontWeight: FontWeight.w900,
                  color: isDark ? Colors.white : Colors.green.shade900,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 5,
                width: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.green, Colors.lightGreen]),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 70),

          // লিডারশিপ গ্রিড
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: leaders.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                return _buildLeaderCard(context, leaders[index], isDark);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderCard(BuildContext context, Map<String, String> leader, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.green.withOpacity(0.1),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black45 : Colors.green.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ইমেজ সেকশন উইথ গ্লো ইফেক্ট
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [Colors.green, Colors.lightGreen.withOpacity(0.2)]),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: isDark ? Colors.black : Colors.white,
                child: Icon(Icons.person, size: 55, color: Colors.green.shade700),
                // backgroundImage: AssetImage(leader['image']!),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // নাম
          Text(
            leader['name']!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          // পদবী
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              leader['designation']!,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // সোশ্যাল বাটন
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialIconButton(
                icon: Icons.facebook,
                color: const Color(0xFF1877F2),
                onTap: () => _launchURL(leader['fb']!),
              ),
              const SizedBox(width: 15),
              _socialIconButton(
                icon: Icons.email_rounded,
                color: Colors.redAccent,
                onTap: () => _launchURL(leader['email']!),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _socialIconButton({required IconData icon, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.1),
        ),
        child: Icon(icon, size: 22, color: color),
      ),
    );
  }
}