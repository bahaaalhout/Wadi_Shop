import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wadi_shop/Provider/myfavorite_provider.dart';
import 'package:wadi_shop/Widgets/cart_widgets/cart_card.dart';
import 'package:wadi_shop/Widgets/login_button.dart';
import 'package:wadi_shop/Widgets/snakbar.dart';

import '../Models/new_product.dart';

class FavouriteScreen extends ConsumerStatefulWidget {
  const FavouriteScreen({
    super.key,
  });

  @override
  ConsumerState<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends ConsumerState<FavouriteScreen> {
  List<NewProduct> listToCart = [];

  Future<List<NewProduct>> getFavorites() async {
    final user = FirebaseAuth.instance.currentUser;
    final favoriteRef = FirebaseFirestore.instance
        .collection('favorites')
        .doc(user!.uid)
        .collection('items');
    try {
      final snapshot = await favoriteRef.get();
      final favoriteList = snapshot.docs.map((doc) {
        final data = doc.data();
        return NewProduct(
          id: data['id'],
          categories: List<String>.from(data['categories']),
          image: data['image_url'],
          name: data['name'],
          price: data['price'],
          isDiscount: data['isDiscount'],
          weight: data['weight'],
        );
      }).toList();

      return favoriteList;
    } catch (e) {
      showSnackBar(
          content: 'Failed to retrieve favorites: $e', context: context);
      return [];
    }
  }

  void _removeExpense(NewProduct newProduct, List<NewProduct> myFavoriteList) {
    // final expenseIndex = myFavoriteList.indexOf(newProduct); i wanted to add undo feature but it didnt work

    FirebaseFirestore.instance
        .collection('favorites')
        .doc(auth.currentUser!.uid)
        .collection('items')
        .doc(newProduct.id)
        .delete();
    setState(() {
      myFavoriteList.remove(newProduct);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Removed'),
      duration: Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
    final user = FirebaseAuth.instance.currentUser;
    final favoriteRef = FirebaseFirestore.instance
        .collection('favorites')
        .doc(user!.uid)
        .collection('items');
    Widget content = currentUserId != null
        ? const Center(
            child: Text(
              'المفضلة فارغة...! \n اضف بعض العناصر',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          )
        : const LoginButton();

    return currentUserId != null
        ? FutureBuilder<List<NewProduct>>(
            future: getFavorites(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.data!.isEmpty) {
                return content;
              } else {
                final favoriteList = snapshot.data;
                listToCart = favoriteList!;
                // Use the favoriteList in your UI
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: favoriteList.length,
                          itemBuilder: (context, index) => Dismissible(
                                key: ValueKey(favoriteList[index]),
                                direction: DismissDirection.horizontal,
                                background: Container(
                                  margin: Theme.of(context).cardTheme.margin,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .error
                                      .withOpacity(.75),
                                  child: Icon(
                                    Icons.delete,
                                    color:
                                        Theme.of(context).colorScheme.onError,
                                  ),
                                ),
                                onDismissed: (direction) {
                                  _removeExpense(
                                      favoriteList[index], favoriteList);
                                },
                                child: CartCard(
                                  product: listToCart[index],
                                  adding: () {
                                    listToCart[index].orderIndex++;
                                    favoriteRef
                                        .doc(listToCart[index].id)
                                        .update({
                                      'orderindex': listToCart[index].orderIndex
                                    });
                                    setState(() {});
                                  },
                                  removing: () {
                                    listToCart[index].orderIndex--;
                                    favoriteRef.doc('$index').update({
                                      'orderindex': listToCart[index].orderIndex
                                    });
                                    setState(() {});
                                  },
                                  orderIndex: favoriteList[index].orderIndex,
                                ),
                              )),
                    ),
                  ],
                );
              }
            },
          )
        : const LoginButton();
  }
}
