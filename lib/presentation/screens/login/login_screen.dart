import 'package:flutter/material.dart';
import '../loading/loading_screen.dart';
import 'widgets/login_footer.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneIdController = TextEditingController(text: '081234567890');
  final _passwordController = TextEditingController(text: 'secretpassword');

  @override
  void dispose() {
    _phoneIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoadingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D111A),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Foto Gudang Beras Lapangan dengan Petugas BULOG Asli
          Image.asset(
            'assets/images/bulog_warehouse.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.center,
            errorBuilder: (_, __, ___) => Image.network(
              'https://images.unsplash.com/photo-1586771107445-d3ca888129ff?q=80&w=1000',
              fit: BoxFit.cover,
            ),
          ),
          // Dark Vignette & Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF0A0F1D).withValues(alpha: 0.82),
                  const Color(0xFF070B16).withValues(alpha: 0.88),
                  const Color(0xFF04070E).withValues(alpha: 0.96),
                ],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const LoginHeader(),
                  const SizedBox(height: 24),
                  LoginForm(
                    phoneController: _phoneIdController,
                    passwordController: _passwordController,
                    onSubmit: _handleLogin,
                  ),
                  const SizedBox(height: 24),
                  const LoginFooter(),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
