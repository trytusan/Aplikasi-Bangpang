import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Komponen dialog konfirmasi modern yang terpadu dan rapi.
/// Menggantikan tampilan kaku default Flutter AlertDialog agar tombol dan tata letak
/// proporsional, ramah jempol, dan selaras dengan tema Banpang Mobile.
class AppConfirmationDialog extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color? iconBackgroundColor;
  final String title;
  final String message;
  final Widget? customContent;
  final String confirmText;
  final Color confirmColor;
  final Color confirmTextColor;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool stackedButtons;

  const AppConfirmationDialog({
    super.key,
    required this.icon,
    required this.iconColor,
    this.iconBackgroundColor,
    required this.title,
    required this.message,
    this.customContent,
    required this.confirmText,
    this.confirmColor = const Color(0xFFE88B00),
    this.confirmTextColor = Colors.white,
    this.cancelText = 'Batal',
    this.onConfirm,
    this.onCancel,
    this.stackedButtons = false,
  });

  /// Menampilkan dialog konfirmasi umum dan mengembalikan Future<bool?>
  /// `true` jika tombol konfirmasi ditekan, `false` jika batal, `null` jika dismiss.
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    IconData icon = Icons.help_outline_rounded,
    Color iconColor = const Color(0xFF1E3A8A),
    Color? iconBackgroundColor,
    String confirmText = 'Lanjutkan',
    Color confirmColor = const Color(0xFFE88B00),
    Color confirmTextColor = Colors.white,
    String? cancelText = 'Batal',
    Widget? customContent,
    bool stackedButtons = false,
  }) {
    HapticFeedback.lightImpact();

    return showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'AppConfirmationDialog',
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (ctx, anim1, anim2) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: AppConfirmationDialog(
              title: title,
              message: message,
              icon: icon,
              iconColor: iconColor,
              iconBackgroundColor: iconBackgroundColor,
              confirmText: confirmText,
              confirmColor: confirmColor,
              confirmTextColor: confirmTextColor,
              cancelText: cancelText,
              customContent: customContent,
              stackedButtons: stackedButtons,
              onConfirm: () => Navigator.of(ctx).pop(true),
              onCancel: () => Navigator.of(ctx).pop(false),
            ),
          ),
        );
      },
      transitionBuilder: (ctx, anim, secondaryAnim, child) {
        final curvedAnim = CurvedAnimation(parent: anim, curve: Curves.easeOutBack);
        return ScaleTransition(
          scale: Tween<double>(begin: 0.85, end: 1.0).animate(curvedAnim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  /// Preset Konfirmasi Bahaya / Keluar (Merah)
  static Future<bool?> showDanger(
    BuildContext context, {
    required String title,
    required String message,
    IconData icon = Icons.logout_rounded,
    String confirmText = 'Ya, Keluar',
    String cancelText = 'Batal',
    Widget? customContent,
    bool stackedButtons = false,
  }) {
    return show(
      context,
      title: title,
      message: message,
      icon: icon,
      iconColor: const Color(0xFFE11D48),
      iconBackgroundColor: const Color(0xFFFEE2E2),
      confirmText: confirmText,
      confirmColor: const Color(0xFFE11D48),
      confirmTextColor: Colors.white,
      cancelText: cancelText,
      customContent: customContent,
      stackedButtons: stackedButtons,
    );
  }

  /// Preset Peringatan Penting (Amber)
  static Future<bool?> showWarning(
    BuildContext context, {
    required String title,
    required String message,
    IconData icon = Icons.warning_amber_rounded,
    String confirmText = 'Lanjutkan',
    String? cancelText = 'Batal',
    Widget? customContent,
    bool stackedButtons = false,
  }) {
    return show(
      context,
      title: title,
      message: message,
      icon: icon,
      iconColor: const Color(0xFFD97706),
      iconBackgroundColor: const Color(0xFFFEF3C7),
      confirmText: confirmText,
      confirmColor: const Color(0xFFE88B00),
      confirmTextColor: const Color(0xFF0F172A),
      cancelText: cancelText,
      customContent: customContent,
      stackedButtons: stackedButtons,
    );
  }

  /// Preset Info / Konfirmasi Standar (Navy Bulog)
  static Future<bool?> showInfo(
    BuildContext context, {
    required String title,
    required String message,
    IconData icon = Icons.info_outline_rounded,
    String confirmText = 'Mengerti',
    String? cancelText,
    Widget? customContent,
    bool stackedButtons = false,
  }) {
    return show(
      context,
      title: title,
      message: message,
      icon: icon,
      iconColor: const Color(0xFF1E3A8A),
      iconBackgroundColor: const Color(0xFFDBEAFE),
      confirmText: confirmText,
      confirmColor: const Color(0xFF1E3A8A),
      confirmTextColor: Colors.white,
      cancelText: cancelText,
      customContent: customContent,
      stackedButtons: stackedButtons,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = iconBackgroundColor ?? iconColor.withValues(alpha: 0.12);

    return Container(
      width: 320,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header Badge Ikon
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: iconColor,
              size: 28,
            ),
          ),
          const SizedBox(height: 16),

          // Judul Dialog
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.5,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F172A),
              height: 1.25,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 8),

          // Pesan Penjelasan
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFF64748B),
              height: 1.45,
            ),
          ),

          // Konten Kustom Tambahan (opsional)
          if (customContent != null) ...[
            const SizedBox(height: 14),
            customContent!,
          ],

          const SizedBox(height: 22),

          // Tombol Aksi
          if (stackedButtons)
            _buildStackedActions(context)
          else
            _buildRowActions(context),
        ],
      ),
    );
  }

  /// Tata letak tombol berjajar horizontal (50:50 proporsional)
  Widget _buildRowActions(BuildContext context) {
    final hasCancel = cancelText != null && cancelText!.isNotEmpty;

    return Row(
      children: [
        if (hasCancel) ...[
          Expanded(
            child: SizedBox(
              height: 44,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFF8FAFC),
                  foregroundColor: const Color(0xFF475569),
                  side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                onPressed: onCancel ?? () => Navigator.of(context).pop(false),
                child: Text(
                  cancelText!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
        Expanded(
          child: SizedBox(
            height: 44,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: confirmColor,
                foregroundColor: confirmTextColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
              ),
              onPressed: onConfirm ?? () => Navigator.of(context).pop(true),
              child: Text(
                confirmText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Tata letak tombol vertikal tertata rapi (untuk teks tombol yang lebih panjang)
  Widget _buildStackedActions(BuildContext context) {
    final hasCancel = cancelText != null && cancelText!.isNotEmpty;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 44,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmColor,
              foregroundColor: confirmTextColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: onConfirm ?? () => Navigator.of(context).pop(true),
            child: Text(
              confirmText,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        if (hasCancel) ...[
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFF8FAFC),
                foregroundColor: const Color(0xFF64748B),
                side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: onCancel ?? () => Navigator.of(context).pop(false),
              child: Text(
                cancelText!,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
