import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/theme_providers.dart';

class Navbar extends StatelessWidget {
  final VoidCallback? onHomeTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onLeadershipTap;
  final VoidCallback? onActivitiesTap;
  final VoidCallback? onNewsTap;
  final VoidCallback? onGalleryTap;
  final VoidCallback? onJoinTap;
  final VoidCallback? onMenuTap;

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    // থিম অনুযায়ী কালার সেট করা
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black54 : Colors.black12,
            blurRadius: 5,
          )
        ],
      ),
      child: Row(
        children: [
          // লোগো এবং টাইটেল একত্রে একটি Row-তে রাখা হয়েছে
          Row(
            children: [
              CircleAvatar(
                radius: 20, // লোগোর সাইজ
                backgroundColor: Colors.transparent,
                backgroundImage: const AssetImage('assets/img.png'), // আপনার অ্যাসেট পাথ
              ),
              const SizedBox(width: 10), // লোগো এবং লেখার মাঝে গ্যাপ
              Text(
                'ICAB Private University Wing',
                style: GoogleFonts.notoSansBengali( // অথবা notoSansBengali()
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const Spacer(),

          // ডেক্সটপ মেনু
          if (width > 1000) ...[
            _navItem("হোম", onHomeTap, textColor),
            _navItem("আমাদের সম্পর্কে", onAboutTap, textColor),
            _navItem("নেতৃত্ব", onLeadershipTap, textColor),
            _navItem("কার্যক্রম", onActivitiesTap, textColor),
            _navItem("সংবাদ", onNewsTap, textColor),
            _navItem("গ্যালারি", onGalleryTap, textColor),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: onJoinTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
              ),
              child: const Text("সদস্য হোন"),
            ),
          ],

          const SizedBox(width: 10),

          // ডার্ক/লাইট মোড সুইচ বাটন
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: isDark ? Colors.yellow : Colors.black87,
            ),
            onPressed: () {
              themeProvider.toggleTheme(!isDark);
            },
          ),

          // মোবাইল মেনু আইকন
          if (width <= 1000)
            IconButton(
              icon: Icon(Icons.menu, size: 30, color: textColor),
              onPressed: onMenuTap,
            ),
        ],
      ),
    );
  }

  Widget _navItem(String title, VoidCallback? onTap, Color color) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        title,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
    );
  }
}
