import 'package:famibo/pr%C3%A4sentation/widgets/calculator.dart';
import 'package:famibo/pr%C3%A4sentation/Onboarding/pages/login_page.dart';
import 'package:famibo/pr%C3%A4sentation/widgets/mycaledar.dart';
import 'package:famibo/pr%C3%A4sentation/app/home_screen_page.dart';
import 'package:flutter/material.dart';

class ButtonNavigation extends StatefulWidget {
  const ButtonNavigation({super.key});

  @override
  State<ButtonNavigation> createState() => _ChangePagesState();
}

class _ChangePagesState extends State<ButtonNavigation> {
  final List<Widget> _pages = [
   LogInPage(),
    const HomeScreen(),
    const Calculator(),
    MyCaledar(),
   
  ];

  int _selectedIndex = 1;

  void _navigateBottomBar(int index) {
    if (index == 0) {
      Navigator.popUntil(context, ModalRoute.withName('/loginpage'));
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
              Icons.calendar_today,
            ),
            label: "Caledar",
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
      ),
      body: _pages[_selectedIndex],
    );
  }
}
