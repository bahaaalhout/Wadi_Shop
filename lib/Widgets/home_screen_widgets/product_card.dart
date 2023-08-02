import 'package:flutter/material.dart';
import 'package:wadi_shop/constants.dart';
import 'package:wadi_shop/Models/new_product.dart';

import '../cart_widgets/adding_button.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
  });
  final NewProduct product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  void _adding(NewProduct newproduct) {
    setState(() {
      newproduct.orderIndex++;
    });
  }

  void _removing(NewProduct newproduct) {
    if (newproduct.orderIndex == 0) {
      return;
    }

    setState(() {
      newproduct.orderIndex--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 140),
      child: Card(
        elevation: 2,
        color: Colors.white,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 70,
                    child: Center(
                      child: Image.asset(
                        widget.product.image,
                        width: 60,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget.product.name,
                          softWrap: true,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Text(
                        '${widget.product.price} ريال',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.product.weight,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.product.orderIndex++;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(bottom: 4),
                            backgroundColor: kprimaryColor,
                            alignment: Alignment.center,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: widget.product.orderIndex > 0
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MyButton(
                                    press: () {
                                      _adding(widget.product);
                                    },
                                    icon: Icons.add_circle,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '${widget.product.orderIndex}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  MyButton(
                                    press: () {
                                      _removing(widget.product);
                                    },
                                    icon: Icons.remove_circle,
                                    color: Colors.white,
                                  ),
                                ],
                              )
                            : const Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              )),
                  )
                ],
              ),
            ),
            if (widget.product.isDiscount)
              Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    color: ksecoundaryColor,
                    child: const Text(
                      'خصم',
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
          ],
        ),
      ),
    );
  }
}
