import 'package:flutter/material.dart';

class BuyerInput extends StatelessWidget {
  final TextEditingController controller;

  BuyerInput(this.controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "Nama Pembeli",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}