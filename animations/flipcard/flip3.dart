import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: CardFlipDemo()));

class CardFlipDemo extends StatefulWidget {
  @override
  _CardFlipDemoState createState() => _CardFlipDemoState();
}

class _CardFlipDemoState extends State<CardFlipDemo> 
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  bool _isFlipped = false;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
  }
  
  void _flipCard() {
    if (_isFlipped) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    _isFlipped = !_isFlipped;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: _flipCard,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              // 3D rotation around Y axis
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // Perspective
                  ..rotateY(_controller.value * 3.14), // 180° rotation
                alignment: Alignment.center,
                child: _controller.value < 0.5
                    ? _buildFront()  // Show front during first half
                    : _buildBack(),   // Show back during second half
              );
            },
          ),
        ),
      ),
    );
  }
  
  Widget _buildFront() {
    return Container(
      width: 250,
      height: 350,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.card_giftcard, size: 80, color: Colors.white),
          SizedBox(height: 20),
          Text(
            'FRONT SIDE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Tap to flip',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBack() {
    return Transform(
      transform: Matrix4.identity()..rotateY(3.14), // Flip text orientation
      alignment: Alignment.center,
      child: Container(
        width: 250,
        height: 350,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info, size: 80, color: Colors.white),
            SizedBox(height: 20),
            Text(
              'BACK SIDE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'This is the back of the card with more information',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
