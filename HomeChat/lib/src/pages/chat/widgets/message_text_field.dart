import 'package:flutter/material.dart';

class MessageTextField extends StatelessWidget {
  final TextEditingController messageEC;
  final VoidCallback onPressed;
  const MessageTextField({
    super.key,
    required this.messageEC,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 234, 234, 234),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 5,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageEC,
              maxLines: 1,
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
