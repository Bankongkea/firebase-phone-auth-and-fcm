import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_phone_auth/model/status_type.dart';

class Order {
  String customerName;
  String productId;
  String qty;
  String productImage;
  String productPrice;
  String productName;
  String unit;
  String currency;
  double lat;
  double lng;
  String addressName;
  String addressNote;
  String phoneNumber;
  StatusType status;
  String id;
  Timestamp timestamp;
  String totalPrice;

  Order(
      {this.customerName,
      this.productId,
      this.qty,
      this.productImage,
      this.productPrice,
      this.unit,
      this.currency,
      this.phoneNumber,
      this.lng,
      this.lat,
      this.addressName,
      this.addressNote,
      this.status,
      this.timestamp,
      this.totalPrice});

  Order.fromJson(Map<String, dynamic> json) {
    customerName = json['customer_name'];
    productId = json['product_id'];
    productName = json['product_name'];
    qty = json['qty'];
    productImage = json['product_image'];
    productPrice = json['product_price'];
    unit = json['unit'];
    currency = json['currency'];
    lat = json['lat'];
    lng = json['lng'];
    addressName = json['address_name'];
    addressNote = json['address_note'];
    phoneNumber = json['phone_number'];
    status = StatusType(json['status']);
     timestamp = json['timestamp'];
     totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_name'] = this.customerName;
    data['product_id'] = this.productId;
    data['qty'] = this.qty;
    data['product_image'] = this.productImage;
    data['product_price'] = this.productPrice;
    data['unit'] = this.unit;
    data['currency'] = this.currency;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['address_name'] = this.addressName;
    data['address_note'] = this.addressNote;
    data['status'] = this.status.statusCode;
    data['phone_number'] = this.phoneNumber;
    data['product_name'] = this.productName;
    data['total_price'] = this.totalPrice;
    data['timestamp'] = DateTime.now();
    return data;
  }
}
