import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wadi_shop/Provider/myfavorite_provider.dart';
import '../Models/place.dart';

// Future<Database> _onLoad() async {
//   final getdb = await sql.getDatabasesPath();
//   final db = await sql.openDatabase(
//     path.join(getdb, 'places.db'),
//     onCreate: (db, version) {
//       return db.execute(
//           'CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT ,image TEXT , lat REAL ,lng REAL,address TEXT)');
//     },
//     version: 1,
//   );
//   return db;
// }

class AddNewItem extends StateNotifier<List<Place>> {
  AddNewItem() : super([]);

  void addItem(Place places) async {
    final newState = Place(
      title: places.title,
      location: places.location,
      id: places.id,
    );
    // QuerySnapshot snapshot = await FirebaseFirestore.instance
    //     .collection('address')
    //     .doc(auth.currentUser!.uid)
    //     .collection('id')
    //     .get();
    // final db = await _onLoad();
    // int i = 0;
    // db.insert('user_places', {
    //   'id': newState.id,
    //   'title': newState.title,
    //   'lat': newState.location.latitude,
    //   'lng': newState.location.longitude,
    //   'address': newState.location.address,
    // });

    await FirebaseFirestore.instance
        .collection('address')
        .doc(auth.currentUser!.uid)
        .collection('id')
        .doc(newState.id)
        .set({
      'id': newState.id,
      'title': newState.title,
      'lat': newState.location.latitude,
      'lng': newState.location.longitude,
      'address': newState.location.address,
    });

    state = [newState, ...state];
  }

  // Future loadPlaces() async {
  //    final db = await _onLoad();
  //   final data = await db.query(
  //     'user_places',
  //   );
  //   final places = data
  //       .map(
  //         (e) => Place(
  //           id: e['id'] as String,
  //           title: e['title'] as String,
  //           location: PlaceLocation(
  //             latitude: e['lat'] as double,
  //             longitude: e['lng'] as double,
  //             address: e['address'] as String,
  //           ),
  //         ),
  //       )
  //       .toList();
  //   state = places;
  // }
}

final userPlaceProvider =
    StateNotifierProvider<AddNewItem, List<Place>>((ref) => AddNewItem());
