import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';
import 'package:sandwich_shop/widgets/app_drawer.dart';
import 'package:sandwich_shop/widgets/app_bar_widget.dart';
import 'package:sandwich_shop/providers/order_history_provider.dart';
import 'package:sandwich_shop/widgets/common_widgets.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final TextEditingController _notesController;
  final PricingRepository _pricingRepository = PricingRepository(
    footlongPrice: 11,
    sixInchPrice: 7,
  );

  @override
  void initState() {
    super.initState();
    final Cart cart = Provider.of<Cart>(context, listen: false);
    _notesController = TextEditingController(text: cart.notes ?? '');
    _notesController.addListener(() {
      cart.setNotes(_notesController.text);
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Widget _buildLineItem(int index, Cart cart) {
    final item = cart.items[index];
    final sandwich = item.sandwich;
    final lineTotal = _pricingRepository.totalPrice(quantity: item.quantity, isFootlong: sandwich.isFootlong);
    return OrderLineItem(
      name: sandwich.name,
      subtitle: 'Bread: ${sandwich.breadType.name}',
      quantity: 'Qty: ${item.quantity}',
      price: '£$lineTotal',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(title: 'Your Cart', showCartIcon: false),
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: cart.items.isEmpty
                      ? const Center(child: Text('Cart is empty'))
                      : ListView.builder(
                          itemCount: cart.items.length,
                          itemBuilder: (context, index) => _buildLineItem(index, cart),
                        ),
                ),
                const SizedBox(height: 12),
                TotalPrice(price: (cart.totalPrice(_pricingRepository) as num).toDouble()),
                const SizedBox(height: 8),
                TextField(
                  key: const Key('cart_notes'),
                  controller: _notesController,
                  decoration: const InputDecoration(labelText: 'Order notes (for entire order)'),
                  onChanged: (v) => cart.setNotes(v),
                ),
                const SizedBox(height: 12),
                PrimaryButton(
                  label: 'Place Order',
                  onPressed: cart.items.isEmpty
                      ? null
                      : () async {
                          final itemList = cart.items
                              .map((item) =>
                                  '${item.quantity}x ${item.sandwich.name}')
                              .toList();
                          final totalPrice =
                              (cart.totalPrice(_pricingRepository) as num).toDouble();
                          await context.read<OrderHistoryProvider>().saveOrder(
                                itemList,
                                totalPrice,
                                cart.notes ?? '',
                              );
                          if (mounted) {
                            cart.clear();
                            Navigator.pop(context);
                            SnackBarHelper.showMessage(
                              context,
                              'Order saved to history',
                            );
                          }
                        },
                ),
                const SizedBox(height: 8),
                PrimaryButton(
                  label: 'Cancel',
                  backgroundColor: Colors.grey,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
