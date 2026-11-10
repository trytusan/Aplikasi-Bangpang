class BastModel {
  final String nomorBast;
  final String nikPenerima;
  final String namaPenerima;
  final String waktu;
  final String lokasi;
  final double latitude;
  final double longitude;
  final double akurasiMeter;
  final String statusSync; // 'SYNCED' | 'LOCAL'
  final bool isPengganti;

  BastModel({
    required this.nomorBast,
    required this.nikPenerima,
    required this.namaPenerima,
    required this.waktu,
    required this.lokasi,
    required this.latitude,
    required this.longitude,
    required this.akurasiMeter,
    this.statusSync = 'SYNCED',
    this.isPengganti = false,
  });
}
