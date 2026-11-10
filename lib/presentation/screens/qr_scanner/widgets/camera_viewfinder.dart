import 'package:flutter/material.dart';

class CameraViewfinder extends StatefulWidget {
  const CameraViewfinder({super.key});

  @override
  State<CameraViewfinder> createState() => _CameraViewfinderState();
}

class _CameraViewfinderState extends State<CameraViewfinder> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _laserPosition;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _laserPosition = Tween<double>(begin: 8.0, end: 110.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1586771107445-d3ca888129ff?q=80&w=600'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.65),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 6),
                  const Text('Sensor Kamera Aktif', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.65),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white24),
              ),
              child: const Text('Auto-Focus', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
            ),
          ),

          // 4 Corner Reticle Frame
          SizedBox(
            width: 170,
            height: 170,
            child: Stack(
              children: [
                Positioned(top: 0, left: 0, child: _corner(true, true)),
                Positioned(top: 0, right: 0, child: _corner(true, false)),
                Positioned(bottom: 0, left: 0, child: _corner(false, true)),
                Positioned(bottom: 0, right: 0, child: _corner(false, false)),
              ],
            ),
          ),

          // Center QR Card
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 16, offset: Offset(0, 4))],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _qrBlock(26),
                          Container(width: 32, height: 6, color: Colors.black),
                          _qrBlock(26),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(width: 14, height: 4, color: Colors.black),
                          Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(color: Color(0xFF1E3A8A), shape: BoxShape.circle),
                            child: const Icon(Icons.inventory_2, color: Colors.white, size: 14),
                          ),
                          Container(width: 14, height: 4, color: Colors.black),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _qrBlock(26),
                          Container(width: 22, height: 10, color: Colors.black),
                          const Icon(Icons.grid_view_sharp, size: 24, color: Colors.black),
                        ],
                      ),
                    ],
                  ),
                ),

                // Animated Laser Line
                AnimatedBuilder(
                  animation: _laserPosition,
                  builder: (context, child) {
                    return Positioned(
                      top: _laserPosition.value,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 3,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF59E0B),
                          boxShadow: [
                            BoxShadow(color: const Color(0xFFF59E0B).withValues(alpha: 0.9), blurRadius: 8),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Arahkan kamera ke QR Code pada Lembar BAST /\nUndangan PBP',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600, height: 1.25),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _corner(bool isTop, bool isLeft) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        border: Border(
          top: isTop ? const BorderSide(color: Color(0xFFF59E0B), width: 3.5) : BorderSide.none,
          bottom: !isTop ? const BorderSide(color: Color(0xFFF59E0B), width: 3.5) : BorderSide.none,
          left: isLeft ? const BorderSide(color: Color(0xFFF59E0B), width: 3.5) : BorderSide.none,
          right: !isLeft ? const BorderSide(color: Color(0xFFF59E0B), width: 3.5) : BorderSide.none,
        ),
      ),
    );
  }

  Widget _qrBlock(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 4),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Container(width: size / 2.5, height: size / 2.5, color: Colors.black),
      ),
    );
  }
}
