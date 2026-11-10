import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../widgets/common/center_alert.dart';
import '../../../../core/constants/app_colors.dart';

class OtpInput extends StatefulWidget {
  final List<TextEditingController> controllers;
  final VoidCallback? onOtpComplete;

  const OtpInput({
    super.key,
    required this.controllers,
    this.onOtpComplete,
  });

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  int _secondsLeft = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsLeft = 60);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        setState(() => _secondsLeft--);
      } else {
        timer.cancel();
      }
    });
  }

  void _resendOtp() {
    _startTimer();
    CenterAlert.showSuccess(
      context,
      title: 'OTP Terkirim Ulang',
      message: 'Kode OTP baru telah dikirimkan ke WhatsApp resmi petugas.',
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(String val, int index) {
    if (val.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        widget.onOtpComplete?.call();
      }
    } else {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final String timerText = '00:${_secondsLeft.toString().padLeft(2, '0')}';

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'KODE OTP KEAMANAN',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryAmberDark,
                  ),
                ),
                Icon(Icons.shield_outlined, size: 18, color: AppColors.primaryAmberDark),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              'Masukkan 6-digit kode verifikasi yang dikirim ke nomor WhatsApp dinas (+62 812-****-4432):',
              style: TextStyle(fontSize: 11, color: AppColors.textMuted),
            ),
            const SizedBox(height: 14),

            // 6-Digit OTP Boxes with Auto-Advance Focus
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 44,
                  height: 48,
                  child: TextField(
                    controller: widget.controllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textMain,
                    ),
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.borderLight),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.primaryAmber, width: 2),
                      ),
                    ),
                    onChanged: (val) => _onDigitChanged(val, index),
                  ),
                );
              }),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _secondsLeft > 0 ? 'Kirim ulang dalam $timerText' : 'Belum menerima OTP?',
                  style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                ),
                TextButton(
                  onPressed: _secondsLeft == 0 ? _resendOtp : null,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Kirim Ulang',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: _secondsLeft == 0 ? AppColors.navyPrimary : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
