import 'package:flutter/material.dart';

class JoinSection extends StatefulWidget {
  const JoinSection({super.key});

  @override
  State<JoinSection> createState() => _JoinSectionState();
}

class _JoinSectionState extends State<JoinSection> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      color: Colors.green.shade50, // হালকা ব্যাকগ্রাউন্ড যাতে ফর্মটি ফুটে ওঠে
      child: Column(
        children: [
          const Text(
            'সদস্য ফরম',
            style: TextStyle(
              color: Colors.green,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'একটি আদর্শ সমাজ গঠনে আপনিও আমাদের সাথে যুক্ত হোন।',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 40),

          // ফর্ম কার্ড
          Container(
            width: 600, // ফর্মটি খুব বেশি বড় হবে না ডেক্সটপে
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField('পূর্ণ নাম', Icons.person),
                  const SizedBox(height: 20),
                  _buildTextField('ইমেইল ঠিকানা', Icons.email, isEmail: true),
                  const SizedBox(height: 20),
                  _buildTextField('ফোন নম্বর', Icons.phone, isNumber: true),
                  const SizedBox(height: 20),
                  _buildTextField('বিশ্ববিদ্যালয়ের নাম', Icons.school),
                  const SizedBox(height: 20),
                  _buildTextField('বিভাগ/বিষয়', Icons.book),
                  const SizedBox(height: 30),

                  // সাবমিট বাটন
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('আবেদনটি গ্রহণ করা হয়েছে!')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'সদস্য হিসেবে আবেদন করুন',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // টেক্সট ফিল্ড তৈরির হেল্পার মেথড
  Widget _buildTextField(String label, IconData icon, {bool isEmail = false, bool isNumber = false}) {
    return TextFormField(
      keyboardType: isNumber ? TextInputType.phone : (isEmail ? TextInputType.emailAddress : TextInputType.text),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label প্রদান করুন';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.green, width: 2),
        ),
      ),
    );
  }
}