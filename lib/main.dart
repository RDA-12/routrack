import 'package:flutter/material.dart';

void main() {
  runApp(const RoutrackApp());
}

/// Main widget of the app
class RoutrackApp extends StatelessWidget {
  /// Creates new [RoutrackApp]
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
