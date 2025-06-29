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

  String getGreetings() {
    final hour = DateTime.now().hour;
    if (hour >= 4 && hour < 12) return "Good Morning!";
    if (hour >= 12 && hour < 17) return "Good Afternoon!";
    if (hour >= 17 && hour < 21) return "Good Evening!";
    if (hour >= 21 && hour <= 23) return "Good Night!";
    return "Hello!";
  }

  final List<String> suggestions = [
    'Check my internet connectivity',
    'Check proxy',
    'Check system health',
    'Check active printers',
    'Check active tickets',
    'Create a ticket',
    'Clear browser caches',
  ];

  @override
  Widget build(BuildContext context) {
    final greeting = getGreetings();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom -
                        140,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        greeting,
                        style: const TextStyle(fontSize: 35, color: fontColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "What can I help you with today?",
                        style: TextStyle(
                          fontSize: 30,
                          color: fontColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        alignment: WrapAlignment.center,
                        children: suggestions.map((suggestion) {
                          return ActionChip(
                            label: Text(
                              suggestion,
                              style: const TextStyle(color: fontColor),
                            ),
                            backgroundColor: chipColor,
                            onPressed: () {
                              setState(() {
                                _textEditingController.text = suggestion;
                              });
                            },
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: ChatInputBar(
                textController: _textEditingController,
                onSend: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
