import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth/model/order.dart';
import 'package:intl/intl.dart';

Widget orderInfoWidget(context, trxNumber, address) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'order_id: $trxNumber',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  'address: $address',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget subscriptionOrderDetails(BuildContext context, Order product) {
  return Card(
    child: item(context, product),
  );
}

Widget item(BuildContext context, Order datas) {
  DateTime dateTime =
      datas.timestamp.toDate(); //DateTime.parse(datas.timestamp);
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: .0, vertical: 0),
    child: FlatButton(
      onPressed: null,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image(
              height: 100,
              width: 100,
              image: CachedNetworkImageProvider(datas.productImage),
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        datas.productName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'x' + datas.qty.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '${datas.addressName}',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.blueGrey[600],
                    ),
                  ),
                  Text(
                    'តម្លៃ: ${datas.productPrice + datas.currency}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 16),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    DateFormat('d MMMM yyyy  hh:mm aaa').format(dateTime),
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: datas.status.statusColor,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(
                    width: 0.5, color: Colors.black.withOpacity(0.2)),
              ),
              child: Text(
                '${datas.status.statusValue}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget totalWidget(
    {BuildContext buildContext,
    String subTotal,
    String total,
    String discount,
    String deliveryFee}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          _totalInfo(field: 'subtotal', price: (double.parse(subTotal) - 8000).toString()),
          _totalInfo(field: 'delivery_charges', price: deliveryFee),
          _totalInfo(field: 'discount', price: discount),
          Divider(
            thickness: 0.5,
          ),
          _totalInfo(
              field: 'total', price: (total), fontWeight: FontWeight.bold),
        ],
      ),
    ),
  );
}

Widget _totalInfo(
    {String field, String price, dynamic fontWeight = FontWeight.w300}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Text(
              field,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ),
        Container(
          width: 100.0,
          child: Text(
            '\$' + price,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    ),
  );
}
