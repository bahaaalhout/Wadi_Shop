import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wadi_shop/Provider/cart_list_provider.dart';
import 'package:wadi_shop/Widgets/profile_widgets/order_card_styling.dart';
import 'package:wadi_shop/constants.dart';
import 'package:wadi_shop/data/Profile%20Data/my_order_data.dart';
import 'package:intl/intl.dart';

class MyOrderCard extends ConsumerWidget {
  const MyOrderCard({super.key, required this.order});
  final MyOrder order;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = order.time;
    final dateformat = DateFormat.yMd().format(now);
    final timeformat = DateFormat.Hm().format(now);
    final username = ref.watch(usernameProvider);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            blurRadius: 20.0, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: const Offset(
              5.0, // Move to right 10  horizontally
              5.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username.value ?? 'You',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text('وقت التوصيل: $dateformat $timeformat'),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CardColumn(title: 'رقم الأوردر', subtitle: order.orderNumber),
                  CardColumn(
                      title: 'سعر الأوردر',
                      subtitle: '${order.orderPrice} ريال'),
                  CardColumn(title: 'طريقة الدفع', subtitle: order.payMethod),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: kprimaryColor,
                  ),
                  Text(
                    order.address,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
              const Divider(),
              Center(
                child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      order.isDelivered
                          ? Icons.check_circle
                          : Icons.cancel_outlined,
                      color:
                          order.isDelivered ? kprimaryColor : ksecoundaryColor,
                    ),
                    label: Text(
                      order.isDelivered ? 'تفاصيل الأوردر' : 'إلغاء الأوردر',
                      style: const TextStyle(
                          color: kprimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
