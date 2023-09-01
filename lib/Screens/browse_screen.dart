import 'package:flutter/material.dart';
import 'package:wadi_shop/Models/category.dart';
import 'package:wadi_shop/Models/new_product.dart';
import 'package:wadi_shop/Widgets/home_screen_widgets/product_card.dart';

import 'package:wadi_shop/data/dummy_data.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({
    super.key,
    required this.avaliableItem,
    required this.categoryFilter,
  });

  final List<NewProduct> avaliableItem;
  final void Function(CategoryList categoryList) categoryFilter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(maxHeight: 110),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dummyData.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                categoryFilter(dummyData[index]);
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 10, top: 1),
                height: 100,
                width: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: dummyData[index].color,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 50,
                        child: Image.asset(
                          dummyData[index].image,
                        ),
                      ),
                      Text(dummyData[index].title)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.53,
                crossAxisSpacing: .1,
                mainAxisSpacing: 1,
              ),
              children: [
                for (final product in avaliableItem)
                  ProductCard(product: product),
              ],
            ),
          ),
        )
      ],
    );
  }
}
