import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/order.dart';

void main() {
  group('Order Model Tests', () {
    test('Order toJson and fromJson', () {
      final order = Order(
        id: 1,
        date: '2025-12-12 10:00:00',
        items: '2x Veggie Delight, 1x Turkey',
        totalPrice: 25.50,
        notes: 'No onions',
      );

      final json = order.toJson();
      final fromJson = Order.fromJson(json);

      expect(fromJson.id, 1);
      expect(fromJson.date, '2025-12-12 10:00:00');
      expect(fromJson.items, '2x Veggie Delight, 1x Turkey');
      expect(fromJson.totalPrice, 25.50);
      expect(fromJson.notes, 'No onions');
    });

    test('Order toString returns formatted string', () {
      final order = Order(
        id: 1,
        date: '2025-12-12 10:00:00',
        items: 'Test Order',
        totalPrice: 10.00,
        notes: '',
      );

      expect(order.toString(), contains('Test Order'));
    });
  });
}
