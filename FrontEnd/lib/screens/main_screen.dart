import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:it_agent/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final List<Widget> screens = [
    const Center(child: Text("Home", style: TextStyle(fontSize: 28))),
    const Center(child: Text("Browse", style: TextStyle(fontSize: 28))),
    const Center(child: Text("Notification", style: TextStyle(fontSize: 28))),
    const Center(child: Text("History", style: TextStyle(fontSize: 28))),
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

String getGreetings() {
  final hour = DateTime.now().hour;

  switch (hour) {
    case >= 4 && < 12:
      return "Good Morning!";
    case >= 12 && < 17:
      return "Good Afternoon!";
    case >= 17 && < 21:
      return "Good Evening!";
    case >= 21 && <= 23:
      return "Good Night!";
    default:
      return "Hello!";
  }
}
