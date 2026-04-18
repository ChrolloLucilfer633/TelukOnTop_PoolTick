import 'package:flutter/material.dart';
import 'booking_page.dart'; // Arahkan ke file booking

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.infinity,
            child: Image.network(
              "https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?q=80&w=1000&auto=format&fit=crop",
              fit: BoxFit.cover,
            ),
          ),

          // Content Scrollable
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.52),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "PoolTick",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF0D6EFD)),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Nikmati kesegaran berenang di kolam terbaik dengan standar internasional. Cocok untuk bersantai bersama keluarga.",
                        style: TextStyle(color: Colors.grey, height: 1.6),
                      ),
                      const SizedBox(height: 30),
                      
                      // Area Fasilitas
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          _Facility(icon: Icons.wifi, text: "WiFi"),
                          _Facility(icon: Icons.shower, text: "Shower"),
                          _Facility(icon: Icons.coffee, text: "Cafe"),
                          _Facility(icon: Icons.pool, text: "Olympic"),
                        ],
                      ),
                      
                      const SizedBox(height: 40),

                      // TOMBOL LOGIN / PESAN
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D6EFD),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            elevation: 10,
                            shadowColor: Colors.blue.withOpacity(0.5),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const BookingPage()),
                            );
                          },
                          child: const Text(
                            "PESAN TIKET SEKARANG",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Facility extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Facility({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: const Color(0xFFE3F2FD),
          child: Icon(icon, color: const Color(0xFF0D6EFD)),
        ),
        const SizedBox(height: 5),
        Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }
}