import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  final Map data;
  final Function onBuy;

  TicketCard({required this.data, required this.onBuy});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          data['name'],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Rp ${data['price']}"),
        trailing: ElevatedButton(
          onPressed: () => onBuy(),
          child: Text("Beli"),
        ),
      ),
    );
  }
}