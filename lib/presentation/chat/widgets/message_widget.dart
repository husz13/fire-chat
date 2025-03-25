import 'package:fire_chat/models/message.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key, required this.message, required this.isMe});
  final bool isMe;
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(message.sender),
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isMe ? Colors.lightBlue : Colors.grey,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
                topRight: isMe ? Radius.zero : Radius.circular(50),
                topLeft: !isMe ? Radius.zero : Radius.circular(50)),
          ),
          child: Text(message.message),
        ),
      ],
    );
  }
}
