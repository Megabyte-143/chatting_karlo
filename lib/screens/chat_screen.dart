import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatting Karlo"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
              items: [
                DropdownMenuItem(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(
                          Icons.exit_to_app,
                          color: Theme.of(context).copyWith().primaryColor,
                        ),
                        //SizedBox(width: 40,),
                        Text("Logout"),
                      ],
                    ),
                  ),
                  value: 'logout',
                ),
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.yellow,
              ),
            ),
          )
        ],
      ),
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
