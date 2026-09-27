import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black87),
        title: const Text(
          'Quản lý thu chi',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black87),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card SỐ DƯ HIỆN TẠI
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            'SỐ DƯ HIỆN TẠI',
                            style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.visibility_outlined, color: Colors.white70, size: 16),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '5.000.000 đ',
                        style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(width: 8, height: 4, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2))),
                          const SizedBox(width: 4),
                          Container(width: 4, height: 4, decoration: BoxDecoration(color: Colors.white54, borderRadius: BorderRadius.circular(2))),
                          const SizedBox(width: 4),
                          Container(width: 4, height: 4, decoration: BoxDecoration(color: Colors.white54, borderRadius: BorderRadius.circular(2))),
                        ],
                      )
                    ],
                  ),
                  Icon(Icons.account_balance_wallet_rounded, color: Colors.amber[300], size: 64),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // TỔNG THU NHẬP & TỔNG CHI TIÊU
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Color(0xFF4CAF50),
                          radius: 16,
                          child: Icon(Icons.arrow_downward, color: Colors.white, size: 18),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('TỔNG THU NHẬP', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                            SizedBox(height: 2),
                            Text('8.000.000 đ', style: TextStyle(color: Color(0xFF2E7D32), fontSize: 13, fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Color(0xFFE53935),
                          radius: 16,
                          child: Icon(Icons.arrow_upward, color: Colors.white, size: 18),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('TỔNG CHI TIÊU', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                            SizedBox(height: 2),
                            Text('3.000.000 đ', style: TextStyle(color: Color(0xFFC62828), fontSize: 13, fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // TIÊU ĐỀ GIAO DỊCH GẦN ĐÂY
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Giao dịch gần đây',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Xem tất cả', style: TextStyle(color: Colors.blue)),
                )
              ],
            ),

            // DANH SÁCH GIAO DỊCH
            _buildTransactionItem(Icons.restaurant, Colors.orange, 'Ăn trưa', 'Ăn uống', '03/09/2024', '-50.000 đ', isExpense: true),
            _buildTransactionItem(Icons.directions_car, Colors.blue, 'Xăng xe', 'Di chuyển', '03/09/2024', '-100.000 đ', isExpense: true),
            _buildTransactionItem(Icons.monetization_on, Colors.green, 'Lương tháng 9', 'Thu nhập', '01/09/2024', '+8.000.000 đ', isExpense: false),
            _buildTransactionItem(Icons.shopping_cart, Colors.purple, 'Mua sắm', 'Mua sắm', '31/08/2024', '-300.000 đ', isExpense: true),
            _buildTransactionItem(Icons.school, Colors.teal, 'Học phí', 'Giáo dục', '30/08/2024', '-500.000 đ', isExpense: true),
          ],
        ),
      ),

      // NÚT THÊM GIAO DỊCH
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2563EB),
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF2563EB),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Giao dịch'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Thống kê'),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
      IconData icon,
      Color color,
      String title,
      String category,
      String date,
      String amount, {
        required bool isExpense,
      }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Text('$category   $date', style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isExpense ? Colors.red : Colors.green,
            ),
          )
        ],
      ),
    );
  }
}