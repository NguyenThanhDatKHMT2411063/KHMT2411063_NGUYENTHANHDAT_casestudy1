import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/transaction_model.dart';
import 'transaction_screen.dart';
import 'welcome_screen.dart'; // Import màn hình Welcome

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<TransactionModel> _transactions = [];
  double _totalIncome = 0;
  double _totalExpense = 0;
  bool _isLoading = true;
  bool _isBalanceVisible = true;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    setState(() => _isLoading = true);
    final data = await DatabaseHelper.instance.getAllTransactions();
    double income = 0;
    double expense = 0;

    for (var item in data) {
      if (item.type == 'income') {
        income += item.amount;
      } else {
        expense += item.amount;
      }
    }

    setState(() {
      _transactions = data;
      _totalIncome = income;
      _totalExpense = expense;
      _isLoading = false;
    });
  }

  void _deleteTransaction(int id) async {
    await DatabaseHelper.instance.deleteTransaction(id);
    _loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    double balance = _totalIncome - _totalExpense;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Quản lý thu chi', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: Colors.black)),
          // Nút quay về trang bắt đầu
          IconButton(
            tooltip: 'Trang bắt đầu',
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2979FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'SỐ DƯ HIỆN TẠI',
                            style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isBalanceVisible = !_isBalanceVisible;
                              });
                            },
                            child: Icon(
                              _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.white70,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _isBalanceVisible
                        ? '${balance.toStringAsFixed(0)} đ'
                        : '******** đ',
                    style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('TỔNG THU NHẬP', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('+${_totalIncome.toStringAsFixed(0)} đ', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('TỔNG CHI TIÊU', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('-${_totalExpense.toStringAsFixed(0)} đ', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Giao dịch gần đây', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _transactions.isEmpty
                ? const Center(child: Padding(padding: EdgeInsets.all(32), child: Text('Chưa có giao dịch nào')))
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final item = _transactions[index];
                final isIncome = item.type == 'income';
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isIncome ? Colors.green.shade100 : Colors.orange.shade100,
                      child: Icon(isIncome ? Icons.arrow_downward : Icons.restaurant, color: isIncome ? Colors.green : Colors.orange),
                    ),
                    title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${item.category} • ${item.date}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${isIncome ? '+' : '-'}${item.amount.toStringAsFixed(0)} đ',
                          style: TextStyle(color: isIncome ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, size: 20, color: Colors.grey),
                          onPressed: () => _deleteTransaction(item.id!),
                        ),
                      ],
                    ),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TransactionScreen(transaction: item)),
                      );
                      _loadTransactions();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2979FF),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TransactionScreen()),
          );
          _loadTransactions();
        },
      ),
    );
  }
}