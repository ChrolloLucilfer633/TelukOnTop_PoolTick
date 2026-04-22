// URL Backend (Sesuaikan jika port database kamu berbeda)
const API_TICKETS = 'http://localhost:3000/tickets';
const API_TRANSACTIONS = 'http://localhost:3000/transactions';

// Fungsi Utama untuk menarik semua data tiket dan transaksi secara bersamaan
async function loadData() {
  try {
    const [tickets, transactions] = await Promise.all([
      fetch(API_TICKETS).then(r => r.json()),
      fetch(API_TRANSACTIONS).then(r => r.json())
    ]);
    
    // Setelah data ditarik, panggil fungsi render untuk menampilkannya ke tabel
    renderTickets(tickets);
    renderTransactions(transactions, tickets); 
  } catch (err) {
    console.error("Gagal load data dari API:", err);
  }
}