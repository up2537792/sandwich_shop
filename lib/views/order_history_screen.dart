import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/widgets/app_drawer.dart';
import 'package:sandwich_shop/widgets/app_bar_widget.dart';
import 'package:sandwich_shop/providers/order_history_provider.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderHistoryProvider>().loadOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(title: 'Order History'),
      ),
      body: Consumer<OrderHistoryProvider>(
        builder: (context, orderHistory, child) {
          if (orderHistory.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (orderHistory.orders.isEmpty) {
            return const Center(
              child: Text('No orders yet. Start shopping!'),
            );
          }

          return ListView.builder(
            itemCount: orderHistory.orders.length,
            itemBuilder: (context, index) {
              final order = orderHistory.orders[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ListTile(
                  title: Text(
                    order.date,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('Items: ${order.items}'),
                      if (order.notes.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text('Notes: ${order.notes}', style: const TextStyle(fontStyle: FontStyle.italic)),
                      ],
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '£${order.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Order?'),
                              content: const Text('This action cannot be undone.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.read<OrderHistoryProvider>().deleteOrder(order.id!);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  isThreeLine: order.notes.isNotEmpty,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Consumer<OrderHistoryProvider>(
        builder: (context, orderHistory, child) {
          if (orderHistory.orders.isEmpty) {
            return const SizedBox.shrink();
          }
          return FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Clear All Orders?'),
                  content: const Text('This will delete all order history. This action cannot be undone.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<OrderHistoryProvider>().clearAllOrders();
                        Navigator.pop(context);
                      },
                      child: const Text('Clear All', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
            backgroundColor: Colors.red,
            tooltip: 'Clear all orders',
            child: const Icon(Icons.delete_sweep),
          );
        },
      ),
    );
  }
}
