import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wadi_shop/Widgets/profile_widgets/add_address.dart';
import 'package:wadi_shop/Widgets/snakbar.dart';
import '../../Models/place.dart';
import '../../constants.dart';

class ChooseLocationList extends StatefulWidget {
  const ChooseLocationList({super.key, required this.select});
  final void Function(String location) select;

  @override
  State<ChooseLocationList> createState() => _ChooseLocationListState();
}

class _ChooseLocationListState extends State<ChooseLocationList> {
  int selectedAddressIndex = -1;
  Future<List<Place>> getAddress() async {
    final user = FirebaseAuth.instance.currentUser;

    final addressRef = FirebaseFirestore.instance
        .collection('address')
        .doc(user!.uid)
        .collection('id');

    try {
      final snapshot = await addressRef.get();
      final state = snapshot.docs.map((doc) {
        final data = doc.data();
        return Place(
          title: data['title'],
          location: PlaceLocation(
            latitude: data['lat'],
            longitude: data['lng'],
            address: data['address'],
          ),
          id: data['id'],
        );
      }).toList();

      return state;
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Place>>(
      future: getAddress(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        } else {
          final places = snapshot.data ?? [];
          // Use the places list here
          // For example, you can display the addresses in a ListView
          return SizedBox(
            height: 140,
            child: places.isEmpty
                ? Container(
                    width: 290,
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
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('You dont have address to show'),
                            TextButton(
                                onPressed: () async {
                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const AddPlace(),
                                      ));
                                  if (result != null) {
                                    setState(() {});
                                  }
                                },
                                child: const Text('Add One Now'))
                          ],
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: places.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 290,
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
                            widget.select(places[index].location.address);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          places[index].title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.check_circle_outline,
                                          color: selectedAddressIndex == index
                                              ? kprimaryColor
                                              : Colors.grey[600],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: kprimaryColor,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(
                                            places[index].location.address,
                                            maxLines: 3,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 15),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
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
      },
    );
  }
}
