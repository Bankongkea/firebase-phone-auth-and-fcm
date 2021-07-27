import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth/model/order.dart';

import 'component/order_cell.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('order').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Order> items = [];
          items = snapshot.data.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data();
            Order product = Order.fromJson(data);
            product.id = document.id;
            // items.add(product);
            return product;
            // return getStructuredGridCell(product, context);
          }).toList();
          print(items);
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return OrderCell(
                datas: items[index],
                onPressed: () {
                  // Navigator.pushNamed(context, '/myorder-details',
                  //     arguments: [items[index].trxNumber, items[index].totalPrice]);
                },
              );
            },
          );
        });
  }
}
