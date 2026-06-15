import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 800;

    return Container(
      width: double.infinity,
      color: const Color(0xFF1A1A1A),
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isMobile ? 25 : width * 0.1, // মোবাইলে একটু বেশি প্যাডিং
      ),
      child: Column(
        // মোবাইলে সবকিছু বাম দিকে না রেখে মাঝখানে (Center) রাখলে ভালো দেখায়, তবে আপনি চাইলে CrossAxisAlignment.start রাখতে পারেন
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          // মেইন কন্টেন্ট
          isMobile
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.center, // মোবাইলে সেন্টারে থাকবে
            children: _buildFooterSections(isMobile),
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildFooterSections(isMobile),
          ),

          const SizedBox(height: 50),
          const Divider(color: Colors.white12, thickness: 1),
          const SizedBox(height: 30),

          // কপিরাইট এবং সোশ্যাল আইকন
          isMobile
              ? Column(
            children: [
              _buildSocialIcons(),
              const SizedBox(height: 20),
              _buildCopyrightText(),
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCopyrightText(),
              _buildSocialIcons(),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFooterSections(bool isMobile) {
    return [
      // ১. লোগো ও বর্ণনা
      SizedBox(
        // এখানে ৩৫০ পিক্সেল ফিক্সড না রেখে মোবাইলের জন্য স্ক্রিন উইডথ ব্যবহার করা হয়েছে
        width: isMobile ? double.infinity : 350,
        child: Column(
          crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                  backgroundImage: const AssetImage('assets/img.png'), // আপনার সঠিক লোগো পাথ দিন
                ),
                const SizedBox(width: 12),
                const Text(
                  'ICAB Private Wing',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'একটি আদর্শ সমাজ ও রাষ্ট্র গঠনে নৈতিক নেতৃত্ব বিকাশের লক্ষ্যে ইসলামী ছাত্র আন্দোলন বাংলাদেশ নিরলসভাবে কাজ করে যাচ্ছে।',
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 40),

      // ২. কুইক লিঙ্কস
      _buildLinkColumn('প্রয়োজনীয় লিঙ্ক', [
        'আমাদের সম্পর্কে',
        'কার্যক্রম',
        'সদস্য ফরম',
        'সংবাদ ও আপডেট',
      ], isMobile),

      const SizedBox(height: 40),

      // ৩. কন্টাক্ট ইনফো
      Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          const Text(
            'যোগাযোগ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildContactItem(Icons.location_on, 'পুরানা পল্টন, ঢাকা-১০০০', isMobile),
          _buildContactItem(Icons.email, 'contact@icabprivate.org', isMobile),
          _buildContactItem(Icons.phone, '+৮৮০ ১৭১২-৩৪৫৬৭৮', isMobile),
        ],
      ),
    ];
  }

  Widget _buildLinkColumn(String title, List<String> links, bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ...links.map((link) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {},
            child: Text(
              link,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 14,
              ),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text, bool isMobile) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.green, size: 18),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _socialCircle(Icons.facebook, 'https://www.facebook.com/yourpage'),
        const SizedBox(width: 15),
        _socialCircle(Icons.camera_alt, 'https://instagram.com/yourpage'),
        const SizedBox(width: 15),
        _socialCircle(Icons.play_arrow, 'https://youtube.com/yourchannel'),
      ],
    );
  }

  Widget _socialCircle(IconData icon, String url) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.white.withOpacity(0.1),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  Widget _buildCopyrightText() {
    return Text(
      '© ২০২৬ ICAB Private Wing | সর্বস্বত্ব সংরক্ষিত।',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white.withOpacity(0.4),
        fontSize: 13,
      ),
    );
  }
}