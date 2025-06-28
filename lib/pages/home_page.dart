import 'package:flutter/material.dart';
import 'model_selection_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Raam Ather', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Choose your Ather',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16.0),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: [
                vehicleTile(
                  context,
                  title: 'Ather 450',
                  image: 'assets/450.png',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ModelSelectionPage(category: '450')),
                  ),
                ),
                vehicleTile(
                  context,
                  title: 'Rizta',
                  image: 'assets/rizta.png',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ModelSelectionPage(category: 'Rizta')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget vehicleTile(BuildContext context, {required String title, required String image, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Expanded(child: Image.asset(image, fit: BoxFit.contain)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("Explore", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

