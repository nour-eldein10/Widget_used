//use material or physical model or boxshadow in decoration: Decoration()


Material(
  elevation: 8, // Adjust elevation value (shadow intensity)
  borderRadius: BorderRadius.circular(12), // Optional: rounded corners
  child: Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      color: Colors.white, // Important: must have a color
      borderRadius: BorderRadius.circular(12), // Match with Material
    ),
    child: Center(child: Text('Elevated Container')),
  ),
)
  PhysicalModel(
  elevation: 8,
  color: Colors.white,
  borderRadius: BorderRadius.circular(12),
  child: Container(
    width: 200,
    height: 200,
    child: Center(child: Text('Elevated Container')),
  ),
)

  import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'Elevated Container',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

