function login() {
  // Ambil nilai dari input username dan password
  const user = document.getElementById('username').value;
  const pass = document.getElementById('password').value;

  // Cek sederhana (Username: 1, Password: 1)
  if (user === "1" && pass === "1") {
    document.getElementById('login-page').style.display = "none";
    document.getElementById('dashboard').style.display = "block";
    loadData(); // Jalankan load data otomatis setelah login berhasil
  } else { 
    alert("Login Gagal! Username/Pass: 1"); 
  }
}