import 'package:flutter/material.dart';

import '../../constants.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    required this.search,
  });
  final void Function(String value) search;
  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        widget.search(value);
      },
      decoration: const InputDecoration(
        hintText: 'البحث عن منتج محدد',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(width: 1, color: kprimaryColor),
        ),
        suffixIcon: Icon(
          Icons.search,
          color: Colors.grey,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        filled: true,
        fillColor: Colors.white,
        constraints: BoxConstraints(
          maxWidth: 300,
        ),
      ),
    );
  }
}
