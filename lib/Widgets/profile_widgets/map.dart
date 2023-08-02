import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wadi_shop/Widgets/profile_widgets/back_icon.dart';
import 'package:wadi_shop/constants.dart';

import '../../Models/place.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
      address: '',
    ),
    this.isSelected = true,
  });
  final PlaceLocation location;
  final bool isSelected;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? selectedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: kprimaryColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(selectedLocation);
          },
          icon: const Icon(Icons.save),
        ),
        title: widget.isSelected
            ? const Text('Pick Your Location')
            : const Text('Your Location'),
        actions: const [
          BackIcon(),
        ],
      ),
      body: GoogleMap(
        onTap: (position) {
          setState(() {
            selectedLocation = position;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.latitude, widget.location.longitude),
          zoom: 16,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('m1'),
            position: selectedLocation ??
                LatLng(widget.location.latitude, widget.location.longitude),
          ),
        },
      ),
    );
  }
}
