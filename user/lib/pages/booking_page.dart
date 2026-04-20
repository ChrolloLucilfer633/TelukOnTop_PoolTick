import 'package:flutter/material.dart';
import '../services/api_service.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final TextEditingController buyerController = TextEditingController();

  // State untuk menyimpan jumlah tiket per ID tiket
  // Format: { ticketId: jumlah }
  final Map<int, int> _ticketQuantities = {};

  // Primary Color Palette
  final Color primaryBlue = const Color(0xFF0061FF);
  final Color backgroundGray = const Color(0xFFF0F2F5);
  final Color darkText = const Color(0xFF1E293B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGray,
      body: CustomScrollView(
        slivers: [
          // AppBar dengan Gradient
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            backgroundColor: primaryBlue,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: const Text("Pesan Tiket",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryBlue, const Color(0xFF60EFFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),

          // Content Area
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionLabel("Informasi Pembeli"),
                  const SizedBox(height: 12),
                  _buildInputCard(),
                  const SizedBox(height: 25),
                  _buildSectionLabel("Tiket Tersedia"),
                  const SizedBox(height: 12),
                  _buildTicketList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkText),
    );
  }

  Widget _buildInputCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: TextField(
        controller: buyerController,
        style: TextStyle(color: darkText),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person_outline, color: primaryBlue),
          hintText: "Siapa nama pembelinya?",
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: backgroundGray,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildTicketList() {
    return FutureBuilder(
      future: ApiService.getTickets(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: CircularProgressIndicator(),
          ));
        }
        if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
          return const Center(child: Text("Tiket tidak ditemukan"));
        }

        final tickets = snapshot.data as List;
        return Column(
          children: tickets.map((t) => _buildTicketItem(t)).toList(),
        );
      },
    );
  }

  Widget _buildTicketItem(Map t) {
    int id = t['id'];
    // Inisialisasi kuantitas ke 1 jika belum ada di map
    int currentQty = _ticketQuantities[id] ?? 1;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 50, width: 50,
                decoration: BoxDecoration(color: primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(Icons.local_activity, color: primaryBlue),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: darkText)),
                    Text("Rp ${t['price']}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // --- COUNTER QUANTITY ---
              Container(
                decoration: BoxDecoration(
                  color: backgroundGray,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    _qtyButton(Icons.remove, () {
                      if (currentQty > 1) {
                        setState(() => _ticketQuantities[id] = currentQty - 1);
                      }
                    }),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text("$currentQty", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    _qtyButton(Icons.add, () {
                      setState(() => _ticketQuantities[id] = currentQty + 1);
                    }),
                  ],
                ),
              ),
              
              // --- TOMBOL BELI ---
              ElevatedButton(
                onPressed: () {
                  if (buyerController.text.isEmpty) {
                    _triggerSnackBar("Nama tidak boleh kosong!", Colors.redAccent);
                    return;
                  }
                  _showMainPayment(t, currentQty);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                child: Text("Beli $currentQty Tiket"),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, size: 20, color: primaryBlue),
      ),
    );
  }

  // --- MODAL SYSTEM ---

  void _showMainPayment(Map ticket, int qty) {
    int totalPrice = ticket['price'] * qty;

    _showCustomModal(
      context,
      title: "Metode Pembayaran",
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text("Total Bayar: Rp $totalPrice", 
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16)),
        ),
        _paymentTile(Icons.qr_code_2, "QRIS", "All Payment", () {
          Navigator.pop(context);
          prosesBayar(ticket, "QRIS", qty);
        }),
        _paymentTile(Icons.account_balance_wallet_outlined, "E-Wallet", "OVO, GoPay, Dana", () {
          Navigator.pop(context);
          _showSubPayment(ticket, "E-Wallet", ["OVO", "GoPay", "Dana"], qty);
        }),
        _paymentTile(Icons.account_balance_outlined, "M-Banking", "BCA, BRI, Mandiri", () {
          Navigator.pop(context);
          _showSubPayment(ticket, "M-Banking", ["BCA", "BRI", "Mandiri"], qty);
        }),
      ],
    );
  }

  void _showSubPayment(Map ticket, String title, List<String> options, int qty) {
    _showCustomModal(
      context,
      title: title,
      showBack: true,
      onBack: () {
        Navigator.pop(context);
        _showMainPayment(ticket, qty);
      },
      children: options.map((opt) => _paymentTile(
        title == "E-Wallet" ? Icons.smartphone : Icons.account_balance,
        opt,
        "Bayar menggunakan $opt",
        () {
          Navigator.pop(context);
          prosesBayar(ticket, opt, qty);
        },
      )).toList(),
    );
  }

  // --- REUSABLE COMPONENTS ---

  void _showCustomModal(BuildContext context, {required String title, required List<Widget> children, bool showBack = false, VoidCallback? onBack}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 15),
            Row(
              children: [
                if (showBack) IconButton(icon: const Icon(Icons.arrow_back_ios, size: 20), onPressed: onBack),
                Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkText)),
              ],
            ),
            const Divider(),
            ...children,
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _paymentTile(IconData icon, String title, String sub, VoidCallback tap) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: CircleAvatar(backgroundColor: backgroundGray, child: Icon(icon, color: primaryBlue)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(sub, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: tap,
    );
  }

  void _triggerSnackBar(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }

  Future<void> prosesBayar(Map ticket, String metode, int qty) async {
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator())
    );

    // Kirim ID Tiket, Nama Pembeli, dan JUMLAH (qty) ke API
    final ok = await ApiService.beliTiket(ticket['id'], buyerController.text);
    
    if (!mounted) return;
    Navigator.pop(context); // Close loading

    if (ok) {
      buyerController.clear();
      // Reset jumlah tiket untuk ID tersebut kembali ke 1
      setState(() {
        _ticketQuantities[ticket['id']] = 1;
      });
      _triggerSnackBar("Sukses! $qty Tiket ${ticket['name']} berhasil dibayar via $metode", Colors.green);
    } else {
      _triggerSnackBar("Maaf, terjadi kesalahan pembayaran.", Colors.redAccent);
    }
  }
}