import 'package:flutter/material.dart';
import 'package:wadi_shop/Models/new_product.dart';
import 'package:wadi_shop/Widgets/cart_widgets/adding_button.dart';
import 'package:wadi_shop/constants.dart';

class CartCard extends StatelessWidget {
  const CartCard(
      {super.key,
      required this.product,
      required this.adding,
      required this.removing,
      required this.orderIndex});
  final NewProduct product;
  final void Function() adding;
  final void Function() removing;
  final int orderIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 80),
      child: Card(
        margin: const EdgeInsets.all(8),
        color: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(product.image, fit: BoxFit.cover, width: 50),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${product.price} ريال',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        product.weight,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: MyButton(
                      press: adding,
                      icon: Icons.add_circle,
                      color: kprimaryColor,
                    ),
                  ),
                  Text(
                    '${product.orderIndex}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: MyButton(
                      press: removing,
                      icon: Icons.remove_circle,
                      color: kprimaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
