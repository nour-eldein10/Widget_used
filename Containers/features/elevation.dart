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


//not work on 3dmodels

// The issue is that you're trying to use PhysicalModel with elevation inside a container that already has its own shadow and is being transformed. When you apply 3D transformations (like rotateY), the elevation/shadows don't transform properly in 3D space.

// The Problem:
// Transform breaks Material/PhysicalModel shadows: When you rotate widgets in 3D, the Material Design elevation system doesn't rotate with it properly.

// Layering issues: The container already has BoxShadow, and adding PhysicalModel inside it creates conflicting shadow systems.

// 3D perspective: True 3D shadows require proper perspective, which BoxShadow doesn't provide.

