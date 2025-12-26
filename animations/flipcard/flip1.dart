import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MatrixFlipDemo()));

class MatrixFlipDemo extends StatefulWidget {
  @override
  _MatrixFlipDemoState createState() => _MatrixFlipDemoState();
}

class _MatrixFlipDemoState extends State<MatrixFlipDemo> {
  // Different flip types
  Matrix4 _flipX = Matrix4.identity()..scale(-1.0, 1.0);
  Matrix4 _flipY = Matrix4.identity()..scale(1.0, -1.0);
  Matrix4 _flipBoth = Matrix4.identity()..scale(-1.0, -1.0);
  Matrix4 _flipDiagonal = Matrix4.identity()
    ..scale(-1.0, 1.0)
    ..rotateZ(0.5);

  Matrix4 _currentTransform = Matrix4.identity();
  String _currentFlip = 'Normal';

  void _applyFlip(String type) {
    setState(() {
      _currentFlip = type;
      switch (type) {
        case 'Flip X':
          _currentTransform = _flipX;
          break;
        case 'Flip Y':
          _currentTransform = _flipY;
          break;
        case 'Flip Both':
          _currentTransform = _flipBoth;
          break;
        case 'Flip Diagonal':
          _currentTransform = _flipDiagonal;
          break;
        default:
          _currentTransform = Matrix4.identity();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Matrix Flip Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Flipped box
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 200,
              height: 200,
              transform: _currentTransform,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.transform, size: 50, color: Colors.white),
                      SizedBox(height: 10),
                      Text(
                        _currentFlip,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),

            // Flip buttons
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildFlipButton('Normal'),
                _buildFlipButton('Flip X'),
                _buildFlipButton('Flip Y'),
                _buildFlipButton('Flip Both'),
                _buildFlipButton('Flip Diagonal'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlipButton(String text) {
    return ElevatedButton(
      onPressed: () => _applyFlip(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: _currentFlip == text ? Colors.blue : Colors.grey,
      ),
      child: Text(text),
    );
  }
}
