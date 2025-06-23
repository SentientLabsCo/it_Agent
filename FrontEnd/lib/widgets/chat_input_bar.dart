import 'package:flutter/material.dart';

class ChatInputBar extends StatefulWidget {
  final TextEditingController textController;
  final VoidCallback onSend;

  const ChatInputBar({
    super.key,
    required this.textController,
    required this.onSend,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {

  static const dropDownItem = ['Quick Response', 'Detailed'];
  String selectedValue = dropDownItem[0];

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
                    hintText: "Message Copilot",
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) => widget.onSend(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {}, // Can later open attachments
              ),
              IconButton(
                icon: const Icon(Icons.mic, color: Colors.white),
                onPressed: () {}, // Voice input
              ),
            ]
          ),
          const SizedBox(height: 8),
          //Dropdown for Response Type
          DropdownButton<String>(
            dropdownColor: const Color(0xFF1A1A2E),
            value: selectedValue,
            items: dropDownItem.map((item){
              return DropdownMenuItem(
                value: item,
                child: Text(item, style: const TextStyle(color: Colors.white)),

              );
            }).toList(),
            onChanged: (value){
              if (value != null){
                setState((){
                  selectedValue = value;
                });
              }
            },
            underline: const SizedBox(),
            iconEnabledColor: Colors.white,
          )
        ],
      ),
    );
  }
}

