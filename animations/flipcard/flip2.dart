import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: AnimatedFlipDemo()));

class AnimatedFlipDemo extends StatefulWidget {
  @override
  _AnimatedFlipDemoState createState() => _AnimatedFlipDemoState();
}

class _AnimatedFlipDemoState extends State<AnimatedFlipDemo> {
  bool _isFlipped = false;
  
  void _flipBox() {
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated flip using Matrix4
            GestureDetector(
              onTap: _flipBox,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: 200,
                height: 200,
                transform: Matrix4.identity()
                  ..scale(_isFlipped ? -1.0 : 1.0, 1.0), // Flip X
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: Center(
                    child: Text(
                      _isFlipped ? 'BACK' : 'FRONT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: _flipBox,
              child: Text(_isFlipped ? 'Flip to Front' : 'Flip to Back'),
            ),
          ],
        ),
      ),
    );
  }
}
