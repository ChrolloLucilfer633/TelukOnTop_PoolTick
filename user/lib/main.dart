import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController buyerController = TextEditingController();

  // GET DATA
  Future<List<dynamic>> fetchTickets() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/tickets'),
    );

    return json.decode(response.body);
  }

  // BELI TIKET
  Future<void> beliTiket(Map ticket) async {
    if (buyerController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Isi nama pembeli dulu")),
      );
      return;
    }

    final response = await http.post(
      Uri.parse('http://localhost:3000/transactions'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'ticketId': ticket['id'],
        'name': buyerController.text,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Berhasil beli ${ticket['name']}")),
      );
      buyerController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal beli tiket")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("🏊 PoolTick"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: fetchTickets(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData) {
            return Center(child: Text("Data kosong"));
          }

          final data = snapshot.data as List;

          return ListView(
            children: [

              // 🔥 HEADER (DESKRIPSI + GAMBAR)
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kolam Renang PoolTick",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Nikmati kesegaran kolam renang terbaik dengan fasilitas lengkap dan nyaman untuk keluarga.",
                    ),
                    SizedBox(height: 15),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "https://picsum.photos/500/250",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),

              Divider(),

              // 🔥 INPUT NAMA
              Padding(
                padding: EdgeInsets.all(16),
                child: TextField(
                  controller: buyerController,
                  decoration: InputDecoration(
                    labelText: "Nama Pembeli",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              // 🔥 LIST TIKET
              ...data.map((item) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(
                      item['name'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Rp ${item['price']}"),
                    trailing: ElevatedButton(
                      onPressed: () => beliTiket(item),
                      child: Text("Beli"),
                    ),
                  ),
                );
              }).toList(),

              SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}