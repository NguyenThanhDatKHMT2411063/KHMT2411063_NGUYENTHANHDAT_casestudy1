import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/transaction_model.dart';

class TransactionScreen extends StatefulWidget {
  final TransactionModel? transaction;
  const TransactionScreen({super.key, this.transaction});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  late String _type;
  late String _category;
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _noteController = TextEditingController();

  final List<String> _categories = ['Ăn uống', 'Di chuyển', 'Mua sắm', 'Giáo dục', 'Thu nhập'];

  @override
  void initState() {
    super.initState();
    if (widget.transaction != null) {
      _type = widget.transaction!.type;
      _category = widget.transaction!.category;
      _titleController.text = widget.transaction!.title;
      _amountController.text = widget.transaction!.amount.toStringAsFixed(0);
      _dateController.text = widget.transaction!.date;
      _noteController.text = widget.transaction!.note ?? '';
    } else {
      _type = 'expense';
      _category = 'Ăn uống';
      _dateController.text = '12/04/2025';
    }
  }

  void _save() async {
    final title = _titleController.text.isEmpty ? _category : _titleController.text;
    final amount = double.tryParse(_amountController.text) ?? 0;

    if (amount <= 0) return;

    final item = TransactionModel(
      id: widget.transaction?.id,
      title: title,
      amount: amount,
      category: _category,
      date: _dateController.text,
      type: _type,
      note: _noteController.text,
    );

    if (widget.transaction == null) {
      await DatabaseHelper.instance.insertTransaction(item);
    } else {
      await DatabaseHelper.instance.updateTransaction(item);
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.transaction != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Sửa giao dịch' : 'Thêm giao dịch'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _type == 'expense' ? Colors.redAccent : Colors.grey.shade200,
                      foregroundColor: _type == 'expense' ? Colors.white : Colors.black,
                    ),
                    onPressed: () => setState(() => _type = 'expense'),
                    child: const Text('Chi tiêu'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _type == 'income' ? Colors.green : Colors.grey.shade200,
                      foregroundColor: _type == 'income' ? Colors.white : Colors.black,
                    ),
                    onPressed: () => setState(() => _type = 'income'),
                    child: const Text('Thu nhập'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Danh mục', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _categories.contains(_category) ? _category : _categories.first,
              isExpanded: true,
              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (val) => setState(() => _category = val!),
            ),
            const SizedBox(height: 15),
            const Text('Số tiền', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Nhập số tiền', suffixText: 'đ'),
            ),
            const SizedBox(height: 15),
            const Text('Ngày giao dịch', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(suffixIcon: Icon(Icons.calendar_today)),
            ),
            const SizedBox(height: 15),
            const Text('Ghi chú', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(hintText: 'Nhập ghi chú (tùy chọn)'),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1565C0)),
                onPressed: _save,
                child: const Text('Lưu', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }
}