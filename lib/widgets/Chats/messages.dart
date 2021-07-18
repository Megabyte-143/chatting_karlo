import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  //const Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(chatSnapshot.data==null){

          }

          final chatDocs = chatSnapshot.data!.docs;
          return ListView.builder(
            reverse: true,
            itemBuilder: (ctx, index) {
              return MessageBubble(
                chatDocs[index]['text'],
                chatDocs[index]['userName'],
                chatDocs[index]['image_url'],
                FirebaseAuth.instance.currentUser!.uid ==
                    chatDocs[index]['userId'],
              );
            },
            itemCount: chatDocs.length,
          );
        },
      ),
    );
  }
}
