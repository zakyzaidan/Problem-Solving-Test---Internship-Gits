import 'dart:io';

// Rumus: a(n) = 1 + n(n+1)/2
int rumus(int n) {
  return 1 + (n * (n + 1)) ~/ 2;
}

// Fungsi untuk menghasilkan string deret
String buatDeret(int n) {
  List<int> hasil = [];

  // Loop untuk hitung nilai untuk setiap indeks
  for (int i = 0; i <= n; i++) {
    hasil.add(rumus(i));
  }

  return hasil.join('-');
}

void main() {
  print('========= Program A000124 OEIS =========');
  print('Rumus: a(n) = 1 + n(n+1)/2');
  print('');

  // Meminta input dari user
  stdout
      .write('Masukkan nilai n (pisahkan dengan spasi jika beberapa input): ');
  String? input = stdin.readLineSync();

  // Validasi input
  if (input == null || input.isEmpty) {
    print('Input tidak boleh kosong!');
    return;
  }

  // Konversi input ke list integer
  List<String> inputList = input.trim().split(' ');
  List<int> nilaiList = [];

  // Validasi setiap input
  for (String item in inputList) {
    int? nilai = int.tryParse(item);
    if (nilai == null || nilai < 0) {
      print('Input "$item" tidak valid! Harus berupa angka positif.');
      return;
    }
    nilaiList.add(nilai);
  }

  print('');

  // Menampilkan hasil
  for (int n in nilaiList) {
    String output = buatDeret(n);
    print('Input: $n');
    print('Output: $output');
    print('');
  }
}
