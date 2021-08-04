import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth/model/order.dart';
import 'package:intl/intl.dart';

class OrderCell extends StatelessWidget {
  OrderCell({
    Key key,
    @required this.datas,
    this.onPressed,
    this.elevation = 1.0
  }) : super(key: key);

  final Order datas;
  final VoidCallback onPressed;
  final elevation;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = datas.timestamp.toDate();//DateTime.parse(datas.timestamp);
    return Padding(
      padding: const EdgeInsets.only(right: 4, left: 4),
      child: Card(
        elevation: elevation,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: .0, vertical: 8.0),
          child: FlatButton(
            onPressed: onPressed,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image(
                    height: 64,
                    width: 64,
                    image: CachedNetworkImageProvider(datas.productImage),
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          datas.productName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[600],
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text( '${datas.addressName}',
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.blueGrey[600],
                          ),
                        ),
                        Text( 'តម្លៃ: ${datas.totalPrice+datas.currency}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16
                          ),
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
        ),
      ),
    );
  }
}
