import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wadi_shop/Models/new_product.dart';
import 'package:wadi_shop/Widgets/snakbar.dart';

import 'get_address_provider.dart';

class FavoriteMeal extends StateNotifier<List<NewProduct>> {
  FavoriteMeal() : super([]);
  bool toggleFavoriteMeal(NewProduct product, BuildContext context) {
    final isFavorite = state.contains(product);
    if (isFavorite) {
      state = state.where((m) => m.id != product.id).toList();

      removeFromFavorites(product.id, context);
      return false;
    } else {
      state = [...state, product];

      addToFavorites(product.id, product, context);
      return true;
    }
  }
}

final myFavoriteItems = StateNotifierProvider<FavoriteMeal, List<NewProduct>>(
  (ref) {
    return FavoriteMeal();
  },
);
Future<void> addToFavorites(
    String itemId, NewProduct newProduct, BuildContext context) async {
  final user = auth.currentUser;
  final favoriteRef = FirebaseFirestore.instance
      .collection('favorites')
      .doc(user!.uid)
      .collection('items');

  try {
    await favoriteRef.doc(itemId).set({
      'id': newProduct.id,
      'categories': newProduct.categories,
      'image_url': newProduct.image,
      'name': newProduct.name,
      'price': newProduct.price,
      'isDiscount': newProduct.isDiscount,
      'weight': newProduct.weight,
      'isFavorite': newProduct.isFavorite,
      'orderIndex': newProduct.orderIndex
    }).then((value) {
      ScaffoldMessenger.of(context).clearSnackBars();
      return showSnackBar(context: context, content: 'تمت إضافته الى المفضلة');
    });
  } catch (e) {
    showSnackBar(
        context: context, content: 'Failed to add item to favorites: $e');
  }
}

Future<void> removeFromFavorites(String itemId, BuildContext context) async {
  final user = auth.currentUser;
  final favoriteRef = FirebaseFirestore.instance
      .collection('favorites')
      .doc(user!.uid)
      .collection('items');

  try {
    await favoriteRef.doc(itemId).delete().then((value) {
      ScaffoldMessenger.of(context).clearSnackBars();
      return showSnackBar(context: context, content: 'تم إزالته من المفضلة');
    });
  } catch (e) {
    showSnackBar(
        context: context, content: 'Failed to remove item to favorites: $e');
  }
}

/// ----------------------------------------------------------------------------------

