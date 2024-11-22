import 'package:flutter/material.dart';
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
              leading: const Icon(Icons.timer),
              title: const Text('Timer'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Attendance'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // Add more navigation options as required.
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
