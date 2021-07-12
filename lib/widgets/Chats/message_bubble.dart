import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  //const MessageBubble({Key? key}) : super(key: key);

  final String message;
  MessageBubble(this.message);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).accentColor,
          ),
          width: 150,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(message,style: TextStyle(color: Theme.of(context).accentTextTheme.headline6!.color),),
        ),
      ],
    );
  }
}
