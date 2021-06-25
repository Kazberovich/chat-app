import 'package:flutter/material.dart';

class MessageBubbleWidget extends StatelessWidget {
  final String message;
  final bool isMe;

  MessageBubbleWidget(this.message, this.isMe);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12))
                : BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    topRight: Radius.circular(12)),
            color: isMe ? Theme.of(context).accentColor : Colors.grey[300],
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(
            message,
            style: TextStyle(
              color:
                  isMe ? Theme.of(context).primaryColorDark : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
