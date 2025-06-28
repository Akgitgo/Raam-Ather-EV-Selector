import 'package:flutter/material.dart';
import 'booking_form_page.dart';

class ModelSelectionPage extends StatelessWidget {
  final String category;

  const ModelSelectionPage({super.key, required this.category});

  final Map<String, List<Map<String, dynamic>>> modelData = const {
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

  @override
  Widget build(BuildContext context) {
    final models = modelData[category] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Select $category Model'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: models.length,
        itemBuilder: (context, index) {
          final model = models[index];
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
