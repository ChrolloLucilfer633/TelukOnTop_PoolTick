// Melakukan checkout untuk semua tiket yang quantity-nya lebih dari 0
async function beliSemua() {
  const buyer = document.getElementById('buyerName').value;
  if (!buyer) return alert("Harap isi NAMA PELANGGAN!");
  
  const selectedTickets = Object.keys(qtyMap).filter(id => qtyMap[id] > 0);
  if (selectedTickets.length === 0) return alert("Pilih minimal 1 tiket!");

  const tickets = await fetch(API_TICKETS).then(r => r.json());

  // Looping untuk mengirim setiap tiket yang dibeli ke API transaksi
  for (let id of selectedTickets) {
    const t = tickets.find(ticket => ticket.id == id);
    const qty = qtyMap[id];
    for (let i = 0; i < qty; i++) {
      await fetch(API_TRANSACTIONS, {
        method: 'POST', headers: {'Content-Type':'application/json'},
        body: JSON.stringify({
          ticketId: t.id, name: buyer, price: t.price, createdAt: new Date().toISOString()
        })
      });
    }
    qtyMap[id] = 0; // Reset quantity setelah beli
  }
  document.getElementById('buyerName').value = "";
  loadData();
  alert("Transaksi Berhasil!");
}

// Menampilkan list transaksi di tab riwayat
function renderTransactions(transactions, tickets) {
  const trxEl = document.getElementById('transaksi');
  let total = 0;
  
  trxEl.innerHTML = transactions.slice().reverse().map(i => {
    total += i.price;
    const dataTiket = tickets.find(t => t.id == i.ticketId);
    const namaTiket = dataTiket ? dataTiket.name : "Tiket dihapus";

    return `
      <tr>
        <td><small class="text-muted">#${i.id}</small></td>
        <td class="fw-bold">${i.name}</td>
        <td><span class="badge bg-light text-dark border">${namaTiket}</span></td>
        <td class="text-primary fw-bold">${rupiah(i.price)}</td>
        <td>${new Date(i.createdAt).toLocaleTimeString()}</td>
        <td class="text-center">
            <button onclick="hapusTransaksi(${i.id})" class="btn btn-sm btn-link text-danger p-0">
                <i class="bi bi-x-circle-fill fs-5"></i>
            </button>
        </td>
      </tr>`;
  }).join('');
  
  document.getElementById('total').innerText = rupiah(total);
}

// Menghapus satu data transaksi
function hapusTransaksi(id) {
  fetch(`${API_TRANSACTIONS}/${id}`, {method:'DELETE'}).then(loadData);
}

// Menghapus seluruh riwayat transaksi
async function hapusSemuaTransaksi() {
  if (!confirm("Hapus seluruh riwayat transaksi?")) return;
  const trx = await fetch(API_TRANSACTIONS).then(r => r.json());
  for (let t of trx) { await fetch(`${API_TRANSACTIONS}/${t.id}`, { method: 'DELETE' }); }
  loadData();
}

// Fungsi untuk download data ke format Excel .xlsx
async function downloadExcel() {
  const [dataTrx, dataTickets] = await Promise.all([
    fetch(API_TRANSACTIONS).then(r => r.json()),
    fetch(API_TICKETS).then(r => r.json())
  ]);

  if (!dataTrx.length) return alert("Tidak ada data untuk diunduh!");
  let totalKeseluruhan = 0;

  const reportData = dataTrx.map((trx, index) => {
    const tiket = dataTickets.find(t => t.id == trx.ticketId);
    const harga = parseInt(trx.price) || 0;
    totalKeseluruhan += harga;
    return {
      "No": index + 1,
      "ID Transaksi": trx.id,
      "Nama Pembeli": trx.name,
      "Nama Tiket": tiket ? tiket.name : "Tiket Dihapus",
      "Harga (Rp)": harga,
      "Waktu Transaksi": new Date(trx.createdAt).toLocaleString('id-ID')
    };
  });

  reportData.push({ "Nama Pembeli": "TOTAL PENDAPATAN", "Harga (Rp)": totalKeseluruhan });

  const ws = XLSX.utils.json_to_sheet(reportData);
  const wb = XLSX.utils.book_new();
  XLSX.utils.book_append_sheet(wb, ws, "Laporan Penjualan");
  XLSX.writeFile(wb, `Laporan_PoolTick_${new Date().getTime()}.xlsx`);
}