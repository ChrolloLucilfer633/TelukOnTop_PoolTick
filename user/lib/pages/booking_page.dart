import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Pastikan path service kamu benar

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final TextEditingController buyerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        title: const Text("Pemesanan Tiket", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF0D6EFD),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder(
        future: ApiService.getTickets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (!snapshot.hasData) return const Center(child: Text("Data Kosong"));

          final tickets = snapshot.data as List;

          return ListView(
            padding: const EdgeInsets.all(25),
            children: [
              const Text("Data Kasir", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              
              // Input Nama
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                ),
                child: TextField(
                  controller: buyerController,
                  decoration: const InputDecoration(
                    hintText: "Nama Pembeli...",
                    prefixIcon: Icon(Icons.person, color: Color(0xFF0D6EFD)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                  ),
                ),
              ),

              const SizedBox(height: 35),
              const Text("Pilih Jenis Tiket", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),

              // Daftar Tiket
              ...tickets.map((t) => Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5)],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.confirmation_num, color: Color(0xFF0D6EFD), size: 30),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text("Rp ${t['price']}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D6EFD),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () async {
                        if (buyerController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Isi nama pembeli!")));
                          return;
                        }
                        final ok = await ApiService.beliTiket(t['id'], buyerController.text);
                        if (ok) {
                          buyerController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.green, content: Text("Sukses dipesan!")));
                          setState(() {}); // Refresh UI
                        }
                      },
                      child: const Text("Beli", style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              )).toList()
            ],
          );
        },
      ),
    );
  }
}