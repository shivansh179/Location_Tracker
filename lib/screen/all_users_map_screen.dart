import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AllUsersMapScreen extends StatelessWidget {
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
        options: MapOptions(
          initialCenter: const LatLng(37.7849, -122.4294), // Center of the map
          initialZoom: 12.0,
          onTap: (tapPosition, latLng) {
            // Optional: Handle tap on the map
          },
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
                width: 80,
                height: 80,
                child: GestureDetector(
                  onTap: () {
                    // Navigate to the UserDetailsScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailsScreen(user: user),
                      ),
                    );
                  },
                  child: Column(
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
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class UserDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserDetailsScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user['name']),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: user['current_location'], // Center on user location
                initialZoom: 14.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: user['current_location'],
                      width: 80,
                      height: 80,
                      child: const Icon(
                        Icons.person_pin_circle,
                        color: Colors.blue,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User Name: ${user['name']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Location: Lat ${user['current_location'].latitude}, '
                    'Lng ${user['current_location'].longitude}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: const Text('Back to Map'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
