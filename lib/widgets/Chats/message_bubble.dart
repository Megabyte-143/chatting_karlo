import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  //const MessageBubble({Key? key}) : super(key: key);

  final String message;
  final String userName;
  final String userImage;
  final bool isMe;
  MessageBubble(
    this.message,
    this.userName,
    this.userImage,
    this.isMe,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
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
                vertical: 8,
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
        ),
        Positioned(
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
          left: isMe ? 0 : -110,
          right: isMe ? -110 : 0,
          top: -5,
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
