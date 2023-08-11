import 'package:flutter/material.dart';
import 'package:wadi_shop/constants.dart';
import '../../Models/delivery_time.dart';

class AvailableTime extends StatefulWidget {
  const AvailableTime({super.key, required this.select});
  final void Function(int index) select;
  @override
  State<AvailableTime> createState() => _AvailableTimeState();
}

class _AvailableTimeState extends State<AvailableTime> {
  int selectedAddressIndex = -1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: avaliableTime.length,
        itemBuilder: (context, index) {
          return Container(
            width: 250,
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        avaliableTime[index],
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.check_circle_outline,
                        color: selectedAddressIndex == index
                            ? kprimaryColor
                            : Colors.grey[600],
                        size: 28,
                      ),
                    ],
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
