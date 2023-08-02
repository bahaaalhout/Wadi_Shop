import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wadi_shop/Models/new_product.dart';
import 'package:wadi_shop/Provider/myfavorite_provider.dart';
import 'package:wadi_shop/Widgets/snakbar.dart';
import 'package:wadi_shop/constants.dart';

class OfferCard extends ConsumerStatefulWidget {
  const OfferCard({super.key, required this.newProduct});
  final NewProduct newProduct;

  @override
  ConsumerState<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends ConsumerState<OfferCard> {
  @override
  Widget build(BuildContext context) {
    final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
    final favoriteItems = ref.watch(myFavoriteItems);

    final isFavorite = favoriteItems.contains(widget.newProduct);

    return Container(
      constraints: const BoxConstraints(minHeight: 90),
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
                  Image.asset(widget.newProduct.image,
                      fit: BoxFit.cover, width: 50),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.newProduct.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${widget.newProduct.price} ريال',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.newProduct.weight,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        if (currentUserId == null) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          return showSnackBar(
                              context: context,
                              content: 'You Have To Sign In First');
                        }
                        ref
                            .read(myFavoriteItems.notifier)
                            .toggleFavoriteMeal(widget.newProduct, context);
                      },
                      icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          widget.newProduct.orderIndex = 1;
                        });
                        ScaffoldMessenger.of(context).clearSnackBars();
                        showSnackBar(
                            context: context, content: 'تم اضافته الى السلة');
                      },
                      icon: Icon(
                        widget.newProduct.orderIndex > 0
                            ? Icons.done
                            : Icons.add,
                        color: kprimaryColor,
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
