// Mengubah angka biasa menjadi format mata uang Rupiah (IDR)
const rupiah = (num) => new Intl.NumberFormat('id-ID', {
  style: 'currency', currency: 'IDR', minimumFractionDigits: 0
}).format(num);

// Fungsi pencarian: Menyembunyikan baris tabel jika tidak sesuai dengan input pencarian
function filterTable() {
  const filter = document.getElementById('searchTicket').value.toUpperCase();
  const rows = document.getElementById('data').getElementsByTagName('tr');
  for (let row of rows) {
    const text = row.getElementsByTagName('td')[1].textContent.toUpperCase();
    row.style.display = text.indexOf(filter) > -1 ? "" : "none";
  }
}