import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String> getData() async {
    final res = await http.get(
      Uri.parse("http://10.0.2.2:3000"),
    );
    return res.body;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Test API")),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return Center(child: Text(snapshot.data.toString()));
            } else {
              return const Center(child: Text("Error"));
            }
          },
        ),
      ),
    );
  }
}