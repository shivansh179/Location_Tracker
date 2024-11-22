import 'package:flutter/material.dart';

class LicensePage extends StatelessWidget {
  const LicensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('License'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Application License',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Copyright © 2024 Shivansh Shukla, Deepanshu, Samarth, and Satadeep Sadukhan. '
              'All rights reserved.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'This application is licensed under the MIT License. You are permitted to use, '
              'copy, modify, merge, publish, distribute, sublicense, and/or sell copies of this application, '
              'provided that the original copyright notice and this permission notice are included in all copies or substantial portions of the software.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Disclaimers',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This application is provided "as is," without warranty of any kind, express or implied, '
              'including but not limited to the warranties of merchantability, fitness for a particular purpose, and non-infringement. '
              'In no event shall the authors or copyright holders be liable for any claim, damages, or other liability, '
              'whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the application or the use or other dealings in the application.',
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                child: const Text('Back to Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
