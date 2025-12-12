import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  group('PricingRepository', () {
    final repo = PricingRepository(footlongPrice: 11, sixInchPrice: 7);

    test('six-inch single quantity', () {
      final total = repo.totalPrice(quantity: 1, isFootlong: false);
      expect(total, 7);
    });

    test('footlong single quantity', () {
      final total = repo.totalPrice(quantity: 1, isFootlong: true);
      expect(total, 11);
    });

    test('multiple quantities', () {
      final totalSix = repo.totalPrice(quantity: 3, isFootlong: false);
      final totalFoot = repo.totalPrice(quantity: 2, isFootlong: true);
      expect(totalSix, 21); // 7 * 3
      expect(totalFoot, 22); // 11 * 2
    });

    test('zero quantity returns zero', () {
      final total = repo.totalPrice(quantity: 0, isFootlong: true);
      expect(total, 0);
    });
  });
}
