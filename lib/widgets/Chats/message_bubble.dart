import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  //const MessageBubble({Key? key}) : super(key: key);

  final String message;
  final String userName;
  final bool isMe;
  MessageBubble(
    this.message,
    this.userName,
    this.isMe,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(0),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(0),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
            color: isMe ? Colors.grey : Theme.of(context).accentColor,
          ),
          width: 150,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 0,
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isMe
                      ? Colors.black
                      : Theme.of(context).accentTextTheme.headline6!.color,
                ),
              ),
              Text(
                message,
                style: TextStyle(
                  color: isMe
                      ? Colors.black
                      : Theme.of(context).accentTextTheme.headline6!.color,
                ),
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
