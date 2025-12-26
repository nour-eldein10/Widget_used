import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: FixedSidebarDemo()));

class FixedSidebarDemo extends StatefulWidget {
  @override
  _FixedSidebarDemoState createState() => _FixedSidebarDemoState();
}

class _FixedSidebarDemoState extends State<FixedSidebarDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isSidebarOpen = false;

  @override
  void initState() {
    super.initState();

    // Initialize controller with initial value
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
      value: 0.0, // Start at 0 (closed)
    );
  }

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
      if (_isSidebarOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  // Don't reset controller on dispose
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Stack(
        children: [
          // SIDEBAR (1/3 of screen width)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                left: -250 + (_controller.value * 250), // Animated position
                top: 0,
                bottom: 0,
                width: 250,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 10,
                        offset: Offset(5, 0),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 60),
                        Text(
                          'MENU',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30),
                        _buildMenuItem(Icons.home, 'Home'),
                        _buildMenuItem(Icons.settings, 'Settings'),
                        _buildMenuItem(Icons.person, 'Profile'),
                        _buildMenuItem(Icons.help, 'Help'),
                        _buildMenuItem(Icons.logout, 'Logout'),
                        Spacer(),
                        ElevatedButton(
                          onPressed: _toggleSidebar,
                          child: Text('Close Menu'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // MAIN CONTENT (shifts when sidebar opens)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_controller.value * 250, 0),
                child: Transform.scale(
                  scale: 1.0 - (_controller.value * 0.1),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius:
                          BorderRadius.circular(_controller.value * 20),
                    ),
                    child: Column(
                      children: [
                        // App Bar
                        Container(
                          height: 60,
                          color: Colors.blue,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: _toggleSidebar,
                                icon: Icon(
                                  _isSidebarOpen ? Icons.close : Icons.menu,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'My App',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Main Content
                        Expanded(
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                print('Main content tapped');
                                // Tapping main content should NOT close sidebar
                                // Only menu button should control sidebar
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 10,
                                          offset: Offset(5, 5),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.image,
                                        size: 80,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Main Content Area',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Sidebar is ${_isSidebarOpen ? 'OPEN' : 'CLOSED'}',
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  // Test button - should NOT affect sidebar
                                  ElevatedButton(
                                    onPressed: () {
                                      print(
                                          'Button pressed - sidebar state: $_isSidebarOpen');
                                    },
                                    child: Text('Test Button'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(text, style: TextStyle(color: Colors.white)),
      onTap: () {
        print('Clicked: $text');
        // Menu items can close sidebar if needed
        // _toggleSidebar(); // Uncomment if you want menu items to close sidebar
      },
    );
  }
}
