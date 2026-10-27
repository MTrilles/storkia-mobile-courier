import 'package:flutter/material.dart';
import '../models/courier_model.dart';
import '../services/api_service.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final CourierModel courier;
  final String token;

  const HomeScreen({super.key, required this.courier, required this.token});

  void _handleLogout(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext loadingContext) => const Center(
        child: CircularProgressIndicator(color: Color(0xFF881337)),
      ),
    );

    await ApiService.logout(token);

    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: const Color(0xFF292524),
        title: const Text(
          'Courier Dashboard',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFF881337)),
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/s-express.png',
                width: 180,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF10B981)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Color(0xFF10B981)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Successfully connected to the Laravel API.',
                        style: TextStyle(
                          color: const Color(0xFF065F46).withOpacity(0.9),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Welcome, ${courier.firstName}!',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF292524),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Vehicle: ${courier.vehicleType} (${courier.plateNumber})',
                style: const TextStyle(fontSize: 14, color: Color(0xFF78716C)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
