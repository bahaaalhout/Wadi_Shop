import 'package:flutter/material.dart';
import 'package:wadi_shop/Models/place.dart';
import 'package:wadi_shop/constants.dart';

class AddressCard extends StatelessWidget {
  const AddressCard(
      {super.key, required this.address, required this.deleteItem});
  final Place address;
  final void Function() deleteItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 13, right: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    address.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  PopupMenuButton(
                    elevation: 3,
                    position: PopupMenuPosition.over,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    icon: Icon(
                      Icons.more_horiz,
                      color: Colors.grey[700],
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                          onTap: deleteItem,
                          child: const ListTile(
                            contentPadding: EdgeInsets.zero,
                            trailing: Icon(Icons.delete),
                            title: Text('حذف'),
                          ))
                    ],
                  )
                ],
              ),
              const Divider(),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: kprimaryColor,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        address.location.address,
                        maxLines: 3,
                        overflow: TextOverflow.clip,
                        style: TextStyle(color: Colors.grey[600], fontSize: 15),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
