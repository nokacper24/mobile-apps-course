import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No messages found.'));
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong.'));
        } else {
          final loadedMessages = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
            reverse: true,
            itemCount: loadedMessages.length,
            itemBuilder: (context, index) {
              final message = loadedMessages[index].data();
              final nextMessage = index + 1 < loadedMessages.length
                  ? loadedMessages[index + 1].data()
                  : null;

              bool isFirstMessage = false;
              final userId = message['userId'];
              final nextUserId =
                  nextMessage != null ? nextMessage['userId'] : null;
              if (userId != nextUserId) {
                isFirstMessage = true;
              }
              var isItMe = userId == FirebaseAuth.instance.currentUser!.uid;
              return isFirstMessage
                  ? MessageBubble.first(
                      userImage: message['userImage'],
                      username: message['username'],
                      message: message['text'],
                      isMe: isItMe)
                  : MessageBubble.next(
                      message: message['text'],
                      isMe: isItMe,
                    );
            },
          );
        }
      },
    );
  }
}
