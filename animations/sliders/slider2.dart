import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: SimpleSidebar()));

class SimpleSidebar extends StatefulWidget {
  @override
  _SimpleSidebarState createState() => _SimpleSidebarState();
}

class _SimpleSidebarState extends State<SimpleSidebar> {
  double _sidebarPosition = -250; // Start off-screen
  
  void _toggleSidebar() {
    setState(() {
      _sidebarPosition = _sidebarPosition == -250 ? 0 : -250;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // SIDEBAR
          AnimatedPositioned(
            duration: Duration(milliseconds: 400),
            left: _sidebarPosition,
            top: 0,
            bottom: 0,
            width: 250,
            child: Container(
              color: Colors.blue[800],
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {},
                    child: Text('Item 1', style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Item 2', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          
          // MAIN CONTENT
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            margin: EdgeInsets.only(left: _sidebarPosition == 0 ? 250 : 0),
            color: Colors.grey[200],
            child: Column(
              children: [
                AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: _toggleSidebar,
                  ),
                  title: Text('My App'),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          color: Colors.blue,
                          child: Center(
                            child: Icon(Icons.image, size: 80, color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text('Main Content'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
