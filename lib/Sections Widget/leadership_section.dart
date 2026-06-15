import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/theme_providers.dart';

class LeadershipSection extends StatelessWidget {
  const LeadershipSection({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
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

    // লিডারদের ডাটা (এখানে image পাথগুলো বসানো হয়েছে)
    final leaders = [
      {
        'name': 'মোঃ আব্দুল্লাহ',
        'designation': 'সভাপতি',
        'image': 'assets/images/akik.jpg', // আপনার ছবির নাম অনুযায়ী দিন
        'fb': 'https://www.facebook.com/ashraful3195',
        'email': 'mailto:president@example.com'
      },
      {
        'name': 'মোঃ হাসান',
        'designation': 'সহ-সভাপতি',
        'image': 'assets/images/leader2.png',
        'fb': 'https://facebook.com/username2',
        'email': 'mailto:vp@example.com'
      },
      {
        'name': 'মোঃ রহমান',
        'designation': 'সাধারণ সম্পাদক',
        'image': 'assets/images/leader3.png',
        'fb': 'https://facebook.com/username3',
        'email': 'mailto:gs@example.com'
      },
      {
        'name': 'মোঃ ইব্রাহিম',
        'designation': 'সাংগঠনিক সম্পাদক',
        'image': 'assets/images/leader4.png',
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
                  gradient: const LinearGradient(colors: [Colors.green, Colors.lightGreen]),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 70),

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
              // আইকনের বদলে এখন এসেট ইমেজ ব্যবহার করা হয়েছে
              CircleAvatar(
                radius: 50,
                backgroundColor: isDark ? Colors.black : Colors.grey.shade200,
                backgroundImage: AssetImage(leader['image']!), // এসেট ইমেজ এখানে আসবে
                // যদি ছবি লোড না হয় তবে এই অংশটি এরর থেকে বাঁচাবে
                onBackgroundImageError: (exception, stackTrace) {
                  debugPrint('Image not found: ${leader['image']}');
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
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