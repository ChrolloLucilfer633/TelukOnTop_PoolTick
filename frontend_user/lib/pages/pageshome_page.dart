import 'package:flutter/material.dart';
import '../services/api.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tiket')),
      body: FutureBuilder(
        future: getTickets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final tickets = snapshot.data as List;

          return ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final t = tickets[index];

              return ListTile(
                title: Text(t['name']),
                subtitle: Text('Rp ${t['price']}'),
              );
            },
          );
        },
      ),
    );
  }
}