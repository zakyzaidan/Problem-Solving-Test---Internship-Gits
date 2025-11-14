import 'dart:io';

// Fungsi untuk mengurutkan skor pemain jika belum terurut
List<int> urutkanSkor(List<int> daftarSkor) {
  List<int> skorTerurut = List.from(daftarSkor);
  skorTerurut.sort((a, b) => b.compareTo(a));
  return skorTerurut;
}

// Fungsi untuk mendapatkan skor unik (menghapus duplikat)
// contoh: 100 100 90 80 -> 100 90 80
List<int> dapatkanSkorUnik(List<int> skorTerurut) {
  List<int> skorUnik = [];
  for (int skor in skorTerurut) {
    if (skorUnik.isEmpty || skorUnik.last != skor) {
      skorUnik.add(skor);
    }
  }
  return skorUnik;
}

// Fungsi untuk menghitung peringkat gits
int hitungPeringkat(int skorGits, List<int> skorUnik) {
  int peringkat = 1;
  // Membandingkan skor dengan setiap skor unik di leaderboard
  for (int i = 0; i < skorUnik.length; i++) {
    // Jika skor GITS lebih kecil, peringkat turun
    if (skorGits < skorUnik[i]) {
      peringkat++;
    }
    // Jika skor GITS lebih besar atau sama, berhenti
    else {
      break;
    }
  }
  return peringkat;
}

// Fungsi utama untuk mendapatkan semua peringkat GITS
List<int> DenseRanking(List<int> leaderboard, List<int> skorGits) {
  List<int> leaderboardTerurut = urutkanSkor(leaderboard);
  List<int> skorUnik = dapatkanSkorUnik(leaderboardTerurut);
  // Hitung peringkat untuk setiap skor GITS
  List<int> daftarPeringkat = [];
  for (int skor in skorGits) {
    int peringkat = hitungPeringkat(skor, skorUnik);
    daftarPeringkat.add(peringkat);
  }
  return daftarPeringkat;
}

void main() {
  print('========= Program Dense Ranking =========');
  print('');

  // Input jumlah pemain dan skor leaderboard
  print('Masukkan jumlah pemain:');
  int jumlahPemain = int.parse(stdin.readLineSync()!);
  print('Masukkan skor leaderboard (dipisahkan spasi):');
  List<int> leaderboard =
      stdin.readLineSync()!.split(' ').map((e) => int.parse(e)).toList();

  // Input jumlah permainan dan skor GITS
  print('Masukkan jumlah permainan GITS:');
  int jumlahPermainan = int.parse(stdin.readLineSync()!);
  print('Masukkan skor GITS (dipisahkan spasi):');
  List<int> skorGits =
      stdin.readLineSync()!.split(' ').map((e) => int.parse(e)).toList();

  // Hitung peringkat GITS dengan Dense Ranking
  List<int> hasilPeringkat = DenseRanking(leaderboard, skorGits);

  // Tampilkan hasil
  print('\nHasil Peringkat:');
  print(hasilPeringkat.join(' '));
}
