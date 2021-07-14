import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredText = '';

  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  // FutureBuilder onSelectNotification() {
  //   //  showDialog(
  //   //   context: context,
  //   //   builder: (context) {
  //   //     return new AlertDialog(
  //   //       title: Text("PayLoad"),
  //   //       content: Text("Payload : $_enteredText"),
  //   //     );
  //   //   },
  //   // );
  //   future:
  //   flutterLocalNotificationsPlugin;
  //   builder:
  //   (ctx, snapshot) {
  //     return showDialog(
  //         context: context,
  //         builder: (context) {
  //           return new AlertDialog(
  //             title: Text("PayLoad"),
  //             content: Text("Payload : $_enteredText"),
  //           );
  //         });
  //   };
  // }

  // @override
  // initState() {
  //   super.initState();
  //   // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  //   // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
  //   var initializationSettingsAndroid =
  //       new AndroidInitializationSettings('app_icon');
  //   var initializationSettingsIOS = new IOSInitializationSettings();
  //   var initializationSettings = new InitializationSettings(
  //       android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  //   flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  //   flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //       onSelectNotification: onSelectNotification);
  // }

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final userId = FirebaseAuth.instance.currentUser;
    final userName = await FirebaseFirestore.instance
        .collection('user')
        .doc(userId!.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredText,
      'createdAt': Timestamp.now(),
      'userId': userId.uid,
      'userName': userName['username'],
      'image_url': userName['image_url']
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: (InputDecoration(
                labelText: ("Send a message...."),
              )),
              onChanged: (value) {
                setState(() {
                  _enteredText = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _enteredText.trim().isEmpty
                ? null
                : () {
                    _sendMessage();
                  },
            icon: Icon(
              Icons.send,
            ),
          )
        ],
      ),
    );
  }
}
