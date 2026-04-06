import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<List> getTickets() async {
    final res = await http.get(
      Uri.parse("http://localhost:3000/tickets"),
    );
    return jsonDecode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("PoolTick")),
        body: FutureBuilder(
          future: getTickets(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            var data = snapshot.data as List;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(data[i]['name']),
                  subtitle: Text("Rp ${data[i]['price']}"),
                );
              },
            );
          },
        ),
      ),
    );
  }
}