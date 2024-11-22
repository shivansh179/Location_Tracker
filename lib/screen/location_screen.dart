import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationScreen extends StatelessWidget {
  final String memberId;
  final String memberName;
  final bool showRoute;

  LocationScreen({
    super.key,
    required this.memberId,
    required this.memberName,
    required this.showRoute,
  });

  // Hardcoded data for members
  final Map<String, dynamic> memberData = {
    '1': {
      "name": "Esther Howard",
      "current_location": {"latitude": 37.7749, "longitude": -122.4194},
      "visited_locations": [
        {
          "address": "2715 Ash Dr. San Jose, South Dakota 83475",
          "latitude": 32.7749,
          "longitude": -123.4194,
          "timestamp": "2024-11-21T08:30:00Z"
        },
        {
          "address": "1901 Thornridge Cir. Shiloh, Hawaii 81063",
          "latitude": 37.7849,
          "longitude": -122.4294,
          "timestamp": "2024-11-21T09:45:00Z"
        },
        {
          "address": "412 N College Ave, College Place, WA, US",
          "latitude": 39.7949,
          "longitude": -122.4394,
          "timestamp": "2024-11-21T14:15:00Z"
        },
      ]
    },
    '2': {
      "name": "Wade Warren",
      "current_location": {"latitude": 37.7849, "longitude": -122.4294},
      "visited_locations": [
        {
          "address": "2715 Ash Dr. San Jose, South Dakota 83475",
          "latitude": 37.7749,
          "longitude": -122.4194,
          "timestamp": "2024-11-21T08:30:00Z"
        },
        {
          "address": "456 Thornridge Cir, Shiloh, Hawaii",
          "latitude": 37.7849,
          "longitude": -122.4294,
          "timestamp": "2024-11-21T09:30:00Z"
        },
      ]
    },
    '3': {
      "name": "Shivansh Shukla",
      "current_location": {"latitude": 37.8049, "longitude": -122.4494},
      "visited_locations": [] // No visited locations
    },
  };

  @override
  Widget build(BuildContext context) {
    final member = memberData[memberId];

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
        title: Text(memberName),
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: showRoute
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
                    // Visited locations (only if showRoute is true)
                    if (showRoute)
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
                // Draw polyline for the route (only if showRoute is true)
                if (showRoute && routePoints.isNotEmpty)
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
          // Show timeline of visited locations (only if showRoute is true)
          if (showRoute)
            Expanded(
              child: ListView.builder(
                itemCount: visitedLocations.length,
                itemBuilder: (context, index) {
                  final location = visitedLocations[index];
                  return ListTile(
                    leading: const Icon(Icons.location_on, color: Colors.blue),
                    title: Text(location['address']),
                    subtitle: Text(
                        'Visited at ${DateTime.parse(location['timestamp']).toLocal()}'),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
