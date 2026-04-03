import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:ztv/listeners/value_listener.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: Drawer(),
      appBar: AppBar(
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i){ 
          setState(() => _currentIndex = i);
          switch(i){
            case 0:
              Navigator.pushNamed(context, "/cast");
              break;
            case 1:
              Navigator.pushNamed(context, "/profesores");
            case 3:
              ValueListener.isDarkMode.value = !ValueListener.isDarkMode.value;
              break;
          }
        },
        items: [
          SalomonBottomBarItem(
              icon: Icon(Icons.cast),
              title: Text("Cast"),
              selectedColor: Colors.purple,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: Icon(Icons.accessibility),
              title: Text("Profesores"),
              selectedColor: Colors.pink,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: Icon(Icons.search),
              title: Text("Search"),
              selectedColor: Colors.orange,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: ValueListenableBuilder(
                valueListenable: ValueListener.isDarkMode,
                builder: (context,value,_) {
                  return value ? Icon(Icons.dark_mode) : Icon(Icons.light_mode);
                }
              ),
              title: Text("Profile"),
              selectedColor: Colors.teal,
            ),
        ]
      ),  
    );
  }
}