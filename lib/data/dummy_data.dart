import 'package:flutter/material.dart';
import 'package:wadi_shop/Models/category.dart';

final dummyData = [
  CategoryList(
    id: 'c1',
    title: 'الكل',
    image: 'assets/images/category/all.png',
    color: const Color.fromARGB(255, 5, 219, 12).withOpacity(.3),
  ),
  CategoryList(
    id: 'c2',
    title: 'الفاكهة',
    image: 'assets/images/category/fruits.png',
    color: Colors.red[300]!.withOpacity(.4),
  ),
  CategoryList(
    id: 'c3',
    title: 'التوابل',
    image: 'assets/images/category/spices.png',
    color: const Color.fromARGB(255, 153, 153, 153).withOpacity(.4),
  ),
  CategoryList(
    id: 'c4',
    title: 'الخضراوات',
    image: 'assets/images/category/vegetables.png',
    color: Colors.green[300]!.withOpacity(.4),
  ),
  CategoryList(
    id: 'c5',
    title: 'الأسماك',
    image: 'assets/images/category/fish.png',
    color: Colors.purple[300]!.withOpacity(.4),
  ),
];
