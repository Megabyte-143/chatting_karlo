import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('chats/JJJ1icBKXTftuip3wpb6/messages')
              .snapshots(),
          builder: (ctx, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = streamSnapshot.data!.docs;
            return ListView.builder(
              itemBuilder: (ctx, index) => Container(
                child: Text(documents[index]['text']),
                padding: EdgeInsets.all(10),
              ),
              itemCount: documents.length,
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/JJJ1icBKXTftuip3wpb6/messages')
              .add({'text': "Added by clicking button"}); 
        },
      ),
    );
  }
}
