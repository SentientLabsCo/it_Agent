/*
This is a Flutter widget for the home screen of an IT support application.
It includes a greeting based on the time of day, a list of action suggestions,
and a chat input bar for user interaction.
The widget maintains a list of messages and allows users to send messages
to the bot, which responds with a simple echo of the user's input.
This file is part of the IT Agent project.
It is designed to provide a user-friendly interface for IT support interactions.
Author: [Arpit Raghuvanshi]
*/

import 'package:flutter/material.dart';
import 'package:it_agent/utils/colors.dart';
import 'package:it_agent/widgets/chat_input_bar.dart';
import 'package:it_agent/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  void _checkConnection() async {
    try {
      final connected = await ApiService.checkServerConnection();
      setState(() {
        _isConnected = connected;
      });
    } catch (e) {
      setState(() {
        _isConnected = false;
      });
    }
  }

  void _sendMessage() async {
    final text = _textEditingController.text.trim();
    if (text.isEmpty) return;

    if (!_isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No connection to server. Please check if you are connected to a network',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _messages.add({"role": "user", "message": text});
      _isLoading = true;
    });

    _textEditingController.clear();

    try {
      final response = await ApiService.sendMessage(text);
      setState(() {
        _messages.add({"role": "bot", "message": response});
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _messages.add({
          "role": "bot",
          "message": "Sorry, I encountered an error: ${e.toString()}",
        });
        _isLoading = false;
      });
    }
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
            // Connection status indicator
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: _isConnected
                  ? Colors.green.withOpacity(0.2)
                  : Colors.red.withOpacity(0.2),
              child: Row(
                children: [
                  Icon(
                    _isConnected ? Icons.cloud_done : Icons.cloud_off,
                    color: _isConnected ? Colors.green : Colors.red,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isConnected
                        ? 'Connected to AI Assistant'
                        : 'Connection Failed - Check Network',
                    style: TextStyle(
                      color: _isConnected ? Colors.green : Colors.red,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.refresh, size: 16),
                    onPressed: _checkConnection,
                    color: fontColor,
                  ),
                ],
              ),
            ),
            // Show chat messages if any exist
            if (_messages.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _messages.length && _isLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(width: 12),
                            Text(
                              "AI is thinking...",
                              style: TextStyle(color: fontColor),
                            ),
                          ],
                        ),
                      );
                    }

                    final message = _messages[index];
                    final isUser = message['role'] == 'user';

                    return Align(
                      alignment: isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.blue : const Color(0xFF1A1A2E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        child: Text(
                          message['message'] ?? '',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              // Show welcome screen when no messages
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
                          style: const TextStyle(
                            fontSize: 35,
                            color: fontColor,
                          ),
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
                isLoading: _isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
