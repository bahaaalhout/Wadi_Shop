import 'package:wadi_shop/data/Profile%20Data/my_address_data.dart';

class MyOrder {
  DateTime time;
  String orderNumber;
  double orderPrice;
  String payMethod;
  String address;
  bool isDelivered;
  MyOrder({
    required this.time,
    required this.orderNumber,
    required this.orderPrice,
    required this.payMethod,
    required this.address,
    required this.isDelivered,
  });
}

final myOrderData = [
  MyOrder(
    time: DateTime.now(),
    orderNumber: 'CN23656#',
    orderPrice: 650,
    payMethod: 'كاش',
    address: addressList[1].location,
    isDelivered: false,
  ),
  MyOrder(
    time: DateTime.now(),
    orderNumber: 'CN23656#',
    orderPrice: 650,
    payMethod: 'كاش',
    address: addressList[1].location,
    isDelivered: true,
  ),
  MyOrder(
    time: DateTime.now(),
    orderNumber: 'CN23656#',
    orderPrice: 650,
    payMethod: 'كاش',
    address: addressList[1].location,
    isDelivered: true,
  ),
];
