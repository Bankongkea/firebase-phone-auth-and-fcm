import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth/home_page.dart';
import 'package:flutter_firebase_phone_auth/login_page.dart';
import 'package:flutter_firebase_phone_auth/map_view_page.dart';
import 'package:flutter_firebase_phone_auth/model/address.dart';
import 'package:flutter_firebase_phone_auth/order_detail_page.dart';
import 'package:flutter_firebase_phone_auth/product_detail_page.dart';
import 'package:flutter_firebase_phone_auth/review_user_info_page.dart';
import 'package:flutter_firebase_phone_auth/thankyou_page.dart';
import 'package:flutter_firebase_phone_auth/verifycode_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // case '/vegetable-detail':
      //   var params = args as List;
      //   return MaterialPageRoute(
      //       builder: (_) => VegetableDetail(params[0], params[1]));

      case Constant.HOME_PAGE:
        // var params = args as List;
        return MaterialPageRoute(builder: (_) => HomePage());
      case Constant.LOGIN_PAGE:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case Constant.VERIFY_CODE_PAGE:
        return MaterialPageRoute(builder: (_) => VerifyCodePage(args));
      case Constant.PRODUCT_DETAIL_PAGE:
        return MaterialPageRoute(builder: (_) => ProductDetailPage(args));
      case Constant.REVIEW_USER_INFO_PAGE:
        var params = args as List;
        return MaterialPageRoute(builder: (_) => ReviewUserInfoPage(params[0], params[1]));
      case Constant.MAP_VIEW_PAGE:
        return MaterialPageRoute<AddressObj>(builder: (_) => MapViewPage());
      case Constant.THANK_YOU_PAGE:
        return MaterialPageRoute(builder: (_) => ThankYouPage());
      case Constant.ORDER_DETAIL:
        return MaterialPageRoute(builder: (_) => OrderDetailPage(order: args));

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

class Constant{
  static const String HOME_PAGE = 'homePage';
  static const String LOGIN_PAGE = 'loginPage';
  static const String VERIFY_CODE_PAGE = 'verifyCodePage';
  static const String PRODUCT_DETAIL_PAGE = 'productDetailPage';
  static const String REVIEW_USER_INFO_PAGE = 'reviewUserInfoPage';
  static const String MAP_VIEW_PAGE = 'mapViewPage';
  static const String THANK_YOU_PAGE = 'thankYouPage';
  static const String ORDER_DETAIL = 'orderDetail';
}