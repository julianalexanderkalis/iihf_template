import 'package:flutter/material.dart';

class AthleteDashboard extends StatefulWidget {
  const AthleteDashboard({super.key});

  @override
  State<AthleteDashboard> createState() => _AthleteDashboardState();
}

class _AthleteDashboardState extends State<AthleteDashboard> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("athlete"),
    );
  }
}
