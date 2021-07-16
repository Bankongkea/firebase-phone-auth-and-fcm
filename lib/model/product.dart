class Product {
  String name;
  String description;
  String qty;
  String image;
  String price;

  Product({this.name, this.description, this.qty, this.image, this.price});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    qty = json['qty'];
    image = json['image'];
    price = json['price'];
  }

}
