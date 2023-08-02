class NewProduct {
  String id;
  String image;
  String name;
  double price;
  String weight;
  bool isDiscount;
  List<String> categories;
  int orderIndex;
  bool isFavorite;

  NewProduct({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.isDiscount,
    required this.weight,
    required this.categories,
  })  : orderIndex = 0,
        isFavorite = false;
}
