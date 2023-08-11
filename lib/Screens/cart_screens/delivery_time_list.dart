import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wadi_shop/constants.dart';
import '../../Models/delivery_time.dart';

class DeliveryTime extends StatefulWidget {
  const DeliveryTime({
    super.key,
    required this.select,
  });
  final void Function(int index) select;
  @override
  State<DeliveryTime> createState() => _DeliveryTimeState();
}

class _DeliveryTimeState extends State<DeliveryTime> {
  int selectedAddressIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: deliveryTime.length,
        itemBuilder: (context, index) {
          final editedList = deliveryTime
              .map(
                (e) => DateFormat.Md().format(e),
              )
              .toList();
          if (index == 0) {
            editedList[0] = 'اليوم';
          }
          if (index == 1) {
            editedList[1] = 'غدا';
          }
          return Container(
            width: 130,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.1),
                  blurRadius: 20.0, // soften the shadow
                  spreadRadius: 0.0, //extend the shadow
                  offset: const Offset(
                    5.0, // Move to right 10  horizontally
                    5.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedAddressIndex = index;
                });
                widget.select(index);
              },
              child: Card(
                color: selectedAddressIndex == index
                    ? kprimaryColor
                    : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Center(
                    child: Text(
                      editedList[index].toString(),
                      style: TextStyle(
                        color: selectedAddressIndex == index
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
