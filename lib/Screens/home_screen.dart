import 'package:flutter/material.dart';

import '../Widgets/home_screen_widgets/image_slider.dart';

import '../Widgets/home_screen_widgets/offer_list.dart';
import '../Widgets/home_screen_widgets/product_list.dart';
import '../Widgets/home_screen_widgets/see_all.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onpress});
  final void Function() onpress;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ImageSlider(),
          SeeAll(
            press: onpress,
            title: 'المنتجات الجديدة',
          ),
          const ProductList(),
          const SizedBox(height: 10),
          SeeAll(
            press: onpress,
            title: 'العروض اليومية',
          ),
          const OffersList(),
        ],
      ),
    );
  }
}
