import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth/model/product.dart';
import 'package:flutter_firebase_phone_auth/common/route_generator.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ផ្ទះចំការ'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('product').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return GridView.count(
            padding: const EdgeInsets.all(8.0),
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.5,
            // gridDelegate:
            //     SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data();
              Product product = Product.fromJson(data);
              product.id = document.id;
              return getStructuredGridCell(product, context);
            }).toList(),
          );
        },
      ),
    );
  }
}

Widget getStructuredGridCell(Product product, BuildContext context) {
  return Stack(
    children: [
      Container(
        child: Card(
          elevation: 1.5,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisSize: MainAxisSize.max,
            // verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Image(
                height: 180,
                width: double.infinity,
                image: CachedNetworkImageProvider(product.image),
                fit: BoxFit.cover,
              ),
             /* Image.network(product.image,
                  height: 180, width: double.infinity, fit: BoxFit.cover),*/
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      'ចំនួននៅក្នុងស្ដុក:  ${product.qty}${product.unit}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        top: 16,
        right: 16,
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(4.0),
            border:
                Border.all(width: 0.5, color: Colors.black.withOpacity(0.2)),
          ),
          child: Text(
            product.price + product.currency,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      Positioned.fill(
          child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(Constant.PRODUCT_DETAIL_PAGE,
                    arguments: product);
              },
            )),
      ))
    ],
  );
}
