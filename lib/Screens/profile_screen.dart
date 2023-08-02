import 'package:flutter/material.dart';

import 'package:wadi_shop/Screens/ProfilePage_screens/my_address.dart';
import 'package:wadi_shop/Screens/ProfilePage_screens/my_order_screen.dart';
import 'package:wadi_shop/Screens/ProfilePage_screens/my_profile.dart';
import 'package:wadi_shop/Widgets/profile_widgets/profile_items.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.press});
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          ProfileItems(
            title: 'طلباتي',
            icon: Icons.edit,
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MyOrderScreen(),
              ));
            },
          ),
          ProfileItems(
            title: 'مفضلتي',
            icon: Icons.favorite_border,
            press: press,
          ),
          ProfileItems(
            title: 'عناويني',
            icon: Icons.location_on,
            press: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MyAddressScreen(),
                ),
              );
            },
          ),
          ProfileItems(
            title: 'بياناتي',
            icon: Icons.settings,
            press: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MyProfile(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
