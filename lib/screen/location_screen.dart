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

  List<Map<String, dynamic>> filterLocationsByDate(
      List<dynamic> locations, DateTime date) {
    return locations
        .where((location) {
          final timestamp = DateTime.parse(location['timestamp']);
          return timestamp.year == date.year &&
              timestamp.month == date.month &&
              timestamp.day == date.day;
        })
        .toList()
        .cast<Map<String, dynamic>>();
  }

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
    final allVisitedLocations = member['visited_locations'];
    final filteredLocations =
        filterLocationsByDate(allVisitedLocations, selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.memberName),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
              ),
              Text(
                'Selected Date: ${selectedDate.toLocal().toString().split(' ')[0]}',
              ),
            ],
          ),
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(
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
                    ...filteredLocations.map<Marker>(
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
                if (widget.showRoute)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: filteredLocations
                            .map<LatLng>((loc) => LatLng(
                                  loc['latitude'],
                                  loc['longitude'],
                                ))
                            .toList(),
                        strokeWidth: 4.0,
                        color: Colors.blue,
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredLocations.length,
              itemBuilder: (context, index) {
                final location = filteredLocations[index];
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
