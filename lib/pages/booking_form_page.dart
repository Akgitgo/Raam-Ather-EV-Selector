import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingFormPage extends StatefulWidget {
  final String modelName;
  final List<String> eligibleColors;

  const BookingFormPage({
    super.key,
    required this.modelName,
    required this.eligibleColors,
  });

  @override
  State<BookingFormPage> createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();

  String? selectedColor;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  /// ✅ Razorpay redirect function
  void _launchRazorpay(double amount) async {
    final uri = Uri.parse(
      'https://raam-ather-ev-selector.vercel.app/payment.html'
      '?amount=${amount.toInt()}'
      '&name=${Uri.encodeComponent(_nameController.text.trim())}'
      '&phone=${_phoneController.text.trim()}',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch Razorpay page';
    }
  }

  /// 🔘 Form submission handler
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text.trim();
      final phone = _phoneController.text.trim();
      final location = _locationController.text.trim();

      debugPrint('Model: ${widget.modelName}');
      debugPrint('Color: $selectedColor');
      debugPrint('Name: $name');
      debugPrint('Phone: $phone');
      debugPrint('Location: $location');

      // 👇 Launch Razorpay after validation
      _launchRazorpay(10000); // ₹10,000 hardcoded for now
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book ${widget.modelName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: selectedColor,
                items: widget.eligibleColors.map((color) {
                  return DropdownMenuItem(
                    value: color,
                    child: Text(color),
                  );
                }).toList(),
                onChanged: (val) => setState(() => selectedColor = val),
                decoration: const InputDecoration(labelText: 'Select Color'),
                validator: (value) =>
                    value == null ? 'Please select a color' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Your Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your name' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.length != 10
                    ? 'Enter a valid 10-digit number'
                    : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter location' : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Submit Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
