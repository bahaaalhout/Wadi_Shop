import 'package:flutter/material.dart';
import 'package:wadi_shop/data/product.dart';
import 'package:wadi_shop/Widgets/home_screen_widgets/product_card.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 220),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: product.length,
        itemBuilder: (context, index) => ProductCard(
          product: product[index],
        ),
      ),
    );
  }
}
