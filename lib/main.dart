import 'package:flutter/material.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SafeArea;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(187, 187, 30, 1),
          title: const Center(child: Text("FamilyBoard")
          ),
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Welcome", style: TextStyle(fontSize: 28, color: Colors.red),
                
                 ),
                 ElevatedButton(onPressed: () {
                  print("Gedrückt");
                 }, child: Text("Welcomebutton"))
              ],
            ),
            ),
            ),
            bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, ),
                label: "Home",
                backgroundColor:  Color.fromRGBO(187, 187, 30, 1),
                ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business, ),
                label: "Business",
                backgroundColor:  Color.fromRGBO(187, 187, 30, 1),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calculate, ),
                  label: "Calculator",
                  backgroundColor:  Color.fromRGBO(187, 187, 30, 1),
                  ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings,),
                  label: "Settings",
                  backgroundColor: Color.fromRGBO(187, 187, 30, 1),
                  
                  ),
                  
            ],
          selectedItemColor: Colors.black,
         unselectedItemColor: Colors.black,
            ),
        ),
    );
    
  
  }
}