import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../widgets/common/center_alert.dart';

class GpsSubbar extends StatefulWidget {
  final String accuracy;

  const GpsSubbar({
    super.key,
    this.accuracy = '±2.4 m',
  });

  @override
  State<GpsSubbar> createState() => _GpsSubbarState();
}

class _GpsSubbarState extends State<GpsSubbar> {
  late String _currentAccuracy;
  bool _isCalibrating = false;

  @override
  void initState() {
    super.initState();
    _currentAccuracy = widget.accuracy;
  }

  Future<void> _calibrateGps() async {
    if (_isCalibrating) return;
    HapticFeedback.lightImpact();
    setState(() => _isCalibrating = true);

    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    final samples = ['±1.8 m', '±2.1 m', '±2.4 m', '±1.5 m'];
    samples.shuffle();

    setState(() {
      _currentAccuracy = samples.first;
      _isCalibrating = false;
    });

    CenterAlert.show(
      context,
      title: 'GPS Terkalibrasi (RTK-Fix)',
      message: 'Sinyal GNSS terkunci optimal dengan akurasi $_currentAccuracy.',
      type: CenterAlertType.success,
      duration: const Duration(milliseconds: 1500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Color(0xFFECFDF5),
        border: Border(
          bottom: BorderSide(color: Color(0xFFA7F3D0), width: 1.2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF10B981).withValues(alpha: 0.6),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    _isCalibrating ? 'Mengalibrasi Satelit RTK...' : 'GPS Geotag Terkunci (RTK-Ready)',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF065F46),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: _calibrateGps,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFA7F3D0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _isCalibrating
                      ? const SizedBox(
                          width: 10,
                          height: 10,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF047857)),
                        )
                      : const Text('🎯', style: TextStyle(fontSize: 10)),
                  const SizedBox(width: 4),
                  Text(
                    '$_currentAccuracy (Akurat)',
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF047857),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
