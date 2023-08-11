class MyOrder {
  String time;
  String orderNumber;
  double orderPrice;
  String payMethod;
  String address;
  bool isDelivered;
  String username;
  String deliveryDate;
  MyOrder({
    required this.time,
    required this.orderNumber,
    required this.orderPrice,
    required this.payMethod,
    required this.address,
    required this.isDelivered,
    required this.username,
    required this.deliveryDate,
  });
}

// final myOrderData = [
//   MyOrder(
//     time: DateTime.now(),
//     orderNumber: 'CN23656#',
//     orderPrice: 650,
//     payMethod: 'كاش',
//     address: addressList[1].location,
//     isDelivered: false,
//   ),
//   MyOrder(
//     time: DateTime.now(),
//     orderNumber: 'CN23656#',
//     orderPrice: 650,
//     payMethod: 'كاش',
//     address: addressList[1].location,
//     isDelivered: true,
//   ),
//   MyOrder(
//     time: DateTime.now(),
//     orderNumber: 'CN23656#',
//     orderPrice: 650,
//     payMethod: 'كاش',
//     address: addressList[1].location,
//     isDelivered: true,
//   ),
// ];
