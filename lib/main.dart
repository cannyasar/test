import 'package:flutter/material.dart';
import 'formspage/formspage.dart'; // Added the FormsPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions(BuildContext context) => <Widget>[
    Center(
      child: Text('Gelen', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    ),
    FormsPage(), // Using the FormsPage widget directly here
    Center(
      child: Text('Taslaklar', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    ),
    Center(
      child: Text('Bekleyenler', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    ),
  ];

  static List<String> _appBarTitles = [
    'Gelen', // Title for index 0
    'Formlar', // Title for index 1
    'Taslaklar', // Title for index 2
    'Bekleyenler', // Title for index 3
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]), // Get the title of the selected page
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menü',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Ayarlar'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to the Settings page
              },
            ),
            ListTile(
              title: Text('Yardım'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to the Help page
              },
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return _widgetOptions(context)[_selectedIndex];
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check, color: _selectedIndex == 0 ? Colors.blue : Colors.grey),
            label: 'Gelen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description, color: _selectedIndex == 1 ? Colors.blue : Colors.grey),
            label: 'Formlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in, color: _selectedIndex == 2 ? Colors.blue : Colors.grey),
            label: 'Taslaklar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail, color: _selectedIndex == 3 ? Colors.blue : Colors.grey),
            label: 'Bekleyenler',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
