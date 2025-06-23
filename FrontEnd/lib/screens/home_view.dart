import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});


  @override
  Widget build(BuildContext context) {
    final greeting = getGreetings();

    final List<String> suggestions = [
      'Check my internet connectivity',
      'check proxy',
      'check System health',
      'check active printers',
      'check active tickets'
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      color: const Color(0xFF101020),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greeting,
            style: const TextStyle(fontSize: 24, color: Colors.white70),
          ),
          const SizedBox(height: 8),

        ],
      ),
    );
  }

  String getGreetings() {
    final hour = DateTime.now().hour;

    if(hour >= 4 && hour < 12){
      return "Good Morning!";
    }else if(hour >= 12 && hour < 17){
      return "Good Afternoon!";
    }else if(hour >= 17 && hour < 21){
      return "Good Evening!";
    }else if(hour >= 21 && hour <= 23){
      return "Good Night!";
    }else{
      return "Hello!";
    }
  }
}
