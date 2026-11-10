class Formatters {
  // Sensor NIK: 5108062005000001 -> ******2005000001 atau 510806******0001
  static String maskNik(String nik) {
    if (nik.length < 10) return nik;
    return '${nik.substring(0, 6)}******${nik.substring(nik.length - 4)}';
  }

  // Sensor KK: 5108061204090011 -> ******2409120008
  static String maskKk(String kk) {
    if (kk.length < 8) return kk;
    return '******${kk.substring(kk.length - 8)}';
  }

  // Format berat kg: 10 -> "10 Kg"
  static String formatKg(int kg) {
    return '$kg Kg';
  }
}
