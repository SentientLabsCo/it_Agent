/*
This is a Flutter widget for the chat input bar.
It allows users to type messages, send them, and select a response type from a dropdown.
It includes a text input field, a send button, and a dropdown menu for selecting the response type.
Also working functionality for sending messages is need to be implemented.
Author: [Arpit Raghuvanshi]
*/

import 'package:flutter/material.dart';

class ChatInputBar extends StatefulWidget {
  final TextEditingController textController;
  final VoidCallback onSend;
  final bool isLoading;

  const ChatInputBar({
    super.key,
    required this.textController,
    required this.onSend,
    this.isLoading = false,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  static const dropDownItem = ['Quick Response', 'Detailed'];
  String selectedValue = dropDownItem[0];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Row for Text Input and buttons
          Row(
            children: [
              // Text Input
              Expanded(
                child: TextField(
                  controller: widget.textController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Type your command...",
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) => widget.onSend(),
                ),
              ),
              IconButton(
                icon: widget.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : const Icon(Icons.send_rounded, color: Colors.white),
                onPressed: widget.isLoading ? null : widget.onSend,
              ),
            ],
          ),
          const SizedBox(height: 8),
          //Dropdown for Response Type
          DropdownButton<String>(
            dropdownColor: const Color(0xFF1A1A2E),
            value: selectedValue,
            items: dropDownItem.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item, style: const TextStyle(color: Colors.white)),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedValue = value;
                });
              }
            },
            underline: const SizedBox(),
            iconEnabledColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
