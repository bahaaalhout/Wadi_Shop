import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wadi_shop/Screens/cart_screens/avaliable_time.dart';
import 'package:wadi_shop/Screens/cart_screens/delivery_time_list.dart';
import 'dart:ui' as ui;
import '../../Widgets/my_button.dart';
import '../../Widgets/profile_widgets/back_icon.dart';
import '../../constants.dart';
import 'location_list.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key, required this.price});
  final double price;
  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  final _keyState = GlobalKey<FormState>();
  bool isKash = false;
  bool isFinished = false;
  String? selectedDate; // Holds the selected date
  // Function to show the date picker

  void _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year + 5, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: firstDate,
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        selectedDate = DateFormat.yMd().format(pickedDate).toString();
      });
    }
  }

  void _validate() {
    FocusScope.of(context).unfocus();
    final isValid = _keyState.currentState!.validate();

    if (!isValid) {
      return print('error');
    }
    setState(() {
      isFinished = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kprimaryColor,
          foregroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'الدفع',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: const [
            BackIcon(),
          ]),
      body: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      right: 10,
                      top: 10,
                      bottom: 10,
                      left: isFinished ? 0 : 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: isFinished ? 10 : 0),
                        child: Container(
                          width: double.infinity,
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 27, horizontal: 10),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Icon(Icons.check_circle_rounded,
                                              color: Colors.blue),
                                          SizedBox(
                                            width: 13,
                                          ),
                                          Text('الدفع',
                                              style: TextStyle(
                                                  fontSize: 21,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                  ),
                                  const SizedBox(
                                    width: 13,
                                  ),
                                  Expanded(
                                    child: Row(children: [
                                      Icon(
                                        Icons.play_circle_outline,
                                        color: isFinished
                                            ? Colors.blue[700]
                                            : Colors.grey[600],
                                      ),
                                      const SizedBox(
                                        width: 13,
                                      ),
                                      Text('التوصيل',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: isFinished
                                                  ? Colors.black
                                                  : Colors.grey[600])),
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        isFinished ? 'اختر مكان التوصيل' : 'طريقة الدفع',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      !isFinished
                          ? Container(
                              width: double.infinity,
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
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        setState(() {
                                          isKash = true;
                                        });
                                      },
                                      title: const Text('كاش عند التوصيل',
                                          style: TextStyle(
                                            fontSize: 20,
                                          )),
                                      trailing: Icon(
                                        Icons.radio_button_on,
                                        size: 26,
                                        color: isKash
                                            ? kprimaryColor
                                            : Colors.grey[600],
                                      ),
                                    ),
                                    const Divider(),
                                    ListTile(
                                      onTap: () {
                                        setState(() {
                                          isKash = false;
                                        });
                                      },
                                      title: const Text('بطاقة بنكية',
                                          style: TextStyle(
                                            fontSize: 20,
                                          )),
                                      trailing: Icon(
                                        Icons.radio_button_on,
                                        size: 26,
                                        color: !isKash
                                            ? kprimaryColor
                                            : Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const ChooseLocationList(),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        isFinished ? 'اختر وقت التوصيل' : 'ادخل بيانات البطاقة',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: !isKash || isFinished
                                  ? Colors.black
                                  : Colors.grey[400],
                            ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      !isFinished
                          ? Container(
                              width: double.infinity,
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
                                color:
                                    !isKash ? Colors.white : Colors.grey[200],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 15,
                                  ),
                                  child: Form(
                                    key: _keyState,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          decoration: const InputDecoration(
                                            label: Text('رقم البطاقة'),
                                          ),
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().length < 16) {
                                              return 'تأكد من ادخال رقم البطاقة الصحيح';
                                            }
                                            return null;
                                          },
                                          enabled: isKash ? false : true,
                                          onSaved: (value) {},
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                onTap: isKash
                                                    ? null
                                                    : () {
                                                        _selectDate(context);
                                                      },
                                                decoration:
                                                    const InputDecoration(
                                                  label: Text(
                                                    "تاريخ الانتهاء",
                                                  ),
                                                ),
                                                readOnly:
                                                    true, // Prevent direct editing of the text field
                                                controller:
                                                    TextEditingController(
                                                  text: selectedDate,
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'ادخل تاريخ الانتهاء';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 14,
                                            ),
                                            Expanded(
                                              child: TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  label: Text('الرقم السري'),
                                                ),
                                                keyboardType:
                                                    TextInputType.text,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.trim().isEmpty ||
                                                      value.trim().length < 3) {
                                                    return 'خطأ';
                                                  }
                                                  return null;
                                                },
                                                enabled: isKash ? false : true,
                                                onSaved: (value) {},
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const DeliveryTime(),
                      SizedBox(height: !isFinished ? 20 : 10),
                      if (isFinished)
                        Text(
                          'المواعيد المتاحة',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      if (isFinished) const SizedBox(height: 10),
                      !isFinished
                          ? Container(
                              width: double.infinity,
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
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'الإجمالي:',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${widget.price} ريال',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                color: Colors.grey[700],
                                                fontSize: 18),
                                      ),
                                      ElevatedButton(
                                        onPressed: isKash
                                            ? () {
                                                setState(() {
                                                  isFinished = true;
                                                });
                                              }
                                            : _validate,
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 1),
                                          foregroundColor: kprimaryColor,
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                              color: kprimaryColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: const Text(
                                          'الإستمرار في الدفع',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const AvailableTime(),
                    ],
                  ),
                ),
              ),
            ),
            if (isFinished) MyButtonWidget(title: 'تأكيد الشراء', press: () {})
          ],
        ),
      ),
    );
  }
}
