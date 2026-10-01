import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 40),
              Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.account_balance_wallet, size: 70, color: Colors.blue),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Expense Manager',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF0D1B2A)),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Quản lý chi tiêu cá nhân\nđơn giản và hiệu quả',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.grey, height: 1.4),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1565C0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const DashboardScreen()),
                    );
                  },
                  child: const Text('Bắt đầu', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}