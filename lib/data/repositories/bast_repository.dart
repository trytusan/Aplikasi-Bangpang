import 'package:flutter/foundation.dart';
import '../models/kpm_model.dart';

class BastRecord {
  final String id;
  final String bastNo;
  final String nama;
  final String nik;
  final String noKk;
  final String pbpNo;
  final String waktu;
  final String jenis; // 'PBP NORMAL', 'ALUR PENGGANTI (SPTJM)', 'PERWAKILAN (1 KK)'
  final String imageUrl;
  final String lokasi;
  final bool isSynced;
  final String? replacedName;
  final String? representativeName;

  BastRecord({
    required this.id,
    required this.bastNo,
    required this.nama,
    required this.nik,
    this.noKk = '5108060101750001',
    required this.pbpNo,
    required this.waktu,
    required this.jenis,
    this.imageUrl = 'https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=200',
    this.lokasi = 'Banjar Bali, Buleleng',
    this.isSynced = true,
    this.replacedName,
    this.representativeName,
  });
}

/// In-Memory Database (Opsi A: Murni Kosong saat Reload / Fresh Session)
class BastRepository extends ChangeNotifier {
  static final BastRepository _instance = BastRepository._internal();
  static BastRepository get instance => _instance;
  BastRepository._internal() {
    _initPbpData();
  }

  /// Total Kuota Alokasi Titik Bagi Desa Banjar Bali
  final int totalQuota = 48;

  /// Daftar penampung transaksi di RAM (Awalnya Kosong / 0 data yang diserahkan)
  final List<BastRecord> _records = [];

  /// Daftar master Penerima Bantuan Pangan (PBP) di titik bagi
  final List<KpmModel> _pbpList = [];

  void _initPbpData() {
    _pbpList.clear();
    _pbpList.addAll(KpmModel.sampleData);
  }

  List<BastRecord> get records => List.unmodifiable(_records);
  List<KpmModel> get allPbp => List.unmodifiable(_pbpList);
  List<KpmModel> get pendingPbp => _pbpList.where((k) => !k.isDiserahkan).toList();
  List<KpmModel> get deliveredPbp => _pbpList.where((k) => k.isDiserahkan).toList();

  int get distributedCount => _records.length;
  int get remainingCount => (totalQuota - distributedCount).clamp(0, totalQuota);
  double get percentage => totalQuota > 0 ? (distributedCount / totalQuota) * 100 : 0.0;
  int get totalKg => distributedCount * 10;
  int get totalTargetKg => totalQuota * 10;

  // Hitungan Kategori
  int get normalCount => _records.where((r) => r.jenis.contains('NORMAL')).length;
  int get replacementCount => _records.where((r) => r.jenis.contains('PENGGANTI')).length;
  int get representativeCount => _records.where((r) => r.jenis.contains('PERWAKILAN')).length;

  /// Tambah data BAST baru ke database in-memory & perbarui status master PBP
  void addRecord(BastRecord record) {
    _records.insert(0, record); // Muncul paling atas di laporan & riwayat

    // Sinkronkan ke daftar master PBP
    final index = _pbpList.indexWhere(
      (k) => k.nik == record.nik || k.nama.toLowerCase() == record.nama.toLowerCase(),
    );

    if (index != -1) {
      _pbpList[index] = _pbpList[index].copyWith(
        isDiserahkan: true,
        status: 'SUDAH_DITERIMA',
        nomorBast: record.bastNo,
        waktuSerah: record.waktu,
        isSptjm: record.jenis.contains('PENGGANTI'),
        namaPengganti: record.replacedName,
      );
    } else {
      // Jika KPM baru (pengganti atau input manual yang belum ada di daftar awal), tambahkan ke master PBP
      _pbpList.insert(
        0,
        KpmModel(
          nik: record.nik,
          noKk: record.noKk,
          nama: record.nama,
          alamat: record.lokasi,
          dusun: 'Desa Banjar Bali',
          isDiserahkan: true,
          status: 'SUDAH_DITERIMA',
          nomorBast: record.bastNo,
          waktuSerah: record.waktu,
          isSptjm: record.jenis.contains('PENGGANTI'),
          namaPengganti: record.replacedName,
        ),
      );
    }

    notifyListeners();
  }

  /// Update catatan atau jadwal KPM
  void updatePbpNote(String nik, String note) {
    final index = _pbpList.indexWhere((k) => k.nik == nik);
    if (index != -1) {
      _pbpList[index] = _pbpList[index].copyWith(note: note);
      notifyListeners();
    }
  }

  /// Reset manual database kembali kosong
  void clear() {
    _records.clear();
    _initPbpData();
    notifyListeners();
  }
}
