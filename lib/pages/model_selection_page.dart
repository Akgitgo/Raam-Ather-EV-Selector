import 'package:flutter/material.dart';
import 'booking_form_page.dart';

class ModelSelectionPage extends StatelessWidget {
  final String category;

  ModelSelectionPage({super.key, required this.category});

  final Map<String, List<Map<String, dynamic>>> modelData = {
    '450': [
      {
        'name': '450S',
        'topSpeed': '90 km/h',
        'range': '115 km',
        'charging': '6 hrs',
        'price': 134999,
        'eligibleColors': ['Space Grey', 'Still White', 'Cosmic Black', 'Stealth Blue'],
      },
      {
        'name': '450X LR',
        'topSpeed': '90 km/h',
        'range': '146 km',
        'charging': '5.5 hrs',
        'price': 145999,
        'eligibleColors': ['Stealth Blue', 'Salt Green', 'Still White', 'Lunar Grey'],
      },
      {
        'name': '450X HR',
        'topSpeed': '90 km/h',
        'range': '156 km',
        'charging': '5 hrs',
        'price': 156999,
        'eligibleColors': ['True Red', 'Cosmic Black', 'Lunar Grey'],
      },
      {
        'name': '450 Apex',
        'topSpeed': '100 km/h',
        'range': '157 km',
        'charging': '5 hrs',
        'price': 189841,
        'eligibleColors': ['Indium Blue'],
      }
    ],
    'Rizta': [
      {
        'name': 'Rizta S',
        'topSpeed': '80 km/h',
        'range': '123 km',
        'charging': '6 hrs',
        'price': 109999,
        'eligibleColors': ['Siachen White', 'Deccan Grey', 'Pangong Blue'],
      },
      {
        'name': 'Rizta Z LR',
        'topSpeed': '80 km/h',
        'range': '143 km',
        'charging': '6 hrs',
        'price': 144000,
        'eligibleColors': ['Pangong Blue', 'Deccan Grey Duo', 'Alphonso Yellow Duo'],
      },
      {
        'name': 'Rizta Z HR',
        'topSpeed': '95 km/h',
        'range': '160 km',
        'charging': '5 hrs',
        'price': 160000,
        'eligibleColors': ['Cardamom Green Duo', 'Deccan Grey Duo', 'Siachen White'],
      }
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
                  Text("Top Speed: ${model['topSpeed']}", style: const TextStyle(color: Colors.grey)),
                  Text("Range: ${model['range']}", style: const TextStyle(color: Colors.grey)),
                  Text("Charging Time: ${model['charging']}", style: const TextStyle(color: Colors.grey)),
                  Text("Ex-showroom Price: ₹${model['price']}", style: const TextStyle(color: Colors.greenAccent)),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookingFormPage(
                        modelName: model['name'],
                        eligibleColors: List<String>.from(model['eligibleColors']),
                        exShowroomPrice: model['price'],
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
