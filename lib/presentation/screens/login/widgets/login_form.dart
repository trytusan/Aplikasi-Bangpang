import 'package:flutter/material.dart';
import '../../../../widgets/common/center_alert.dart';
import '../../otp/otp_screen.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;

  const LoginForm({
    super.key,
    required this.phoneController,
    required this.passwordController,
    required this.onSubmit,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscurePassword = true;
  bool _rememberMe = true;
  bool _isLoading = false;

  void _showForgotPasswordModal() {
    final resetPhoneController = TextEditingController(text: widget.phoneController.text);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(ctx).viewInsets.bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: const Color(0xFFCBD5E1), borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 14),

            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.lock_reset, color: Color(0xFF1E3A8A), size: 20),
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Lupa Kata Sandi?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                    Text('Kirim kode verifikasi OTP untuk reset kata sandi', style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Text(
              'Masukkan nomor WhatsApp / ID Petugas yang terdaftar pada sistem penugasan BULOG:',
              style: TextStyle(fontSize: 11, color: Color(0xFF475569), height: 1.3),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: resetPhoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone, size: 18, color: Color(0xFF1E3A8A)),
                hintText: 'Contoh: 081234567890',
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE88B00), width: 1.5)),
              ),
            ),
            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE88B00),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  final phone = resetPhoneController.text.trim();
                  if (phone.isEmpty) {
                    CenterAlert.showWarning(
                      context,
                      title: 'Nomor Tidak Boleh Kosong',
                      message: 'Harap masukkan nomor handphone / ID Petugas Anda.',
                    );
                    return;
                  }

                  Navigator.pop(ctx); // Tutup modal
                  CenterAlert.showSuccess(
                    context,
                    title: 'Kode OTP Terkirim',
                    message: 'Kode 6-digit verifikasi telah dikirimkan ke WhatsApp $phone.',
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OtpScreen(phoneNumber: phone),
                    ),
                  );
                },
                icon: const Icon(Icons.mark_email_read_outlined, size: 18),
                label: const Text('Kirim Kode OTP Verifikasi', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w900)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleFormSubmit() {
    if (widget.phoneController.text.trim().isEmpty) {
      CenterAlert.showWarning(
        context,
        title: 'ID Petugas Kosong',
        message: 'Nomor Handphone / ID Petugas tidak boleh kosong.',
      );
      return;
    }

    if (widget.passwordController.text.trim().isEmpty) {
      CenterAlert.showWarning(
        context,
        title: 'Kata Sandi Kosong',
        message: 'Kata sandi akun petugas tidak boleh kosong.',
      );
      return;
    }

    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() => _isLoading = false);
        widget.onSubmit();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFF141926).withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'No. Handphone / ID Petugas',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),

          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E2638).withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
            ),
            child: TextField(
              controller: widget.phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                border: InputBorder.none,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2563EB),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.phone, color: Colors.white, size: 16),
                  ),
                ),
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(Icons.check_circle, color: Color(0xFF10B981), size: 20),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            'Kata Sandi',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),

          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E2638).withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
            ),
            child: TextField(
              controller: widget.passwordController,
              obscureText: _obscurePassword,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                border: InputBorder.none,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2563EB),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.vpn_key_rounded, color: Colors.white, size: 16),
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white54,
                    size: 20,
                  ),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => setState(() => _rememberMe = !_rememberMe),
                child: Row(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: _rememberMe ? const Color(0xFFE88B00) : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: _rememberMe ? const Color(0xFFE88B00) : Colors.white38,
                          width: 1.5,
                        ),
                      ),
                      child: _rememberMe
                          ? const Icon(Icons.check, size: 14, color: Colors.black)
                          : null,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Ingat Saya',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: _showForgotPasswordModal,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Lupa Kata Sandi?',
                  style: TextStyle(
                    color: Color(0xFFE88B00),
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE88B00),
                foregroundColor: Colors.black,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: _isLoading ? null : _handleFormSubmit,
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.black),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Masuk ke Sistem Lapangan',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 18, color: Colors.black),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
