import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: HomePage()));
}

class HomePage extends StatelessWidget {

  // ambil data tiket
  Future<List<dynamic>> fetchTickets() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/tickets'),
    );

    return json.decode(response.body);
  }

  // fungsi beli tiket 
  Future<void> beliTiket(Map ticket, BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/transactions'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'ticketId': ticket['id'], 
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Berhasil beli ${ticket['name']}"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal beli tiket"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🏊 PoolTick'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: fetchTickets(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final data = snapshot.data as List;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {

              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: Icon(Icons.confirmation_number),

                  title: Text(
                    data[index]['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  subtitle: Text("Harga: Rp ${data[index]['price']}"),

                  trailing: ElevatedButton(
                    child: Text("Beli"),
                    onPressed: () {
                      beliTiket(
                        data[index], 
                        context,
                      );
                    },
                  ),
                ),
              );

            },
          );
        },
      ),
    );
  }
}