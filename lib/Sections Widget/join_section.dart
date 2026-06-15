import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class JoinSection extends StatefulWidget {
  const JoinSection({super.key});

  @override
  State<JoinSection> createState() => _JoinSectionState();
}

class _JoinSectionState extends State<JoinSection> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _varsityController = TextEditingController();
  final TextEditingController _deptController = TextEditingController();

  bool _isLoading = false;

  Future<void> _submitData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final databaseRef = FirebaseDatabase.instance.ref();

        await databaseRef.child('members').push().set({
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'phone': _phoneController.text.trim(),
          'university': _varsityController.text.trim(),
          'department': _deptController.text.trim(),
          'submittedAt': DateTime.now().toIso8601String(),
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('আপনার আবেদন সফলভাবে জমা হয়েছে!'),
              backgroundColor: Colors.green,
            ),
          );

          _formKey.currentState!.reset();

          _nameController.clear();
          _emailController.clear();
          _phoneController.clear();
          _varsityController.clear();
          _deptController.clear();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('ডাটা জমা দিতে সমস্যা হয়েছে: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _varsityController.dispose();
    _deptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 60,
        horizontal: 20,
      ),
      color: Colors.green.shade50,
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
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 40),

          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(
                    'পূর্ণ নাম',
                    Icons.person,
                    _nameController,
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    'ইমেইল ঠিকানা',
                    Icons.email,
                    _emailController,
                    isEmail: true,
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    'ফোন নম্বর',
                    Icons.phone,
                    _phoneController,
                    isNumber: true,
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    'বিশ্ববিদ্যালয়ের নাম',
                    Icons.school,
                    _varsityController,
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    'বিভাগ/বিষয়',
                    Icons.book,
                    _deptController,
                  ),
                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _submitData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : const Text(
                        'সদস্য হিসেবে আবেদন করুন',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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

  Widget _buildTextField(
      String label,
      IconData icon,
      TextEditingController controller, {
        bool isEmail = false,
        bool isNumber = false,
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber
          ? TextInputType.phone
          : isEmail
          ? TextInputType.emailAddress
          : TextInputType.text,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label প্রদান করুন';
        }

        if (isEmail &&
            !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'সঠিক ইমেইল প্রদান করুন';
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: Colors.green,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.green,
            width: 2,
          ),
        ),
      ),
    );
  }
}