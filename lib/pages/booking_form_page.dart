import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingFormPage extends StatefulWidget {
  final String modelName;
  final List<String> eligibleColors;
  final int exShowroomPrice;

  const BookingFormPage({
    super.key,
    required this.modelName,
    required this.eligibleColors,
    required this.exShowroomPrice,
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
  bool includeProPack = false;
  final List<String> selectedAccessories = [];

  final List<Map<String, dynamic>> accessories = [
    {'name': 'Charger Holder', 'price': 1899},
    {'name': 'Front Footrest', 'price': 999},
    {'name': 'Side Step', 'price': 1100},
    {'name': 'Bag Hook', 'price': 399},
  ];

  final int proPackCost = 16999;
  final int insurance = 3653;
  final int insuranceAddon = 1023;
  final int trCharges = 1185;

  int calculateTotalPrice() {
    int total = widget.exShowroomPrice + insurance + insuranceAddon + trCharges;
    if (includeProPack) total += proPackCost;
    total += selectedAccessories
        .map((accName) =>
            accessories.firstWhere((acc) => acc['name'] == accName)['price'] as int)
        .fold<int>(0, (sum, price) => sum + price);
    return total;
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text.trim();
      final phone = _phoneController.text.trim();
      final amount = calculateTotalPrice() * 100; // Razorpay expects in paisa

      final uri = Uri.parse(
        'https://evselector-puia7bhx5-akgitgos-projects.vercel.app/payment.html'
        '?amount=$amount&name=$name&phone=$phone',
      );
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkInputStyle = InputDecoration(
      filled: true,
      fillColor: Colors.grey[850],
      border: OutlineInputBorder(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Book ${widget.modelName}'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                decoration: darkInputStyle.copyWith(labelText: "Select Color"),
                dropdownColor: Colors.grey[900],
                value: selectedColor,
                items: widget.eligibleColors
                    .map((color) => DropdownMenuItem(
                          value: color,
                          child: Text(color, style: const TextStyle(color: Colors.white)),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => selectedColor = value),
                validator: (value) =>
                    value == null ? 'Please select a color' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: darkInputStyle.copyWith(labelText: 'Your Name'),
                style: const TextStyle(color: Colors.white),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: darkInputStyle.copyWith(labelText: 'Phone Number'),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value == null || value.length < 10 ? 'Invalid phone' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: darkInputStyle.copyWith(labelText: 'Location'),
                style: const TextStyle(color: Colors.white),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter location' : null,
              ),
              const Divider(height: 32, color: Colors.grey),
              Text(
                'Include Pro Pack (₹${proPackCost.toString()})',
                style: const TextStyle(color: Colors.white),
              ),
              Checkbox(
                value: includeProPack,
                onChanged: (val) =>
                    setState(() => includeProPack = val ?? false),
              ),
              const Divider(height: 32, color: Colors.grey),
              const Text(
                'Accessories:',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              ...accessories.map((acc) {
                return CheckboxListTile(
                  title: Text(
                    '${acc['name']} (₹${acc['price']})',
                    style: const TextStyle(color: Colors.white),
                  ),
                  value: selectedAccessories.contains(acc['name']),
                  onChanged: (val) {
                    setState(() {
                      if (val == true) {
                        selectedAccessories.add(acc['name']);
                      } else {
                        selectedAccessories.remove(acc['name']);
                      }
                    });
                  },
                );
              }).toList(),
              const SizedBox(height: 16),
              Text(
                'Total On-Road Price: ₹${calculateTotalPrice()}',
                style: const TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Submit Booking"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
