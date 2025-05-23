import 'package:flutter/material.dart';

class MessageSender extends StatelessWidget {
  final String message;
  const MessageSender({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
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
