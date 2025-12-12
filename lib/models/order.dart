class Order {
  final int? id;
  final String date;
  final String items;
  final double totalPrice;
  final String notes;

  Order({
    this.id,
    required this.date,
    required this.items,
    required this.totalPrice,
    required this.notes,
  });

  /// Convert Order to JSON for database storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'items': items,
      'totalPrice': totalPrice,
      'notes': notes,
    };
  }

  /// Create Order from JSON (database)
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as int?,
      date: json['date'] as String,
      items: json['items'] as String,
      totalPrice: json['totalPrice'] as double,
      notes: json['notes'] as String,
    );
  }

  @override
  String toString() {
    return 'Order(id: $id, date: $date, items: $items, totalPrice: $totalPrice, notes: $notes)';
  }
}
