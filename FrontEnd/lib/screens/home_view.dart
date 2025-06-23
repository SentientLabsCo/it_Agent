import 'package:flutter/material.dart';
import 'package:it_agent/utils/colors.dart';
import 'package:it_agent/widgets/chat_input_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage() {
    final text = _textEditingController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "message": text});
      _messages.add({"role": "bot", "message": "You said: $text"});
    });

    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final greeting = getGreetings();

    final List<String> suggestions = [
      'Check my internet connectivity',
      'check proxy',
      'check System health',
      'check active printers',
      'check active tickets',
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          const Spacer(),
          Expanded(
            flex: 2,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  greeting,
                  style: const TextStyle(fontSize: 35, color: Colors.white70),
                ),
                const SizedBox(height: 8),
                const Text(
                  "What can i help you with today?",
                  style: TextStyle(
                    fontSize: 30,
                    color: fontColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),

                //Suggestion Chips
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: suggestions
                      .map(
                        (suggestion) => ActionChip(
                          label: Text(
                            suggestion,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: chipColor,
                          onPressed: () {},
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 16, 35, 40),
                    child: ChatInputBar(
                      textController: _textEditingController,
                      onSend: _sendMessage,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getGreetings() {
    final hour = DateTime.now().hour;

    if (hour >= 4 && hour < 12) {
      return "Good Morning!";
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon!";
    } else if (hour >= 17 && hour < 21) {
      return "Good Evening!";
    } else if (hour >= 21 && hour <= 23) {
      return "Good Night!";
    } else {
      return "Hello!";
    }
  }
}
