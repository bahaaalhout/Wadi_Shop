import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wadi_shop/Screens/browse_screen.dart';
import 'package:wadi_shop/Screens/cart_screen.dart';
import 'package:wadi_shop/Screens/favourite_screen.dart';
import 'package:wadi_shop/Screens/profile_screen.dart';
import 'package:wadi_shop/Widgets/browse_screen_widget/browse_search_textfield.dart';

import 'package:wadi_shop/constants.dart';

import '../Models/category.dart';
import '../Models/new_product.dart';
import '../data/product.dart';
import 'home_screen.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  var currentIndex = 0;
  List<NewProduct> filteredProductList = [];
  List<NewProduct> avaliableItem = product;
  bool isSearching = false;
  void filteredItem(CategoryList category) {
    final filteredList =
        product.where((item) => item.categories.contains(category.id)).toList();

    setState(() {
      avaliableItem = filteredList;
    });
  }

  void _selectIcon(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void _onPress() {
    setState(() {
      currentIndex = 1;
    });
  }

  void _navigateToFavoriteScreen() {
    setState(() {
      currentIndex = 3;
    });
  }

  void search(String value) {
    final filteredProducts = product
        .where((product) =>
            product.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

    setState(() {
      // Update the filtered products list
      filteredProductList = filteredProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = HomeScreen(
      onpress: _onPress,
    );
    if (currentIndex == 1) {
      activeScreen = Stack(
        children: [
          BrowseScreen(
            avaliableItem: avaliableItem,
            categoryFilter: filteredItem,
          ),
          if (filteredProductList.isNotEmpty)
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();

                setState(() {
                  filteredProductList = [];
                });
              },
              child: Container(
                color: Colors.grey.withOpacity(.3),
              ),
            ),
          if (filteredProductList.isNotEmpty)
            Positioned(
                top: 0,
                left: 10,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  height: 200,
                  width: 300,
                  child: ListView.builder(
                    itemCount: filteredProductList.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        FocusScope.of(context).unfocus();

                        setState(() {
                          avaliableItem = filteredProductList;
                          filteredProductList = [];
                        });
                      },
                      leading: const Icon(Icons.arrow_outward),
                      title: Text(filteredProductList[index].name),
                    ),
                  ),
                )),
        ],
      );
    }

    if (currentIndex == 2) {
      activeScreen = const CartScreen();
    }
    if (currentIndex == 3) {
      activeScreen = const FavouriteScreen();
    }
    if (currentIndex == 4) {
      activeScreen = ProfileScreen(
        press: _navigateToFavoriteScreen,
      );
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: currentIndex == 1
            ? AppBar(
                automaticallyImplyLeading: false,
                centerTitle: false,
                backgroundColor: kprimaryColor,
                title: SizedBox(
                  width: 60,
                  height: 100,
                  child: Image.asset(
                    'assets/images/appbar-wadi.png',
                    fit: BoxFit.cover,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SearchTextField(
                      search: search,
                    ),
                  )
                ],
              )
            : AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kprimaryColor,
                title: Image.asset(
                  'assets/images/appbar-wadi.png',
                  height: 350,
                ),
              ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 2,
          onTap: _selectIcon,
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_business,
              ),
              label: 'تصفح',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
              ),
              label: 'السلة',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border,
              ),
              label: 'مفضلتي',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline_outlined,
              ),
              label: 'البروفايل',
            ),
          ],
        ),
        body: activeScreen,
      ),
    );
  }
}
