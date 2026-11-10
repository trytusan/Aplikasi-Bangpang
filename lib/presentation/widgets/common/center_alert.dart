import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum CenterAlertType {
  success,
  info,
  warning,
  error,
}

class CenterAlert {
  static Future<void> show(
    BuildContext context, {
    required String title,
    String? message,
    CenterAlertType type = CenterAlertType.success,
    Duration duration = const Duration(milliseconds: 1800),
    bool autoDismiss = true,
  }) async {
    HapticFeedback.mediumImpact();

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'CenterAlert',
      barrierColor: Colors.black.withValues(alpha: 0.45),
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (ctx, anim1, anim2) {
        if (autoDismiss) {
          Timer(duration, () {
            if (ctx.mounted && Navigator.of(ctx, rootNavigator: true).canPop()) {
              Navigator.of(ctx, rootNavigator: true).pop();
            }
          });
        }

        return Center(
          child: Material(
            color: Colors.transparent,
            child: _CenterAlertCard(
              title: title,
              message: message,
              type: type,
            ),
          ),
        );
      },
      transitionBuilder: (ctx, anim, secondaryAnim, child) {
        final curvedAnim = CurvedAnimation(parent: anim, curve: Curves.easeOutBack);
        return ScaleTransition(
          scale: Tween<double>(begin: 0.82, end: 1.0).animate(curvedAnim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  static Future<void> showSuccess(
    BuildContext context, {
    required String title,
    String? message,
    Duration duration = const Duration(milliseconds: 1800),
  }) {
    return show(
      context,
      title: title,
      message: message,
      type: CenterAlertType.success,
      duration: duration,
    );
  }

  static Future<void> showInfo(
    BuildContext context, {
    required String title,
    String? message,
    Duration duration = const Duration(milliseconds: 1800),
  }) {
    return show(
      context,
      title: title,
      message: message,
      type: CenterAlertType.info,
      duration: duration,
    );
  }

  static Future<void> showWarning(
    BuildContext context, {
    required String title,
    String? message,
    Duration duration = const Duration(milliseconds: 1800),
  }) {
    return show(
      context,
      title: title,
      message: message,
      type: CenterAlertType.warning,
      duration: duration,
    );
  }
}

class _CenterAlertCard extends StatelessWidget {
  final String title;
  final String? message;
  final CenterAlertType type;

  const _CenterAlertCard({
    required this.title,
    this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    Color iconBgColor;
    Color iconColor;
    IconData iconData;

    switch (type) {
      case CenterAlertType.success:
        iconBgColor = const Color(0xFFD1FAE5);
        iconColor = const Color(0xFF059669);
        iconData = Icons.check_circle_rounded;
        break;
      case CenterAlertType.info:
        iconBgColor = const Color(0xFFEFF6FF);
        iconColor = const Color(0xFF2563EB);
        iconData = Icons.info_rounded;
        break;
      case CenterAlertType.warning:
        iconBgColor = const Color(0xFFFEF3C7);
        iconColor = const Color(0xFFD97706);
        iconData = Icons.warning_rounded;
        break;
      case CenterAlertType.error:
        iconBgColor = const Color(0xFFFFE4E6);
        iconColor = const Color(0xFFE11D48);
        iconData = Icons.cancel_rounded;
        break;
    }

    return Container(
      width: 280,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon Bulat Elegan
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                iconData,
                color: iconColor,
                size: 34,
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Judul Alert
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F172A),
              letterSpacing: -0.2,
            ),
          ),

          // Pesan Detail (jika ada)
          if (message != null && message!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF64748B),
                height: 1.35,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
