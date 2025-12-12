import 'package:flutter/foundation.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

class CartItem {
  final Sandwich sandwich;
  int quantity;

  CartItem({required this.sandwich, required this.quantity});
}

class Cart extends ChangeNotifier {
  final List<CartItem> _items = [];
  String? notes;

  List<CartItem> get items => List.unmodifiable(_items);

  void add(Sandwich sandwich, {int quantity = 1}) {
    final existingIndex = _items.indexWhere((it) => _isSameSandwich(it.sandwich, sandwich));
    if (existingIndex == -1) {
      _items.add(CartItem(sandwich: sandwich, quantity: quantity));
    } else {
      _items[existingIndex].quantity += quantity;
    }
    notifyListeners();
  }

  void remove(Sandwich sandwich, {int quantity = 1}) {
    final existingIndex = _items.indexWhere((it) => _isSameSandwich(it.sandwich, sandwich));
    if (existingIndex == -1) return;
    final existing = _items[existingIndex];
    existing.quantity -= quantity;
    if (existing.quantity <= 0) {
      _items.removeAt(existingIndex);
    }
    notifyListeners();
  }

  int totalPrice(PricingRepository pricingRepository) {
    int total = 0;
    for (final it in _items) {
      total += pricingRepository.totalPrice(quantity: it.quantity, isFootlong: it.sandwich.isFootlong);
    }
    return total;
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  void setNotes(String? value) {
    notes = value;
    notifyListeners();
  }

  bool _isSameSandwich(Sandwich a, Sandwich b) {
    return a.type == b.type && a.isFootlong == b.isFootlong && a.breadType == b.breadType;
  }
}
