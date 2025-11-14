import 'dart:io';

String getMaxPalindrome(String s, int k) {
  List<String> karakter = s.split('');
  int panjang = karakter.length;

  // Tahap 1: Hitung berapa pasangan yang perlu diubah agar jadi palindrome
  int countpasangan(int i, int j) {
    if (i >= j) return 0;
    int add = (karakter[i] != karakter[j]) ? 1 : 0;
    return add + countpasangan(i + 1, j - 1);
  }

  int pasangan = countpasangan(0, panjang - 1);
  if (pasangan > k) return "Tidak memungkinkan dibuat palindrom";

  // Tahap 2: Membuat palindrome terbesar
  String maxPalindrome(int i, int j, int k, int pasangan) {
    if (i > j) return karakter.join();

    // proses pasangan kanan kiri
    String kiri = karakter[i];
    String kanan = karakter[j];

    // Jika tidak sama, maka harus disamakan dulu
    if (kiri != kanan) {
      // Jika k masih banyak (lebih besar dari pasangan yg perlu diubah), bisa sekaligus memaksimalkan menjadi '9'
      if (k - pasangan > 1 && (kiri != '9' || kanan != '9')) {
        karakter[i] = karakter[j] = '9';
        return maxPalindrome(i + 1, j - 1, k - 2, pasangan - 1);
      } else {
        // Hanya menyamakan ke nilai terbesar salah satu karakter/angka
        String nilaibesar = (kiri.compareTo(kanan) > 0) ? kiri : kanan;
        karakter[i] = karakter[j] = nilaibesar;
        return maxPalindrome(i + 1, j - 1, k - 1, pasangan - 1);
      }
    }

    // Jika pasangan sudah sama dan masih tersisa k, maksimalkan ke '9'
    if (k - pasangan >= 2 && karakter[i] != '9') {
      karakter[i] = karakter[j] = '9';
      return maxPalindrome(i + 1, j - 1, k - 2, pasangan);
    }

    // Jika tengah dan masih tersisa k
    if (i == j && k > 0) {
      karakter[i] = '9';
      return karakter.join();
    }

    return maxPalindrome(i + 1, j - 1, k, pasangan);
  }

  return maxPalindrome(0, panjang - 1, k, pasangan);
}

void main() {
  print("========= Program Highest Palindrome =========");
  print("");

  print("Masukkan string angka: ");
  String? input = stdin.readLineSync();

  print("Masukkan nilai k: ");
  String? kInput = stdin.readLineSync();

  if (input == null || kInput == null) {
    print("Input tidak valid!");
    return;
  }

  int k = int.parse(kInput);
  String hasil = getMaxPalindrome(input, k);

  print("");
  print("Output: $hasil");
}
