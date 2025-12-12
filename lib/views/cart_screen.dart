import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';
import 'package:sandwich_shop/widgets/app_drawer.dart';

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
                Text('Total: £${cart.totalPrice(_pricingRepository)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  key: const Key('cart_notes'),
                  controller: _notesController,
                  decoration: const InputDecoration(labelText: 'Order notes (for entire order)'),
                  onChanged: (v) => cart.setNotes(v),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Done'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
