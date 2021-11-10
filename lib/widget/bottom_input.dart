import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BottomInput extends StatefulWidget {
  final Function onSendMessage;
  final String chatRoomId;
  final String currentUserId;
  BottomInput({Key? key,required  this.onSendMessage,required this.chatRoomId,required this.currentUserId}) : super(key: key);

  @override
  _BottomInputState createState() => _BottomInputState(onSendMessage: onSendMessage, chatRoomId: chatRoomId, currentUserId: currentUserId);
}

class _BottomInputState extends State<BottomInput> {
   final Function onSendMessage;
   final String chatRoomId;
   final String currentUserId;
  _BottomInputState({required this.onSendMessage, required this.chatRoomId, required this.currentUserId});
  late TextEditingController _controller; 

  void initState() {
    super.initState();
    _controller = TextEditingController();
 
  }
  bool isTyping = false;
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: 350,
          
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(49),              
            ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.emoji_emotions_outlined),
                color: Colors.grey[600],
                iconSize: 26,
                onPressed: () {}
              ),
              Expanded(
                  child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type a message'
                  ),
                  onChanged: (text) {
                    if(text.trim() != '') {
                       //update firebase database
                       FirebaseFirestore.instance.collection('user-messages').doc(chatRoomId).set({
                          currentUserId: true
                       });
                       return setState(() {
                      isTyping = true;
                      });
                    }else{
                      FirebaseFirestore.instance.collection('user-messages').doc(chatRoomId).set({
                          currentUserId: false
                       });
                      return setState(() {
                      isTyping = false;
                      });
                    }
                  },
                  onSubmitted: (String value) { },
                ),
              ),
              Container(
                
                child: IconButton(
                  icon: Icon(Icons.attach_file),
                  color: Colors.grey[600],
                  iconSize: 26,
                  onPressed: () {}
                ),
              ),
              if(!isTyping)
              IconButton(
                icon:  Icon(Icons.camera_alt),   
                color: Colors.grey[600],
                iconSize: 26,           
                onPressed: () {}
              ),
            ],
          ),
        ),
      if(!isTyping)
      CircleAvatar(
        backgroundColor: HexColor("#075E54"),
        radius: 22,
        child: IconButton(
          icon:Icon(Icons.mic),
          color: Colors.white,
          onPressed: () {}
        ),
      ),  
      if(isTyping)
      CircleAvatar(
        backgroundColor: HexColor("#075E54"),
        radius: 22,
        child: Center(
          child: IconButton(
            icon: Icon(Icons.send),
            color: Colors.white,
            onPressed: () {
              onSendMessage(_controller.text, 'text');
              _controller.clear();
              FirebaseFirestore.instance.collection('user-messages').doc(chatRoomId).set({
                          currentUserId: false
                       });
              setState(() {
                isTyping = false;
              });
            },
          ),
        )
      )
      
      ]
      );
  }
}