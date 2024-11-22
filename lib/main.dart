import 'package:flutter/material.dart';
import 'package:location_formatter/screen/attendance_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  AttendanceListScreen(), // Correctly imported and used
      debugShowCheckedModeBanner: false,
    );
  }
}

 