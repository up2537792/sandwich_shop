import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/views/cart_screen.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  testWidgets('CartScreen shows items and total, and notes update cart', (WidgetTester tester) async {
    final cart = Cart();
    final pricing = PricingRepository(footlongPrice: 11, sixInchPrice: 7);
    final s = Sandwich(type: SandwichType.veggieDelight, isFootlong: true, breadType: BreadType.white);
    cart.add(s, quantity: 2);

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => cart,
        child: const MaterialApp(home: CartScreen()),
      ),
    );
    await tester.pumpAndSettle();

  expect(find.textContaining('Veggie Delight'), findsOneWidget);
  expect(find.textContaining('Qty: 2'), findsOneWidget);
  // line total and summary both include '£22' — assert summary specifically
  expect(find.text('Total: £22'), findsOneWidget);

    // update notes
    await tester.enterText(find.byKey(const Key('cart_notes')), 'No onions');
    expect(cart.notes, 'No onions');
  });
}
