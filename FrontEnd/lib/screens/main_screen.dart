import 'package:flutter/material.dart';
import 'package:it_agent/utils/colors.dart';
import 'package:it_agent/screens/home_view.dart';
import 'package:it_agent/screens/browse_view.dart';
import 'package:it_agent/screens/notification_view.dart';
import 'package:it_agent/screens/history_view.dart';

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
            color: const Color(0xFF000322),
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  "IT Assistant",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Color.fromRGBO(7, 12, 58, 1.0)),
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
              decoration: BoxDecoration(gradient: backgoundGradient),
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
      leading: Icon(icon, color: isSelected ? Colors.blue : Colors.white,),
      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.blue : Colors.white,
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
