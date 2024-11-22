import 'package:flutter/material.dart';
import 'location_screen.dart';

class AttendanceListScreen extends StatelessWidget {
  // List of members with their details
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
            // Updated UserAccountsDrawerHeader with an image
            const UserAccountsDrawerHeader(
              accountName: Text("Shivansh Shukla"),
              accountEmail: Text("shivansh.shukla@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/shivansh.jpg"), // Local image
                // Use Image.network if you have an online image:
                // backgroundImage: NetworkImage("https://example.com/my_picture.jpg"),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
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
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Activity'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.pie_chart),
              title: const Text('Timesheet'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Report'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Jobsite'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Team'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.beach_access),
              title: const Text('Time Off'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Schedules'),
              onTap: () {},
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
                          showRoute: false, // Shows only current location
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.map, color: Color.fromARGB(255, 184, 22, 63)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationScreen(
                          memberId: member['id'],
                          memberName: member['name'],
                          showRoute: true, // Shows traveled route and locations
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
