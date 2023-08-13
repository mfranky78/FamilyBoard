import 'package:famibo/calculator.dart';
import 'package:famibo/login_page.dart';
import 'package:famibo/setting_page.dart';
import 'package:famibo/user_name.dart';
import 'package:flutter/material.dart';




class ChangePages extends StatefulWidget {
   const ChangePages({super.key});

  @override
  State<ChangePages> createState() => _ChangePagesState();
}

class _ChangePagesState extends State<ChangePages> {
  final List<Widget> _pages = [
     const LoginPage(),
    const UserName(),
    const Calculator(),
    const FlutterCarouselWidgetDemo(),
   
    
  ];

 int _selectedIndex = 1;

  void _navigateBottomBar(int index) {
    if (index == 0) {
     Navigator.popUntil(context, ModalRoute.withName('/login'));
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.logout,
            ),
            label: "LogOut",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calculate,
            ),
            label: "Calculator",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: "Settings",
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
      ),
      body:_pages[_selectedIndex], 
    );
  }
}


