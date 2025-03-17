import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;

  // Initial map position (centered on a random location)
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(9.074285399999999, 7.4949809),
    zoom: 12,
  );

  // Set of markers to display on the map
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _addRandomMarkers();
  }

  // Add 7 random markers to the map
  void _addRandomMarkers() {
    final random = Random();
    for (int i = 0; i < 7; i++) {
      final lat = 9.074285399999999 + random.nextDouble() * 0.1;
      final lng = 7.4949809 + random.nextDouble() * 0.1;
      final markerId = MarkerId('marker_$i');
      final marker = Marker(
        markerId: markerId,
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: 'Point $i',
          snippet: 'This is point $i. Tap to navigate.',
          onTap: () {
            _showNavigationDialog(LatLng(lat, lng));
          },
        ),
      );
      _markers.add(marker);
    }
  }

  // Show a dialog to start navigation
  void _showNavigationDialog(LatLng destination) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Start Navigation'),
          content: const Text('Do you want to navigate to this point?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _startNavigation(destination);
                Navigator.pop(context);
              },
              child: const Text('Navigate'),
            ),
          ],
        );
      },
    );
  }

  // Simulate navigation (open Google Maps with the destination)
  void _startNavigation(LatLng destination) {
    final url =
        'https://www.google.com/maps/dir/?api=1&destination=${destination.latitude},${destination.longitude}';
    // For now, just print the URL
    debugPrint('Navigation URL: $url');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        markers: _markers,
        onMapCreated: (controller) {
          setState(() {
            _mapController = controller;
          });
        },
      ),
    );
  }
}
