import 'package:flutter/material.dart';

class ActivitiesSection extends StatelessWidget {
  const ActivitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      'দাওয়াতি কার্যক্রম',
      'শিক্ষা কার্যক্রম',
      'সামাজিক কার্যক্রম',
      'সেমিনার',
      'ওয়ার্কশপ',
      'ক্যাম্পেইন',
    ];

    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        children: [
          const Text(
            'আমাদের কার্যক্রম',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: activities.map((activity) {
              return Container(
                width: 250,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    activity,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}