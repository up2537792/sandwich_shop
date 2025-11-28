import 'package:flutter/material.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';
import 'package:sandwich_shop/widgets/app_drawer.dart';

class CartScreen extends StatefulWidget {
  final Cart cart;
  final PricingRepository pricingRepository;

  const CartScreen({super.key, required this.cart, required this.pricingRepository});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController(text: widget.cart.notes ?? '');
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Widget _buildLineItem(int index) {
    final item = widget.cart.items[index];
    final sandwich = item.sandwich;
    final lineTotal = widget.pricingRepository.totalPrice(quantity: item.quantity, isFootlong: sandwich.isFootlong);
    final sizeText = sandwich.isFootlong ? 'Footlong' : '6-inch';
    return ListTile(
      title: Text('${sandwich.name} ($sizeText)', style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('Bread: ${sandwich.breadType.name}'),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('Qty: ${item.quantity}'),
          Text('£$lineTotal'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: widget.cart.items.isEmpty
                  ? const Center(child: Text('Cart is empty'))
                  : ListView.builder(
                      itemCount: widget.cart.items.length,
                      itemBuilder: (context, index) => _buildLineItem(index),
                    ),
            ),
            const SizedBox(height: 12),
            Text('Total: £${widget.cart.totalPrice(widget.pricingRepository)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              key: const Key('cart_notes'),
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Order notes (for entire order)'),
              onChanged: (v) => widget.cart.setNotes(v),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
