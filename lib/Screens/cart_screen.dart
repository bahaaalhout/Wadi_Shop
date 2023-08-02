import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wadi_shop/Models/new_product.dart';
import 'package:wadi_shop/Screens/cart_screens/pay_screen.dart';

import 'package:wadi_shop/Widgets/cart_widgets/cart_card.dart';
import 'package:wadi_shop/constants.dart';
import 'package:wadi_shop/data/offers.dart';

import '../Widgets/cart_widgets/total_price.dart';
import '../data/product.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  List<NewProduct> selectedItem = [];
  var price = 0.0;

  void _cartItems() {
    final filteredItems = product.where((item) => item.orderIndex > 0).toList();
    final filteredOffer =
        productOffer.where((item) => item.orderIndex > 0).toList();
    setState(() {
      selectedItem = [...filteredItems, ...filteredOffer];
    });
    counting();
  }

  void counting() {
    var sum = 0.0;
    for (final product in selectedItem) {
      sum = sum + product.price * product.orderIndex;
    }

    setState(() {
      price = double.parse(sum.toStringAsFixed(1));
    });
  }

  void _adding(List<NewProduct> newproduct, int index) {
    setState(() {
      newproduct[index].orderIndex++;
      counting();
    });
  }

  void _removing(List<NewProduct> newproduct, int index) {
    if (newproduct[index].orderIndex == 1) {
      setState(() {
        newproduct[index].orderIndex--;
        selectedItem.remove(newproduct[index]);
      });
      return;
    }

    setState(() {
      newproduct[index].orderIndex--;
      counting();
    });
  }

  @override
  void initState() {
    super.initState();
    _cartItems();
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = const Center(
      child: Text('There is no item selected '),
    );
    if (selectedItem.isNotEmpty) {
      currentScreen = Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: selectedItem.length,
              itemBuilder: (BuildContext context, int index) {
                return CartCard(
                  product: selectedItem[index],
                  orderIndex: selectedItem[index].orderIndex,
                  adding: () {
                    setState(() {
                      _adding(selectedItem, index);
                    });
                  },
                  removing: () {
                    setState(() {
                      _removing(selectedItem, index);
                    });
                  },
                );
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                TotalPrice(
                  price: price,
                  title: 'سعر المنتجات',
                ),
                const TotalPrice(
                  price: 50,
                  title: 'سعر التوصيل',
                ),
                TotalPrice(
                  price: price + 50,
                  title: 'المجموع الكلي ',
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kprimaryColor,
                          foregroundColor: Colors.white,
                          elevation: 4,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PayScreen(price: price + 50),
                            ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('الاستمرار في الدفع'),
                          Text(
                              '${double.parse(price.toStringAsFixed(2)) + 50} ريال')
                        ],
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      );
    }
    return currentScreen;
  }
}
