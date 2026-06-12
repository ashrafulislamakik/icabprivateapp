import 'package:flutter/material.dart';
import 'package:icab_private_app/widgets/about_section.dart';
import 'package:icab_private_app/widgets/activities_sections.dart';
import 'package:icab_private_app/widgets/drawer_mobile.dart';
import 'package:icab_private_app/widgets/footer_section.dart';
import 'package:icab_private_app/widgets/gallery_section.dart';
import 'package:icab_private_app/widgets/join_section.dart';
import 'package:icab_private_app/widgets/leadership_section.dart';
import 'package:icab_private_app/widgets/nav_bar.dart';
import 'package:icab_private_app/widgets/news_section.dart';
import 'package:icab_private_app/widgets/hero_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ড্রয়ার কন্ট্রোল করার জন্য Key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // প্রতিটি সেকশনের জন্য Keys
  final GlobalKey heroKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey activitiesKey = GlobalKey();
  final GlobalKey leadershipKey = GlobalKey();
  final GlobalKey newsKey = GlobalKey();
  final GlobalKey galleryKey = GlobalKey();
  final GlobalKey joinKey = GlobalKey();

  // স্মুথ স্ক্রলিং ফাংশন
  void scrollToSection(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }

    // ড্রয়ার খোলা থাকলে তা বন্ধ করে দেবে
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Scaffold-এ কি-টি অবশ্যই দিতে হবে

      // আপনার কাস্টম ড্রয়ার উইজেট
      drawer: MobileDrawer(
        onHomeTap: () => scrollToSection(heroKey),
        onAboutTap: () => scrollToSection(aboutKey),
        onLeadershipTap: () => scrollToSection(leadershipKey),
        onActivitiesTap: () => scrollToSection(activitiesKey),
        onNewsTap: () => scrollToSection(newsKey),
        onGalleryTap: () => scrollToSection(galleryKey),
        onJoinTap: () => scrollToSection(joinKey),
        onContactTap: () => scrollToSection(joinKey), // আপাতত জয়েন সেকশনে যাবে
      ),

      body: Column(
        children: [
          // নেভবার উইজেট
          Navbar(
            onMenuTap: () {
              _scaffoldKey.currentState?.openDrawer(); // ড্রয়ার ওপেন করবে
            },
            onHomeTap: () => scrollToSection(heroKey),
            onAboutTap: () => scrollToSection(aboutKey),
            onLeadershipTap: () => scrollToSection(leadershipKey),
            onActivitiesTap: () => scrollToSection(activitiesKey),
            onNewsTap: () => scrollToSection(newsKey),
            onGalleryTap: () => scrollToSection(galleryKey),
            onJoinTap: () => scrollToSection(joinKey),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HeroSection(key: heroKey,onJoinTap: () => scrollToSection(joinKey),),
                  AboutSection(key: aboutKey),
                  ActivitiesSection(key: activitiesKey),
                  LeadershipSection(key: leadershipKey),
                  NewsSection(key: newsKey),
                  GallerySection(key: galleryKey),
                  JoinSection(key: joinKey),
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}