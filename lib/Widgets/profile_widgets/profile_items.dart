import 'package:flutter/material.dart';

class ProfileItems extends StatelessWidget {
  const ProfileItems({
    super.key,
    required this.title,
    required this.icon,
    required this.press,
  });

  final IconData icon;
  final String title;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(5),
      onTap: press,
      leading: Icon(
        icon,
        color: Colors.grey[600],
        size: 28,
      ),
      title: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
