import 'package:flutter/material.dart';

class TotalPrice extends StatelessWidget {
  const TotalPrice({
    super.key,
    required this.price,
    required this.title,
  });

  final double price;
  final String title;

  @override
  Widget build(BuildContext context) {
    final price2 = double.parse(price.toStringAsFixed(2));
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      trailing: Text(
        '$price2 ريال',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
