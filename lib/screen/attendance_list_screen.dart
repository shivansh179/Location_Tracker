import 'package:flutter/material.dart';
import 'landing_page.dart';
import 'all_users_map_screen.dart';
import 'location_screen.dart';

class AttendanceListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> members = [
    {
      'id': '1',
      'name': 'Rahul Sharma',
      'time': '9:30 am',
      'status': 'Working',
    },
    {
      'id': '2',
      'name': 'Aisha Khan',
      'time': '9:30 am',
      'status': 'Working',
    },
    {
      'id': '3',
      'name': 'Vikram Singh',
      'time': 'Not Logged In Yet',
      'status': '',
    },
  ];

  AttendanceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Tracker'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Shivansh Shukla"),
              accountEmail: Text("shivansh.shukla@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/shivansh.jpg"),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Landing Page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LandingPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('All Users Map'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllUsersMapScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Attendance'),
              onTap: () {
                Navigator.pop(context); // Close drawer and stay on the same page
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(member['name']),
            subtitle: Text(member['time']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.location_on, color: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationScreen(
                          memberId: member['id'],
                          memberName: member['name'],
                          showRoute: false,
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.map, color: Colors.red),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationScreen(
                          memberId: member['id'],
                          memberName: member['name'],
                          showRoute: true,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
