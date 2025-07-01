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
  bool proPackSelected = false;
  Map<String, bool> accessories = {};

  int exShowroomPrice = 0;
  int proPackPrice = 7000;
  int subsidy = 5000;
  int priceBenefit = 0;
  int trCharges = 1600;
  int insuranceBasic = 4250;
  int insuranceAddOn = 799;
  int accessoriesTotal = 0;

  final accessoryOptions = {
    'Helmet': 1200,
    'Mobile Holder': 800,
    'Charger': 1800,
    'Body Guard': 1000,
  };

  @override
  void initState() {
    super.initState();
    accessories = {for (var acc in accessoryOptions.keys) acc: false};
    _setModelPricing();
  }

  void _setModelPricing() {
    switch (widget.modelName) {
      case '450S':
        exShowroomPrice = 109999;
        break;
      case '450X LR':
        exShowroomPrice = 125000;
        break;
      case '450X HR':
        exShowroomPrice = 135000;
        break;
      case '450 Apex':
        exShowroomPrice = 145000;
        break;
      case 'Rizta S':
        exShowroomPrice = 109999;
        break;
      case 'Rizta Z LR':
        exShowroomPrice = 124999;
        break;
      case 'Rizta Z HR':
        exShowroomPrice = 134999;
        break;
      default:
        exShowroomPrice = 125000;
    }
  }

  int _calculateTotalAmount() {
    int base = exShowroomPrice - subsidy - priceBenefit;
    int ins = insuranceBasic + insuranceAddOn;
    accessoriesTotal = accessories.entries
        .where((e) => e.value)
        .fold(0, (sum, e) => sum + accessoryOptions[e.key]!);
    int total = base + trCharges + ins + accessoriesTotal;
    if (proPackSelected) total += proPackPrice;
    return total;
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text.trim();
      final phone = _phoneController.text.trim();
      final location = _locationController.text.trim();
      final color = selectedColor;

      final totalAmount = _calculateTotalAmount() * 100; // Razorpay in paise

      final uri = Uri.parse(
        'https://evselector-puia7bhx5-akgitgos-projects.vercel.app/payment.html'
        '?amount=$totalAmount&name=$name&phone=$phone',
      );

      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = _calculateTotalAmount();

    return Scaffold(
      appBar: AppBar(title: Text('Book ${widget.modelName}')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: selectedColor,
                items: widget.eligibleColors
                    .map((color) => DropdownMenuItem(value: color, child: Text(color)))
                    .toList(),
                onChanged: (val) => setState(() => selectedColor = val),
                decoration: const InputDecoration(labelText: 'Select Color'),
                validator: (value) => value == null ? 'Please select a color' : null,
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
                validator: (value) =>
                    value == null || value.length != 10 ? 'Enter valid 10-digit number' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your location' : null,
              ),
              const SizedBox(height: 20),

              CheckboxListTile(
                title: const Text("Add Pro Pack (+₹7000)"),
                value: proPackSelected,
                onChanged: (val) => setState(() => proPackSelected = val ?? false),
              ),

              const SizedBox(height: 10),
              Text("Accessories", style: TextStyle(fontWeight: FontWeight.bold)),
              ...accessoryOptions.keys.map((acc) => CheckboxListTile(
                    title: Text("$acc (+₹${accessoryOptions[acc]})"),
                    value: accessories[acc],
                    onChanged: (val) => setState(() => accessories[acc] = val ?? false),
                  )),

              const SizedBox(height: 20),
              Text(
                "Total Payable: ₹$total",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                child: const Text('Submit Booking & Pay'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
