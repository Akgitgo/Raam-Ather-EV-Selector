import 'package:flutter/material.dart';
import 'booking_form_page.dart';

class ModelSelectionPage extends StatefulWidget {
  final String category;

  const ModelSelectionPage({super.key, required this.category});

  @override
  State<ModelSelectionPage> createState() => _ModelSelectionPageState();
}

class _ModelSelectionPageState extends State<ModelSelectionPage> {
  bool includeProPack = false;
  List<String> selectedAccessories = [];

  final List<Map<String, dynamic>> accessories450 = [
    {'name': 'Charger Holder', 'price': 1899},
    {'name': 'Front Footrest', 'price': 999},
    {'name': 'Side Step', 'price': 1100},
    {'name': 'Bag Hook', 'price': 399},
  ];

  final Map<String, List<Map<String, dynamic>>> modelData = {
    '450': [
      {
        'name': '450S',
        'topSpeed': '90 km/h',
        'range': '115 km',
        'charging': '6 hrs',
        'eligibleColors': [
          'Space Grey',
          'Still White',
          'Cosmic Black',
          'Stealth Blue'
        ],
      },
      {
        'name': '450X LR',
        'topSpeed': '90 km/h',
        'range': '146 km',
        'charging': '5.5 hrs',
        'eligibleColors': [
          'Stealth Blue',
          'Hyper Sand',
          'Grey',
          'Lunar Grey',
          'True Red',
          'Salt Green',
          'Cosmic Black',
          'Still White',
          'Space Grey',
        ],
      },
      {
        'name': '450X HR',
        'topSpeed': '90 km/h',
        'range': '156 km',
        'charging': '5 hrs',
        'eligibleColors': [
          'Stealth Blue',
          'Hyper Sand',
          'Grey',
          'Lunar Grey',
          'True Red',
          'Salt Green',
          'Cosmic Black',
          'Still White',
          'Space Grey',
        ],
      },
      {
        'name': '450 Apex',
        'topSpeed': '100 km/h',
        'range': '157 km',
        'charging': '5 hrs',
        'eligibleColors': ['Indium Blue'],
      },
    ],
    'Rizta': [
      {
        'name': 'Rizta S',
        'topSpeed': '80 km/h',
        'range': '123 km',
        'charging': '6 hrs',
        'eligibleColors': [
          'Siachen White',
          'Deccan Grey',
          'Pangong Blue'
        ],
      },
      {
        'name': 'Rizta Z LR',
        'topSpeed': '80 km/h',
        'range': '143 km',
        'charging': '6 hrs',
        'eligibleColors': [
          'Pangong Blue',
          'Pangong Blue Duo',
          'Cardamom Green Duo',
          'Deccan Grey',
          'Deccan Grey Duo',
          'Siachen White',
          'Alphonso Yellow Duo',
        ],
      },
      {
        'name': 'Rizta Z HR',
        'topSpeed': '95 km/h',
        'range': '160 km',
        'charging': '5 hrs',
        'eligibleColors': [
          'Pangong Blue',
          'Pangong Blue Duo',
          'Cardamom Green Duo',
          'Deccan Grey',
          'Deccan Grey Duo',
          'Siachen White',
          'Alphonso Yellow Duo',
        ],
      },
    ],
  };

  int calculateTotalPrice() {
    int base = 142319 - 5000 + 3653 + 1023 + 1185; // effective + insurance
    if (includeProPack) base += 16999;
    for (var item in accessories450) {
      if (selectedAccessories.contains(item['name'])) {
        base += item['price'] as int;
      }
    }
    return base;
  }

  Widget _priceLine(String label, int price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        Text(
          price > 0 ? '₹$price' : '-₹${price.abs()}',
          style: TextStyle(color: price < 0 ? Colors.red : Colors.green),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final models = modelData[widget.category] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Select ${widget.category} Model'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: models.length,
        itemBuilder: (context, index) {
          final model = models[index];

          // Special logic for 450X LR
          if (model['name'] == '450X LR') {
            return Card(
              color: Colors.grey[900],
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('450X LR',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent)),
                    const SizedBox(height: 10),
                    _priceLine('Ex-Showroom Price', 142319),
                    _priceLine('PM E-Drive Subsidy', -5000),
                    _priceLine('Price Benefit', 0),
                    _priceLine('Effective Ex-Showroom', 137319),
                    _priceLine('Basic Insurance', 3653),
                    _priceLine('Insurance Super Add-on', 1023),
                    _priceLine('TR Charges', 1185),
                    const Divider(color: Colors.white),
                    CheckboxListTile(
                      value: includeProPack,
                      onChanged: (val) =>
                          setState(() => includeProPack = val ?? false),
                      title: const Text("Include Pro Pack (₹16,999)",
                          style: TextStyle(color: Colors.white)),
                    ),
                    const Divider(color: Colors.white),
                    const Text('Accessories:',
                        style: TextStyle(color: Colors.white)),
                    ...accessories450.map((acc) {
                      return CheckboxListTile(
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
                        title: Text("${acc['name']} (₹${acc['price']})",
                            style: const TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    const Divider(color: Colors.white),
                    Text("On-Road Price: ₹${calculateTotalPrice()}",
                        style: const TextStyle(
                            fontSize: 20, color: Colors.orangeAccent)),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookingFormPage(
                              modelName: '450X LR',
                              eligibleColors: List<String>.from(
                                  model['eligibleColors']),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50)),
                      child: const Text("Pay Now"),
                    )
                  ],
                ),
              ),
            );
          }

          // For all other models
          return Card(
            color: Colors.grey[900],
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                model['name'],
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Top Speed: ${model['topSpeed']}",
                      style: const TextStyle(color: Colors.grey)),
                  Text("Range: ${model['range']}",
                      style: const TextStyle(color: Colors.grey)),
                  Text("Charging Time: ${model['charging']}",
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookingFormPage(
                        modelName: model['name'],
                        eligibleColors:
                            List<String>.from(model['eligibleColors']),
                      ),
                    ),
                  );
                },
                child: const Text("Select"),
              ),
            ),
          );
        },
      ),
    );
  }
}
