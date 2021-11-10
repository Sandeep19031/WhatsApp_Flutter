import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MicOrSend extends StatefulWidget {
  final bool isTyping;
  MicOrSend({required this.isTyping});
  @override
  _MicOrSendState createState() => _MicOrSendState(isTyping: isTyping);
}

class _MicOrSendState extends State<MicOrSend> {
  final bool isTyping;
  _MicOrSendState({required this.isTyping});
  @override
  Widget build(BuildContext context) {
    return !isTyping ? CircleAvatar(
        backgroundColor: HexColor("#075E54"),
        radius: 22,
        child: IconButton(
          icon:Icon(Icons.mic),
          color: Colors.white,
          onPressed: () {}
        ),
    ) : 
    CircleAvatar(
        backgroundColor: HexColor("#075E54"),
        radius: 22,
        child: Center(
          child: IconButton(
            icon: Icon(Icons.send),
            color: Colors.white,
            onPressed: () =>{},
          ),
        )
    );
  }
}