class TransactionModel {
  final int? id;
  final String title;
  final double amount;
  final String category;
  final String date;
  final String type; // 'income' (Thu nhập) hoặc 'expense' (Chi tiêu)
  final String? note;

  TransactionModel({
    this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.type,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category,
      'date': date,
      'type': type,
      'note': note,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      category: map['category'],
      date: map['date'],
      type: map['type'],
      note: map['note'],
    );
  }
}