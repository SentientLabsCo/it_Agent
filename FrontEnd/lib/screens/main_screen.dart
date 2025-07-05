import 'package:flutter/material.dart';
import 'package:it_agent/utils/colors.dart';
import 'package:it_agent/view_screens/home_view.dart';
import 'package:it_agent/view_screens/notification_view.dart';
import 'package:it_agent/view_screens/history_view.dart';

import '../view_screens/browse_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  final List<Widget> screens = [
    HomeView(),
    BrowseView(),
    NotificationView(),
    HistoryView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          //Sidebar Area
          Container(
            width: 220,
            color: drawerColor,
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  "IT Assistant",
                  style: TextStyle(
                    color: fontColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: backgroundColor),
                _buildMenuItem(Icons.home, "Home", 0),
                _buildMenuItem(Icons.folder_rounded, "Browse", 1),
                _buildMenuItem(Icons.notifications, "Notification", 2),
                _buildMenuItem(Icons.history_rounded, "History", 3),
              ],
            ),
          ),
          //Screen Area
          Expanded(
            child: Container(
              decoration: BoxDecoration(gradient: backgroundGradient),
              child: IndexedStack(
                index: selectedIndex,
                children: screens,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, int index){
    final isSelected = selectedIndex == index;

    return ListTile(
      hoverColor: Colors.blue,
      leading: Icon(icon, color: isSelected ? Colors.blue :fontColor,),
      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.blue : fontColor,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
        onTap: (){
        setState(() {
          selectedIndex = index;
        });
        },
    );
  }
}
