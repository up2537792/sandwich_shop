import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/widgets/app_drawer.dart';
import 'package:sandwich_shop/widgets/app_bar_widget.dart';
import 'package:sandwich_shop/providers/order_history_provider.dart';
import 'package:sandwich_shop/widgets/common_widgets.dart';

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
            return const LoadingIndicator();
          }

          if (orderHistory.orders.isEmpty) {
            return const EmptyStateWidget(
              message: 'No orders yet. Start shopping!',
              icon: Icons.shopping_bag_outlined,
            );
          }

          return ListView.builder(
            itemCount: orderHistory.orders.length,
            itemBuilder: (context, index) {
              final order = orderHistory.orders[index];
              return OrderCard(
                date: order.date,
                items: order.items,
                notes: order.notes,
                price: '£${order.totalPrice.toStringAsFixed(2)}',
                onDelete: () {
                  showConfirmDialog(
                    context,
                    title: 'Delete Order?',
                    message: 'This action cannot be undone.',
                  ).then((confirmed) {
                    if (confirmed) {
                      context.read<OrderHistoryProvider>().deleteOrder(order.id!);
                    }
                  });
                },
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
              showConfirmDialog(
                context,
                title: 'Clear All Orders?',
                message: 'This will delete all order history. This action cannot be undone.',
                confirmButtonText: 'Clear All',
              ).then((confirmed) {
                if (confirmed) {
                  context.read<OrderHistoryProvider>().clearAllOrders();
                }
              });
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
