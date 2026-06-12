import 'dart:async';
import 'package:flutter/material.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback? onJoinTap;

  const HeroSection({super.key, this.onJoinTap});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  final List<String> sliderImages = [
    'https://scontent.fdac138-2.fna.fbcdn.net/v/t39.30808-6/708606391_1292659379711575_4654355207349718498_n.jpg?stp=dst-jpg_tt6&cstp=mx1709x651&ctp=s1709x651&_nc_cat=103&ccb=1-7&_nc_sid=cc71e4&_nc_ohc=ZAWiDfzqZlEQ7kNvwGrwzIu&_nc_oc=AdqscNWaiIAJW6BX8CTBRyP9JkS0-dXDtC3ANbCwMiKB0blvimNEYlZAwR-sg02pGpY&_nc_zt=23&_nc_ht=scontent.fdac138-2.fna&_nc_gid=ZpB_KkWRMyLK0-E_qE1O2w&_nc_ss=7b2a8&oh=00_Af8vLN3LGSM1V-HkQGbJdJ_IRSevpXqj2xFQjnSZaJZ3GA&oe=6A3235A6',
    'https://scontent.fdac138-1.fna.fbcdn.net/v/t39.30808-6/486001772_9312088995513533_7579996173150213546_n.jpg?stp=dst-jpg_tt6&cstp=mx1640x924&ctp=s1640x924&_nc_cat=110&ccb=1-7&_nc_sid=86c6b0&_nc_ohc=mX7Cavz8QdYQ7kNvwGq094F&_nc_oc=Adq61YVt4BCfnqjF3kj7we-8j_qubab_jczGp8EHuZewe9oWTXuRYe5-MH_mXLzIoFY&_nc_zt=23&_nc_ht=scontent.fdac138-1.fna&_nc_gid=FIlDBXF3boFnPU2RBEwKAg&_nc_ss=7b2a8&oh=00_Af_7_3tHMBxQKximOfjgq7bIg-yxkPdrNly4C_O-pbSg7g&oe=6A322E3E',
    'https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?q=80&w=2070',
  ];

  int _currentPage = 0;
  late PageController _pageController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < sliderImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOutQuart,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 800;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        // হালকা ব্যাকগ্রাউন্ড গ্রাডিয়েন্ট
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.green.withOpacity(0.05), Colors.white],
        ),
      ),
      child: Column(
        children: [
          // স্লাইডার সেকশন
          Container(
            height: isMobile ? 350 : 550,
            width: double.infinity,
            margin: EdgeInsets.all(isMobile ? 10 : 20), // বর্ডার থেকে একটু গ্যাপ
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25), // আধুনিক কার্ভড বর্ডার
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) => setState(() => _currentPage = index),
                    itemCount: sliderImages.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        sliderImages[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  // স্লাইডারের ওপর হালকা ওভারলে
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // ইন্ডিকেটর ডটস
                  Positioned(
                    bottom: 25,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(sliderImages.length, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: _currentPage == index ? 28 : 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index ? Colors.white : Colors.white54,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              if (_currentPage == index)
                                BoxShadow(color: Colors.black26, blurRadius: 4)
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // টেক্সট কন্টেন্ট
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 40 : 80,
              horizontal: isMobile ? 20 : size.width * 0.1,
            ),
            child: Column(
              children: [
                // ব্যাজ
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.green.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.auto_awesome, size: 16, color: Colors.green.shade700),
                      const SizedBox(width: 8),
                      Text(
                        'প্রাইভেট বিশ্ববিদ্যালয় উইং',
                        style: TextStyle(
                          color: Colors.green.shade800,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),

                // মেইন হেডিং
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.black87, Colors.green.shade900],
                  ).createShader(bounds),
                  child: Text(
                    'নৈতিক নেতৃত্ব গঠনে\nতরুণদের ঐক্যবদ্ধ প্ল্যাটফর্ম',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 36 : 64,
                      fontWeight: FontWeight.w900,
                      height: 1.15,
                      letterSpacing: -1,
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // ডেসক্রিপশন
                SizedBox(
                  width: 750,
                  child: Text(
                    'ইসলামী মূল্যবোধ, জ্ঞানচর্চা এবং নেতৃত্ব বিকাশের মাধ্যমে দেশ ও জাতির কল্যাণে নিবেদিত একটি ছাত্র সংগঠন। আমরা বিশ্বাস করি তরুণরাই আগামীর সুন্দর সমাজ বিনির্মাণের কারিগর।',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: isMobile ? 16 : 20,
                      height: 1.7,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // বাটন গ্রুপ
                Wrap(
                  spacing: 25,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildHeroButton(
                      label: 'সদস্য হোন',
                      onPressed: widget.onJoinTap,
                      isPrimary: true,
                    ),
                    _buildHeroButton(
                      label: 'বিস্তারিত জানুন',
                      onPressed: () {},
                      isPrimary: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // মডার্ন বাটন উইজেট
  Widget _buildHeroButton({required String label, required VoidCallback? onPressed, required bool isPrimary}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: isPrimary ? [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ] : null,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? Colors.green.shade700 : Colors.white,
          foregroundColor: isPrimary ? Colors.white : Colors.green.shade700,
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 24),
          elevation: 0,
          side: isPrimary ? null : BorderSide(color: Colors.green.shade700, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}