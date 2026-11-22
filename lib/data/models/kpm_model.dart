class KpmModel {
  final String nik;
  final String noKk;
  final String nama;
  final String alamat;
  final String dusun;
  final int alokasiKg;
  final bool isDiserahkan;
  final String? waktuSerah;
  final String? nomorBast;
  final bool isSptjm;
  final String? namaPengganti;
  final String phone;
  final String? note;
  final String status; // 'BELUM_DIAMBIL', 'SUDAH_DITERIMA', 'PERLU_DIANTAR'

  KpmModel({
    required this.nik,
    required this.noKk,
    required this.nama,
    required this.alamat,
    required this.dusun,
    this.alokasiKg = 10,
    this.isDiserahkan = false,
    this.waktuSerah,
    this.nomorBast,
    this.isSptjm = false,
    this.namaPengganti,
    this.phone = '0812-3456-7890',
    this.note,
    this.status = 'BELUM_DIAMBIL',
  });

  KpmModel copyWith({
    String? nik,
    String? noKk,
    String? nama,
    String? alamat,
    String? dusun,
    int? alokasiKg,
    bool? isDiserahkan,
    String? waktuSerah,
    String? nomorBast,
    bool? isSptjm,
    String? namaPengganti,
    String? phone,
    String? note,
    String? status,
  }) {
    return KpmModel(
      nik: nik ?? this.nik,
      noKk: noKk ?? this.noKk,
      nama: nama ?? this.nama,
      alamat: alamat ?? this.alamat,
      dusun: dusun ?? this.dusun,
      alokasiKg: alokasiKg ?? this.alokasiKg,
      isDiserahkan: isDiserahkan ?? this.isDiserahkan,
      waktuSerah: waktuSerah ?? this.waktuSerah,
      nomorBast: nomorBast ?? this.nomorBast,
      isSptjm: isSptjm ?? this.isSptjm,
      namaPengganti: namaPengganti ?? this.namaPengganti,
      phone: phone ?? this.phone,
      note: note ?? this.note,
      status: status ?? this.status,
    );
  }

  // Data master KPM resmi alokasi Desa Banjar Bali, Buleleng
  static List<KpmModel> get sampleData => [
    KpmModel(
      nik: '510806102700021',
      noKk: '5108061901080012',
      nama: 'I KETUT WIDIA',
      alamat: 'Banjar Dinas Bale Agung, RT 01',
      dusun: 'Desa Banjar Bali',
      phone: '0812-3456-7891',
    ),
    KpmModel(
      nik: '510806200500008',
      noKk: '5108061004110005',
      nama: 'NI MADE WARTI',
      alamat: 'Banjar Dinas Bale Agung, RT 02',
      dusun: 'Desa Banjar Bali',
      note: 'Perlu distribusi kolektif / diantar ke rumah melalui satgas desa.',
      phone: '0813-9876-5432',
      status: 'PERLU_DIANTAR',
    ),
    KpmModel(
      nik: '510806102700095',
      noKk: '5108061901080033',
      nama: 'KOMANG ARYA',
      alamat: 'Banjar Bali, RT 03',
      dusun: 'Desa Banjar Bali',
      phone: '0821-4567-8901',
    ),
    KpmModel(
      nik: '510806200500112',
      noKk: '5108062208090014',
      nama: 'DESAK PUTU SUCI',
      alamat: 'Banjar Bali, RT 02',
      dusun: 'Desa Banjar Bali',
      phone: '0857-3928-1192',
    ),
    KpmModel(
      nik: '510806102700140',
      noKk: '5108061506120045',
      nama: 'WAYAN GEDE SUKA',
      alamat: 'Banjar Bali, RT 04',
      dusun: 'Desa Banjar Bali',
      phone: '0878-6129-3049',
    ),
  ];
}
