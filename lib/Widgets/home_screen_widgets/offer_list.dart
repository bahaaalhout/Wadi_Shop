import 'package:flutter/material.dart';
import 'package:wadi_shop/Widgets/home_screen_widgets/offer_product_card.dart';
import 'package:wadi_shop/data/offers.dart';

class OffersList extends StatelessWidget {
  const OffersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final product in productOffer) OfferCard(newProduct: product),
      ],
    );
  }
}
