import 'package:flutter/material.dart';
import 'package:it_agent/utils/colors.dart';
import 'package:it_agent/widgets/chat_input_bar.dart';
import 'package:it_agent/services/api_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  Future<void> _checkConnection() async {
    final connected = await ApiService.checkServerConnection();
    setState(() {
      _isConnected = connected;
    });
  }

  void _sendMessage() async {
    final text = _textEditingController.text.trim();
    if (text.isEmpty || _isLoading) return;

    // Check connection before sending
    if (!_isConnected) {
      await _checkConnection();
      if (!_isConnected) {
        setState(() {
          _messages.add({
            "role": "bot", 
            "message": "Unable to connect to the server. Please check if the backend is running on localhost:5000"
          });
        });
        return;
      }
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
        _messages.add({"role": "bot", "message": "Error: ${e.toString()}"});
        _isLoading = false;
        _isConnected = false; // Mark as disconnected on error
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
            // Connection status bar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: _isConnected ? Colors.green.shade100 : Colors.red.shade100,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _isConnected ? Icons.wifi : Icons.wifi_off,
                    size: 16,
                    color: _isConnected ? Colors.green.shade700 : Colors.red.shade700,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isConnected ? 'Connected to server' : 'Server disconnected',
                    style: TextStyle(
                      fontSize: 12,
                      color: _isConnected ? Colors.green.shade700 : Colors.red.shade700,
                    ),
                  ),
                  const Spacer(),
                  if (!_isConnected)
                    TextButton(
                      onPressed: _checkConnection,
                      child: Text(
                        'Retry',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red.shade700,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: _messages.isEmpty 
                ? _buildWelcomeScreen(greeting)
                : _buildChatView(),
            ),
            if (_isLoading)
              Container(
                padding: const EdgeInsets.all(16),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "AI is thinking...",
                      style: TextStyle(color: fontColor),
                    ),
                  ],
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

  Widget _buildWelcomeScreen(String greeting) {
    return SingleChildScrollView(
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
    );
  }

  Widget _buildChatView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        final isUser = message['role'] == 'user';
        
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: isUser 
              ? MainAxisAlignment.end 
              : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isUser) ...[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.smart_toy,
                    color: Colors.blue.shade700,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.blue.shade600 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    message['message'] ?? '',
                    style: TextStyle(
                      color: isUser ? Colors.white : Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              if (isUser) ...[
                const SizedBox(width: 12),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade600,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
