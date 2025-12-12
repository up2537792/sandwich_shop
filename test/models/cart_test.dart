import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  group('Cart', () {
    final pricing = PricingRepository(footlongPrice: 11, sixInchPrice: 7);

    test('add and total price for single item', () {
      final cart = Cart();
      final s = Sandwich(type: SandwichType.veggieDelight, isFootlong: true, breadType: BreadType.white);
      cart.add(s, quantity: 1);
      expect(cart.items.length, 1);
      expect(cart.totalPrice(pricing), 11);
    });

    test('add multiple quantities and compute total', () {
      final cart = Cart();
      final s = Sandwich(type: SandwichType.tunaMelt, isFootlong: false, breadType: BreadType.wholemeal);
      cart.add(s, quantity: 3);
      expect(cart.items.first.quantity, 3);
      expect(cart.totalPrice(pricing), 21); // 7 * 3
    });

    test('remove decreases quantity and removes when zero', () {
      final cart = Cart();
      final s = Sandwich(type: SandwichType.tunaMelt, isFootlong: false, breadType: BreadType.wholemeal);
      cart.add(s, quantity: 2);
      cart.remove(s, quantity: 1);
      expect(cart.items.first.quantity, 1);
      cart.remove(s, quantity: 1);
      expect(cart.items.length, 0);
    });
  });
}
