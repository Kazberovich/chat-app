
import 'package:flutter/material.dart';

class MessageBubbleWidget extends StatelessWidget {
  final String message;
  final bool isMe;
  final Key key;
  final String username;

  MessageBubbleWidget(this.message, this.isMe, {this.key, this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    topRight: Radius.circular(12))
                : BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12)),
            color: isMe ? Theme.of(context).accentColor : Colors.blueGrey[100],
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                "${username}: ",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: isMe
                      ? Theme.of(context).primaryColorDark
                      : Colors.blueGrey,
                ),
              ),
              Text(
                message,
                //textAlign: isMe? TextAlign.end : TextAlign.start,
                style: TextStyle(
                  color: isMe
                      ? Theme.of(context).primaryColorDark
                      : Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
