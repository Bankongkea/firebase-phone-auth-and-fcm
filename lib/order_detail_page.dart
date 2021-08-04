import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth/model/order.dart';

import 'component/order_detail.dart';

class OrderDetailPage extends StatefulWidget {
  final Order order;

  OrderDetailPage({this.order});

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text('order_detail'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                orderInfoWidget(
                    context,
                    widget.order.id,
                    widget.order.addressName +
                        '\n ' +
                        widget.order.addressNote),
                SizedBox(height: 8.0),
                subscriptionOrderDetails(context, widget.order),
                totalWidget(
                    buildContext: context,
                    subTotal: widget.order.totalPrice,
                    total: widget.order.totalPrice,
                    discount: "0",
                    deliveryFee: '8000')
                // SizedBox(height: 16),
                // _buildCardContact(),
                // SizedBox(height: 16.0),
              ],
            ),
          ),
          // buildButtonNext(context),
        ],
      ),
    );
  }
}
