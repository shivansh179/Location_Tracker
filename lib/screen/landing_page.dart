import 'package:flutter/material.dart';
import 'attendance_list_screen.dart';
import 'all_users_map_screen.dart';
import './about_us.dart';
import './contact_us.dart';
import './license_page.dart' as custom_license;

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Tracker App'),
        backgroundColor: Colors.blueGrey,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: Colors.blueGrey,
              child: const UserAccountsDrawerHeader(
                accountName: Text("Shivansh Shukla"),
                accountEmail: Text("shivansh.shukla@example.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/shivansh.jpg"),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.blueGrey),
              title: const Text('Landing Page'),
              onTap: () {
                Navigator.pop(context); // Close drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.map, color: Colors.teal),
              title: const Text('All Users Map'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllUsersMapScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.people, color: Colors.deepOrange),
              title: const Text('Attendance'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AttendanceListScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.indigo),
              title: const Text('About Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_phone, color: Colors.green),
              title: const Text('Contact Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactUsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.description, color: Colors.blueGrey),
              title: const Text('License'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const custom_license.LicensePage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Welcome to Map Tracker App!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'This app provides location tracking features for users, allowing you to view individual users on a map, track their visited locations, and display routes traveled.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Features:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '• View all users on the map.\n'
                '• Track attendance of individual users.\n'
                '• Display routes and visited locations.\n'
                '• Easily navigate using the sidebar menu.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AttendanceListScreen()),
                    );
                  },
                  child: const Text(
                    'Go to Attendance',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllUsersMapScreen()),
                    );
                  },
                  child: const Text(
                    'View All Users on Map',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
