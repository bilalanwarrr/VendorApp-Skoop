class CategoryModel {
  final String title;
  final String description;
  final String id;
  final String image;
  // final String img;

  CategoryModel(this.title, this.description, this.id, this.image);
}

class ItemModel {
  final String name;
  String catId = '';
  final String id;
  final int price;

  ItemModel(this.name, this.catId, this.id, this.price);
}

class Vendor {
  String name;
  String id;
  String desc = '';
  String email;
  String contact;
  String image = '';

  Vendor(
      {required this.name,
      required this.id,
      required this.desc,
      required this.email,
      required this.contact,
      required this.image});
}
