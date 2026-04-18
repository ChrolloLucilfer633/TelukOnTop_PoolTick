import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/header.dart';
import '../widgets/buyer_input.dart';
import '../widgets/ticket_card.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController buyer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("🏊 PoolTick")),
      body: FutureBuilder(
        future: ApiService.getTickets(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(child: Text("Data kosong"));
          }

          final data = snapshot.data as List;

          return ListView(
            children: [

              Header(),
              BuyerInput(buyer),

              ...data.map((t) {
                return TicketCard(
                  data: t,
                  onBuy: () async {
                    final success = await ApiService.beliTiket(
                      t['id'],
                      buyer.text,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          success
                          ? "Berhasil beli ${t['name']}"
                          : "Gagal beli",
                        ),
                      ),
                    );
                  },
                );
              }).toList(),

            ],
          );
        },
      ),
    );
  }
}