import 'package:flutter/foundation.dart';
import 'package:sandwich_shop/models/order.dart';
import 'package:sandwich_shop/services/database_service.dart';
import 'package:intl/intl.dart';

class OrderHistoryProvider extends ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();
  List<Order> _orders = [];
  bool _isLoading = false;

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;

  /// Load all orders from database
  Future<void> loadOrders() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _orders = await _dbService.getAllOrders();
    } catch (e) {
      debugPrint('Error loading orders: $e');
    }
    
    _isLoading = false;
    notifyListeners();
  }

  /// Save a new order
  Future<void> saveOrder(List<String> itemList, double totalPrice, String notes) async {
    final now = DateTime.now();
    final dateStr = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    final itemsStr = itemList.join(', ');

    final order = Order(
      date: dateStr,
      items: itemsStr,
      totalPrice: totalPrice,
      notes: notes,
    );

    try {
      await _dbService.insertOrder(order);
      await loadOrders();
    } catch (e) {
      debugPrint('Error saving order: $e');
    }
  }

  /// Delete order by id
  Future<void> deleteOrder(int orderId) async {
    try {
      await _dbService.deleteOrder(orderId);
      await loadOrders();
    } catch (e) {
      debugPrint('Error deleting order: $e');
    }
  }

  /// Clear all orders
  Future<void> clearAllOrders() async {
    try {
      await _dbService.deleteAllOrders();
      await loadOrders();
    } catch (e) {
      debugPrint('Error clearing orders: $e');
    }
  }

  /// Get order count
  Future<int> getOrderCount() async {
    try {
      return await _dbService.getOrderCount();
    } catch (e) {
      debugPrint('Error getting order count: $e');
      return 0;
    }
  }
}
