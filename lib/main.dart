import 'package:flutter/material.dart';
import 'transaction_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // Đặt isEdit = false để xem giao diện "Thêm giao dịch"
      // Đặt isEdit = true để xem giao diện "Sửa giao dịch"
      home: TransactionScreen(isEdit: false),
    );
  }
}