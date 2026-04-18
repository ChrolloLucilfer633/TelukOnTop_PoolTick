import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Kolam Renang PoolTick",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text("Nikmati kolam renang terbaik untuk keluarga."),
          SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network("https://picsum.photos/500/250"),
          ),
        ],
      ),
    );
  }
}