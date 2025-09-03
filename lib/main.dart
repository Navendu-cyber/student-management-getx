import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DogApiScreen(),
    );
  }
}

class DogApiScreen extends StatefulWidget {
  const DogApiScreen({super.key});

  @override
  State<DogApiScreen> createState() => _DogApiScreenState();
}

class _DogApiScreenState extends State<DogApiScreen> {
  String? dogImageUrl; // to store the image URL
  bool isLoading = false;

  // Fetch random dog image
  Future<void> fetchDogImage() async {
    setState(() => isLoading = true);

    final url = Uri.parse('https://dog.ceo/api/breeds/image/random');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        dogImageUrl = data['message']; // "message" contains the image URL
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
      throw Exception('Failed to load dog image');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDogImage(); // load one image when screen starts
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Random Dog API")),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : dogImageUrl == null
            ? const Text("No image loaded")
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    dogImageUrl!,
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: fetchDogImage,
                    child: const Text("Fetch Another Dog 🐶"),
                  ),
                ],
              ),
      ),
    );
  }
}
