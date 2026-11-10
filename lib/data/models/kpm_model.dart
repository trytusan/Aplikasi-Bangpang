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
  });

  // Contoh data KPM resmi Desa Banjar Bali, Buleleng
  static List<KpmModel> get sampleData => [
    KpmModel(
      nik: '5108051205780004',
      noKk: '5108051901080012',
      nama: 'I KETUT WIDNYANA',
      alamat: 'RT 02 / RW 01',
      dusun: 'Dusun Kelodan',
      isDiserahkan: true,
      waktuSerah: '10:24 WITA',
      nomorBast: 'BAST-0043',
    ),
    KpmModel(
      nik: '5108055509820001',
      noKk: '5108051004110005',
      nama: 'NI LUH SARIASIH',
      alamat: 'RT 01 / RW 01',
      dusun: 'Dusun Kelodan',
      isDiserahkan: true,
      waktuSerah: '10:12 WITA',
      nomorBast: 'BAST-0042',
      isSptjm: true,
      namaPengganti: 'GEDE SUARDANA (Ahli Waris)',
    ),
    KpmModel(
      nik: '5108050107750002',
      noKk: '5108051901080033',
      nama: 'GEDE SUARJANA',
      alamat: 'RT 03 / RW 02',
      dusun: 'Dusun Kanginan',
      isDiserahkan: false,
    ),
    KpmModel(
      nik: '5108052303800003',
      noKk: '5108052208090014',
      nama: 'MADE SUTRISNA',
      alamat: 'RT 01 / RW 02',
      dusun: 'Dusun Kanginan',
      isDiserahkan: false,
    ),
    KpmModel(
      nik: '5108056011850009',
      noKk: '5108051506120045',
      nama: 'KETUT BUDIARTHA',
      alamat: 'RT 02 / RW 03',
      dusun: 'Dusun Kaleran',
      isDiserahkan: false,
    ),
  ];
}
