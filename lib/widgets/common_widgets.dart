import 'package:flutter/material.dart';

/// 购物车徽章小部件 - 显示购物车中的项目数
/// Shopping cart badge widget - displays the number of items in the cart
class CartBadge extends StatelessWidget {
  final int itemCount;

  const CartBadge({
    super.key,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
        child: Text(
          '$itemCount',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

/// 空状态小部件 - 当列表为空时显示
/// Empty state widget - displays when list is empty
class EmptyStateWidget extends StatelessWidget {
  final String message;
  final IconData? icon;

  const EmptyStateWidget({
    super.key,
    required this.message,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
          ],
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

/// 确认对话框小部件 - 用于删除或重置操作
/// Confirmation dialog widget - for delete or reset operations
class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmButtonText;
  final VoidCallback onConfirm;
  final Color? confirmButtonColor;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmButtonText,
    required this.onConfirm,
    this.confirmButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: Text(
            confirmButtonText,
            style: TextStyle(color: confirmButtonColor ?? Colors.red),
          ),
        ),
      ],
    );
  }
}

/// 主按钮小部件 - 标准化的提升按钮
/// Primary button widget - standardized elevated button
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData? icon;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.foregroundColor = Colors.white,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: icon != null ? Icon(icon, size: 18) : const SizedBox.shrink(),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      );
    }

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: isLoading
          ? const SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(label),
    );
  }
}

/// 信息卡片小部件 - 用于显示分组信息
/// Info card widget - for displaying grouped information
class InfoCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const InfoCard({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
}

/// 订单项列表小部件 - 显示订单中的单个项目
/// Order line item widget - displays individual items in an order
class OrderLineItem extends StatelessWidget {
  final String name;
  final String subtitle;
  final String quantity;
  final String price;
  final VoidCallback? onDelete;

  const OrderLineItem({
    super.key,
    required this.name,
    required this.subtitle,
    required this.quantity,
    required this.price,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(quantity),
          Text('£$price'),
        ],
      ),
    );
  }
}

/// 订单卡片小部件 - 用于订单历史列表
/// Order card widget - for order history list
class OrderCard extends StatelessWidget {
  final String date;
  final String items;
  final String notes;
  final String price;
  final VoidCallback onDelete;

  const OrderCard({
    super.key,
    required this.date,
    required this.items,
    required this.notes,
    required this.price,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        title: Text(
          date,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('Items: $items'),
            if (notes.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                'Notes: $notes',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '£$price',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
        isThreeLine: notes.isNotEmpty,
      ),
    );
  }
}

/// 设置卡片小部件 - 用于显示可调整的设置项
/// Setting card widget - for displaying adjustable setting items
class SettingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  final List<Widget> children;

  const SettingCard({
    super.key,
    required this.title,
    required this.children,
    this.subtitle = '',
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (subtitle.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
            if (children.isNotEmpty) ...[
              const SizedBox(height: 16),
              ...children,
            ],
          ],
        ),
      ),
    );
  }
}

/// 加载指示器小部件 - 显示加载状态
/// Loading indicator widget - displays loading state
class LoadingIndicator extends StatelessWidget {
  final String message;

  const LoadingIndicator({
    super.key,
    this.message = 'Loading...',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(message),
        ],
      ),
    );
  }
}

/// 总计显示小部件 - 显示金额总计
/// Total price widget - displays amount total
class TotalPrice extends StatelessWidget {
  final double price;
  final TextStyle? style;

  const TotalPrice({
    super.key,
    required this.price,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Total: £${price.toStringAsFixed(2)}',
      style: style ??
          const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

/// 分隔符 - 用于分组内容
/// Section divider - for grouping content
class SectionDivider extends StatelessWidget {
  final double height;
  final EdgeInsets padding;

  const SectionDivider({
    super.key,
    this.height = 16,
    this.padding = const EdgeInsets.symmetric(vertical: 0),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

/// SnackBar 辅助类 - 显示 SnackBar 消息的辅助函数
/// SnackBar helper class - utility class for displaying SnackBar messages
class SnackBarHelper {
  static void showMessage(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
      ),
    );
  }

  static void showSuccess(BuildContext context, String message) {
    showMessage(context, message);
  }

  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

/// 显示确认对话框的辅助函数
/// Helper function to show confirmation dialog
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmButtonText = 'Confirm',
  Color? confirmButtonColor,
}) async {
  return (await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                confirmButtonText,
                style: TextStyle(
                  color: confirmButtonColor ?? Colors.red,
                ),
              ),
            ),
          ],
        ),
      )) ??
      false;
}
