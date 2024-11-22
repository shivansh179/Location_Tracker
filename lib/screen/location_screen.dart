import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationScreen extends StatefulWidget {
  final String memberId;
  final String memberName;
  final bool showRoute;

  const LocationScreen({
    super.key,
    required this.memberId,
    required this.memberName,
    required this.showRoute,
  });

  @override
  // ignore: library_private_types_in_public_api
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  DateTime selectedDate = DateTime.now();

  // Hardcoded data for members
  final Map<String, dynamic> memberData = {
    '1': {
      "name": "Rahul Sharma",
      "current_location": {"latitude": 37.7749, "longitude": -122.4194},
      "visited_locations": [
        {
          "address": "Location A",
          "latitude": 37.7749,
          "longitude": -122.4194,
          "timestamp": "2024-11-21T08:30:00Z"
        },
        {
          "address": "Location B",
          "latitude": 37.7849,
          "longitude": -122.4294,
          "timestamp": "2024-11-21T09:45:00Z"
        },
        {
          "address": "Location C",
          "latitude": 37.7949,
          "longitude": -122.4394,
          "timestamp": "2024-11-21T14:15:00Z"
        },
      ]
    },
    '2': {
      "name": "Aisha Khan",
      "current_location": {"latitude": 37.7849, "longitude": -122.4294},
      "visited_locations": [
        {
          "address": "Location A",
          "latitude": 37.7849,
          "longitude": -122.4294,
          "timestamp": "2024-11-21T08:30:00Z"
        },
        {
          "address": "Location B",
          "latitude": 37.7949,
          "longitude": -122.4394,
          "timestamp": "2024-11-21T09:30:00Z"
        },
      ]
    },
    '3': {
      "name": "Vikram Singh",
      "current_location": {"latitude": 37.8049, "longitude": -122.4494},
      "visited_locations": [] // No visited locations
    },
  };

  @override
  Widget build(BuildContext context) {
    final member = memberData[widget.memberId];
    if (member == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Track Live Location')),
        body: const Center(child: Text('Member not found')),
      );
    }

    final currentLocation = member['current_location'];
    final visitedLocations = member['visited_locations'];
    final routePoints = visitedLocations
        .map<LatLng>((location) => LatLng(location['latitude'], location['longitude']))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.memberName),
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: widget.showRoute
                    ? (routePoints.isNotEmpty ? routePoints[0] : const LatLng(0, 0))
                    : LatLng(
                        currentLocation['latitude'],
                        currentLocation['longitude'],
                      ),
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    // Current location marker
                    Marker(
                      point: LatLng(
                        currentLocation['latitude'],
                        currentLocation['longitude'],
                      ),
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                    // Markers for visited locations
                    ...visitedLocations.map<Marker>(
                      (location) => Marker(
                        point: LatLng(
                          location['latitude'],
                          location['longitude'],
                        ),
                        child: const Icon(
                          Icons.place,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                // Draw polyline for the route if showRoute is true
                if (widget.showRoute && routePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: routePoints,
                        strokeWidth: 4.0,
                        color: Colors.blue,
                      ),
                    ],
                  ),
              ],
            ),
          ),
          // Timeline view for visited locations
          if (visitedLocations.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: visitedLocations.length,
                itemBuilder: (context, index) {
                  final location = visitedLocations[index];
                  return ListTile(
                    leading: const Icon(Icons.location_on, color: Colors.blue),
                    title: Text(location['address']),
                    subtitle: Text(
                      'Visited at ${DateTime.parse(location['timestamp']).toLocal()}',
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
