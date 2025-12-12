import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/order.dart';

void main() {
  group('Order Model Tests', () {
    test('Order creation and property access', () {
      final order = Order(
        id: 1,
        date: '2025-12-12 10:00:00',
        items: '2x Veggie Delight',
        totalPrice: 14.00,
        notes: 'No onions',
      );

      expect(order.id, 1);
      expect(order.date, '2025-12-12 10:00:00');
      expect(order.items, contains('Veggie'));
      expect(order.totalPrice, 14.00);
      expect(order.notes, 'No onions');
    });

    test('Order without id can be created', () {
      final order = Order(
        date: '2025-12-12 10:00:00',
        items: 'New Order',
        totalPrice: 20.00,
        notes: '',
      );

      expect(order.id, isNull);
      expect(order.items, 'New Order');
    });
  });
}
