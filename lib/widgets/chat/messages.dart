import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore_app/widgets/chat/message_bubble.dart';

class MessagesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final chatDocs = chatSnapshot.data.docs;

        return ListView.builder(
            itemCount: chatDocs.length,
            reverse: true,
            itemBuilder: (ctx, index) {
              //return Text(chatDocs[index].toString());
              print(chatDocs[index].toString());
              return MessageBubbleWidget(
                chatDocs[index]['text'],
                chatDocs[index]['userId'] ==
                        FirebaseAuth.instance.currentUser.uid
                    ? true
                    : false,
                key: ValueKey(chatDocs[index].id),
                username: chatDocs[index]['username'],
                imageUrl: chatDocs[index]['userImage'],
              );
            });
      },
    );
  }
}
