import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth/common/route_generator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'model/product.dart';

class ProductDetailPage extends StatefulWidget {
  final Product _product;

  ProductDetailPage(this._product);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _qty = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .6,
            width: double.infinity,
            child:  Image(
              image: CachedNetworkImageProvider(widget._product.image),
              fit: BoxFit.cover,
            ),/*Image.network(
              widget._product.image,
              fit: BoxFit.cover,
            ),*/
          ),
          Positioned(
            height: 42,
            width: 42,
            left: 30,
            top: 30 + MediaQuery.of(context).padding.top,
            child: RawMaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              constraints: BoxConstraints(),
              elevation: 0.0,
              fillColor: Colors.black.withOpacity(.07),
              child: Icon(
                FontAwesomeIcons.arrowLeft,
              ),
              shape: CircleBorder(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * .5,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      offset: Offset(0, -4),
                      blurRadius: 8)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 24, right: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget._product.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Icon(FontAwesomeIcons.heart),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Text(
                      widget._product.price + ' /1' + widget._product.unit,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                    child: Text(
                      widget._product.description,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(63, 200, 101, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'សេវាដឹកជញ្ចូន២៥ខេត្តក្រុង',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5, left: 30, right: 30),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'តម្លៃសេវាដឹកជញ្ជូន 8000រៀល',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (_qty > 1) {
                            setState(() {
                              _qty--;
                            });
                          }
                        },
                        child: Container(
                          height: 49,
                          width: 49,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(228, 228, 228, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '-',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 49,
                        width: 100,
                        child: Center(
                          child: Text(
                            '$_qty',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if(_qty < int.parse( widget._product.qty))
                          setState(() {
                            _qty++;
                          });
                        },
                        child: Container(
                          height: 49,
                          width: 49,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(243, 175, 45, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '+',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.07),
                            offset: Offset(0, -3),
                            blurRadius: 12)
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'តម្លៃសរុប',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                '25,000' + widget._product.currency,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Material(
                          color: Theme.of(context)
                              .primaryColor /*Color.fromRGBO(243, 175, 45, 1)*/,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  Constant.REVIEW_USER_INFO_PAGE,
                                  arguments: [widget._product, _qty]);
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'ទិញ',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
