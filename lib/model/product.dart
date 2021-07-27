class Product {
  String name;
  String description;
  String qty;
  String image;
  String price;
  String unit;
  String currency;
  String id;

  Product({this.name, this.description, this.qty, this.image, this.price,this.unit,this.currency,this.id});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    qty = json['qty'];
    image = json['image'];
    price = json['price'];
    unit = json['unit'];
    currency = json['currency'];
    id = json['id'];
  }

}
