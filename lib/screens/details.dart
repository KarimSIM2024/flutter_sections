import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/PHOTO-2025-05-06-21-17-41.jpg',
              height: 400,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 100),
            ),
            const SizedBox(height: 20),
            IconButton(
              iconSize: 50,
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
            ),
            const SizedBox(height: 20),
            const Icon(Icons.star, color: Colors.amber, size: 50),
            const SizedBox(height: 10),
            const Text("Hello, ya f7oool", style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
