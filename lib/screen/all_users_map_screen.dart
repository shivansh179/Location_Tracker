import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AllUsersMapScreen extends StatelessWidget {
  // Hardcoded list of users with current locations
  final List<Map<String, dynamic>> users = [
    {
      'id': '1',
      'name': 'Rahul Sharma',
      'current_location': const LatLng(37.7749, -122.4194),
    },
    {
      'id': '2',
      'name': 'Aisha Khan',
      'current_location': const LatLng(37.7849, -122.4294),
    },
    {
      'id': '3',
      'name': 'Vikram Singh',
      'current_location': const LatLng(37.8049, -122.4494),
    },
  ];

  AllUsersMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users on Map'),
      ),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(37.7849, -122.4294), // Center the map around a midpoint
          initialZoom: 12.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: users.map((user) {
              return Marker(
                point: user['current_location'],
                width: 80, // Adjust marker size
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person_pin_circle,
                      color: Colors.red,
                      size: 30,
                    ),
                    Text(
                      user['name'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
