final now = DateTime.now();
final now1 = DateTime(now.year, now.month, now.day + 1);
final first = DateTime(now.year, now.month, now.day + 2);
final second = DateTime(now.year, now.month, now.day + 3);
final third = DateTime(now.year, now.month, now.day + 4);
final deliveryTime = [
  now,
  now1,
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
