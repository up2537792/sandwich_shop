import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/views/app_styles.dart';
import 'package:sandwich_shop/views/cart_screen.dart';
import 'package:sandwich_shop/widgets/common_widgets.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final bool showCartIcon;
  final TextStyle? titleStyle;

  const AppBarWidget({
    super.key,
    required this.title,
    this.showCartIcon = true,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: titleStyle ?? const TextStyle(),
      ),
      actions: showCartIcon
          ? [
              Consumer<Cart>(
                builder: (context, cart, child) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(Icons.shopping_cart, size: 32),
                          if (cart.items.isNotEmpty)
                            CartBadge(itemCount: cart.items.length),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ]
          : null,
    );
  }
}
