import 'package:intl/intl.dart';

final now = DateTime.now();
final first =
    DateFormat.Md().format(DateTime(now.year, now.month, now.day + 2));
final second =
    DateFormat.Md().format(DateTime(now.year, now.month, now.day + 3));
final third =
    DateFormat.Md().format(DateTime(now.year, now.month, now.day + 4));
final deliveryTime = [
  'اليوم',
  'غدا',
  first,
  second,
  third,
];

final avaliableTime = [
  'من 7 صباحاً الى  10 صباحاً',
  'من 10 صباحاً الى  1 ظهراً',
  'من 1 ظهراً الى  5  مساءً',
  'من 5  مساءً الى  9  مساءً',
];
