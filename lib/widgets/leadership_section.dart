import 'package:flutter/material.dart';

class LeadershipSection extends StatelessWidget {
  const LeadershipSection({super.key});

  @override
  Widget build(BuildContext context) {
    final leaders = [
      {
        'name': 'মোঃ আব্দুল্লাহ',
        'designation': 'সভাপতি',
      },
      {
        'name': 'মোঃ হাসান',
        'designation': 'সহ-সভাপতি',
      },
      {
        'name': 'মোঃ রহমান',
        'designation': 'সাধারণ সম্পাদক',
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
      color: Colors.grey.shade100,
      child: Column(
        children: [
          const Text(
            'কেন্দ্রীয় নেতৃত্ব',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 40),

          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: leaders.map((leader) {
              return Container(
                width: 250,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.black12,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person, size: 60),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      leader['name']!,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      leader['designation']!,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}