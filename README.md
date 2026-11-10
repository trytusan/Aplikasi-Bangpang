# Banpang Mobile 🌾
### Aplikasi Penyaluran Cadangan Beras Pemerintah (Bapanas & Perum BULOG)

Aplikasi mobile resmi berbasis **Flutter** untuk petugas lapangan (satgas) dalam mendistribusikan bantuan pangan beras 10 Kg kepada KPM (Keluarga Penerima Manfaat).

---

## 📁 Struktur Direktori Proyek

```text
banpang_mobile/
├── pubspec.yaml                      # Konfigurasi dependensi resmi
├── assets/                           # Gambar & icon aset resmi
├── lib/
│   ├── main.dart                     # Entry point & orientasi layar
│   ├── core/
│   │   ├── constants/
│   │   │   └── app_colors.dart       # Amber (#F59E0B) & Navy (#1E3A8A)
│   │   └── theme/
│   │       └── app_theme.dart        # Plus Jakarta Sans, kontras tinggi
│   ├── data/
│   │   └── models/
│   │       ├── kpm_model.dart        # Model KPM, NIK 16 digit, kuota sak
│   │       └── bast_model.dart       # Model Berita Acara & Geotagging
│   └── presentation/
│       └── screens/
│           ├── 01_login_screen.dart                 # Login NIP Petugas
│           ├── 01b_loading_screen.dart              # Spinner Beras Minimalis
│           ├── 01c_otp_assignment_screen.dart       # OTP & Titik Bagi
│           ├── 02_dashboard_screen.dart             # Dashboard 3 Menu
│           ├── 03_step1_delivery_type_screen.dart   # Mandiri vs SPTJM
│           ├── 04_step2_qr_scanner_screen.dart      # Scanner QR & NIK
│           ├── 05_step3_sptjm_replacement_screen.dart # Form Pengganti
│           ├── 06_step4_camera_geotag_screen.dart   # Geotag Lat/Long Presisi
│           ├── 07_step5_review_bast_screen.dart     # Tanda Tangan BAST
│           ├── 08_history_list_screen.dart          # Riwayat Filter
│           ├── 09_distribution_report_screen.dart   # Grafik Distribusi
│           └── 10_profile_settings_screen.dart      # Force Sync & Profil
```

---

## 🚀 Cara Menjalankan Proyek di Komputer Anda

1. **Pastikan Flutter SDK Terpasang**:
   - Unduh Flutter SDK dari [https://flutter.dev](https://flutter.dev).
   - Masukkan path folder `flutter\bin` ke dalam System Environment Variable (`PATH`).
2. **Jalankan Perintah**:
   ```bash
   cd "d:\Aplikasi Yogik\banpang_mobile"
   flutter pub get
   flutter run
   ```
3. Bisa dijalankan langsung di HP Android (via USB Debugging), iOS Simulator, maupun Chrome Web.
