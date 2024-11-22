import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  // Function to launch email client
  void _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Contact&body=Hello,',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> teamMembers = [
      {
        'name': 'Shivansh Shukla',
        'course': 'B.Tech Student',
        'expertise': 'Web and App Developer',
        'email': "prasantshukla89@gmail.com"
      },
      {
        'name': 'Deepanshu',
        'course': 'B.Tech Student',
        'expertise': 'AI and ML',
        'email': "deepanshu@example.com"
      },
      {
        'name': 'Samarth',
        'course': 'B.Tech Student',
        'expertise': 'Cloud and DevOps Developer',
        'email': "samarth@example.com"
      },
      {
        'name': 'Satadeep Sadukhan',
        'course': 'B.Tech Student',
        'expertise': 'Full Stack Developer',
        'email': "satadeep@example.com"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Our Team',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: teamMembers.length,
                itemBuilder: (context, index) {
                  final member = teamMembers[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(member['name']!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(member['course']!),
                          Text(
                            'Expertise: ${member['expertise']}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      trailing: const Text(
                        'Click to Contact',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                        ),
                      ),
                      onTap: () {
                        _launchEmail(member['email']!);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}