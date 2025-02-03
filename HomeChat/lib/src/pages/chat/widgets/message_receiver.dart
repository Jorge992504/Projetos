import 'package:flutter/material.dart';

class MessageReceiver extends StatelessWidget {
  final String message;
  const MessageReceiver({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                // overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: null,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 14,
        ),
      ],
    );
  }
}
