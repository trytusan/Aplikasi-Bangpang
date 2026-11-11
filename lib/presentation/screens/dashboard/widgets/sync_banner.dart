import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../widgets/common/center_alert.dart';

class SyncBanner extends StatefulWidget {
  const SyncBanner({super.key});

  @override
  State<SyncBanner> createState() => _SyncBannerState();
}

class _SyncBannerState extends State<SyncBanner> {
  bool _isSyncing = false;
  int _pendingCount = 1;

  void _triggerSync() {
    if (_isSyncing) return;
    HapticFeedback.mediumImpact();

    setState(() => _isSyncing = true);

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted) return;
      setState(() {
        _isSyncing = false;
        _pendingCount = 0;
      });

      CenterAlert.showSuccess(
        context,
        title: 'Sinkronisasi Berhasil',
        message: 'Seluruh data penyerahan BAST offline telah tersimpan di server cloud BULOG.',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasPending = _pendingCount > 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: hasPending ? const Color(0xFFEFF6FF) : const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: hasPending ? const Color(0xFFBFDBFE) : const Color(0xFFA7F3D0),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: (hasPending ? const Color(0xFF3B82F6) : const Color(0xFF10B981)).withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon Container
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: hasPending ? const Color(0xFFDBEAFE) : const Color(0xFFD1FAE5),
                  shape: BoxShape.circle,
                ),
                child: _isSyncing
                    ? const Padding(
                        padding: EdgeInsets.all(10),
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          color: Color(0xFF2563EB),
                        ),
                      )
                    : Icon(
                        hasPending ? Icons.cloud_upload_rounded : Icons.cloud_done_rounded,
                        color: hasPending ? const Color(0xFF2563EB) : const Color(0xFF059669),
                        size: 20,
                      ),
              ),
              if (hasPending && !_isSyncing)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE11D48),
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      '$_pendingCount',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),

          // Teks Status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasPending
                      ? '$_pendingCount Transaksi Menunggu Sinkron'
                      : 'Semua Transaksi Tersinkronkan',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: hasPending ? const Color(0xFF1E3A8A) : const Color(0xFF065F46),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  hasPending
                      ? 'Data tersimpan di memori perangkat offline'
                      : 'Server BULOG telah menerima seluruh BAST',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: hasPending ? const Color(0xFF3B82F6) : const Color(0xFF059669),
                  ),
                ),
              ],
            ),
          ),

          // Tombol Aksi Sinkronkan
          if (hasPending)
            InkWell(
              onTap: _isSyncing ? null : _triggerSync,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2563EB).withValues(alpha: 0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isSyncing)
                      const SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(strokeWidth: 1.8, color: Colors.white),
                      )
                    else
                      const Icon(Icons.sync_rounded, color: Colors.white, size: 14),
                    const SizedBox(width: 5),
                    const Text(
                      'Sinkron',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            const Icon(
              Icons.check_circle_rounded,
              color: Color(0xFF10B981),
              size: 20,
            ),
        ],
      ),
    );
  }
}
