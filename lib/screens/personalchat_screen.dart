import 'package:wa_chat/widget/bottom_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wa_chat/widget/user_status.dart';
import 'dart:convert' as convert;

import '../widget/send_message.dart';

import '../widget/recived_message.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


class PersonalChatScreen extends StatefulWidget {
  final String peerUserId;
  final String peerUserName;
  final String peerImageUrl;
  final String peerFcmToken;
  PersonalChatScreen({required this.peerUserId, required this.peerUserName, required this.peerImageUrl, required this.peerFcmToken});
 
  @override
  _PersonalChatScreenState createState() => _PersonalChatScreenState(peerUserId: peerUserId, peerUserName: peerUserName, peerImageUrl: peerImageUrl, peerFcmToken: peerFcmToken);
}

class _PersonalChatScreenState extends State<PersonalChatScreen> {
  final String peerUserId;
  final String peerUserName;
  final String peerImageUrl;
  
  final String peerFcmToken;
  _PersonalChatScreenState({required this.peerUserId, required this.peerUserName, required this.peerImageUrl, required this.peerFcmToken});
  final List<Map<String,Object>> _messages = [
    {'id': '12345', 'message': 'Hy', 'type': 'received'},
    {'id': '12346', 'message': 'Hello', 'type': 'send'},
    {'id': '12347', 'message': 'How are you', 'type': 'send'},
    {'id': '12348', 'message': 'I am fine', 'type': 'received'},
  ];
  late DocumentSnapshot peerInfo;
  
  late SharedPreferences prefs;
  late String chatRoomId;
  late String currentUserId;
  late String currentUserName;
  late DocumentSnapshot lastMsgSnapshot;
  List<QueryDocumentSnapshot> listMessage = new List.from([]);
  final ScrollController listScrollController = ScrollController();
  @override
  void initState() {
    super.initState();
 
    makeChatRoomId();
    
  }
 
  void makeChatRoomId() async {
    prefs = await SharedPreferences.getInstance();
    currentUserId = prefs.getString('id') ?? '';
    currentUserName = prefs.getString('name') as String;
    if (currentUserId.hashCode <= peerUserId.hashCode) {
      setState(() {
             chatRoomId = '$currentUserId-$peerUserId';
      });
      
    } else {
      setState(() {
           chatRoomId = '$peerUserId-$currentUserId';
      });
      
     
    }
  }

  void onSendMessage(String content, String type) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      
     
      var documentReference = FirebaseFirestore.instance
          .collection('user-messages')
          .doc(chatRoomId)
          .collection('messages')
          .doc();

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'idFrom': currentUserId,
            'idTo': peerUserId,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      });
     
      listScrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut );
    } else {
      
    }
  }

 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
    appBar: AppBar(
      leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          InkWell(
              onTap: () { Navigator.pop(context);},
              splashColor: Colors.grey,
              borderRadius: BorderRadius.circular(30),
              child: Icon(
              Icons.arrow_back
            ),
          ),
          CircleAvatar(
          backgroundImage: NetworkImage(peerImageUrl),
          radius: 20
        ),
      ]
      ),
      leadingWidth: 80,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(peerUserName, style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400
          )),
          // Text(
          //   'online',
          //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          // )
          UserStatus(chatRoomId: chatRoomId, peerUserId: peerUserId)
         ]
        ),
      
      actions: [
        IconButton(
          icon: Icon(
            Icons.add_call
          ),
          onPressed: () {
            showModalBottomSheet(context: context, 
            builder: (context) {
              return Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                  ),
                 ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text('Select call type', 
                      
                        style: TextStyle(
                          color: HexColor("#128C7E"),
                          fontFamily: 'HelveticaNeue Light',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.phone),
                          color: HexColor("#128C7E"),
                          onPressed: () {}
                        ),
                        SizedBox(width: 20),
                        Text('Voice call', 
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue Light',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),)
                      ]
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: _sendRequest,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.videocam),
                            color: HexColor("#128C7E"),
                            onPressed: _sendRequest
                          ),
                          SizedBox(width:20),
                          Text('Video call',
                            style: TextStyle(
                              fontFamily: 'HelveticaNeue Light',
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            )
                          )
                        ]
                      ),
                    )
                    
                  ],),
              );
            });
          },
        ),
        IconButton(
          icon:  Icon(Icons.more_vert),
          onPressed: () {}
        )
      ],
      backgroundColor: HexColor("#075E54"),

    ),      
    body: Container(
        constraints: BoxConstraints.expand(),        
        decoration: BoxDecoration(
            image: DecorationImage(
             image:  NetworkImage('https://user-images.githubusercontent.com/15075759/28719144-86dc0f70-73b1-11e7-911d-60d70fcded21.png'),
             fit: BoxFit.cover)
        ),
        child:  StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('user-messages')
                .doc(chatRoomId)
                .collection('messages')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)));
              } else {
                
                listMessage.addAll( (snapshot.data! as QuerySnapshot).docs);               
                
                return ListView.builder(                
                  padding: EdgeInsets.only(top: 10, bottom: 80),
                  itemBuilder: (context, index) {                  
                    
                    if((snapshot.data! as QuerySnapshot).docs[index]['idFrom'] == currentUserId){ 
                        
                        if(index == (snapshot.data! as QuerySnapshot).docs.length - 1){
                          return SendMessage(
                        msg: (snapshot.data! as QuerySnapshot).docs[index]['content'],
                        timestamp: (snapshot.data! as QuerySnapshot).docs[index]['timestamp'],
                        lastMsgByMe: false);

                        }
                        else if((snapshot.data! as QuerySnapshot).docs[index+1]['idFrom'] == currentUserId){
                          
                        return SendMessage(
                          msg: (snapshot.data! as QuerySnapshot).docs[index]['content'],
                          timestamp: (snapshot.data! as QuerySnapshot).docs[index]['timestamp'],
                          lastMsgByMe: true);
                        }

                      
                      
                      
                      return SendMessage(
                        msg: (snapshot.data! as QuerySnapshot).docs[index]['content'],
                        timestamp: (snapshot.data! as QuerySnapshot).docs[index]['timestamp'],
                        lastMsgByMe: false);
                    }
                    else{
                      if(index == (snapshot.data! as QuerySnapshot).docs.length - 1){
                        return ReceivedMessage(
                        msg: (snapshot.data! as QuerySnapshot).docs[index]['content'],
                        timestamp: (snapshot.data! as QuerySnapshot).docs[index]['timestamp'],
                        lastMsgByMe: false
                       );                     
                      }
                      else if((snapshot.data! as QuerySnapshot).docs[index+1]['idFrom'] == peerUserId){
                        return ReceivedMessage(
                        msg: (snapshot.data! as QuerySnapshot).docs[index]['content'],
                        timestamp: (snapshot.data! as QuerySnapshot).docs[index]['timestamp'],
                        lastMsgByMe: true
                      );
                      }
                      return ReceivedMessage(
                        msg: (snapshot.data! as QuerySnapshot).docs[index]['content'],
                        timestamp: (snapshot.data! as QuerySnapshot).docs[index]['timestamp'],
                        lastMsgByMe: false
                      );

                    }
                    
                    
                  },
                  itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                  reverse: true,
                  controller: listScrollController,
                );
              }
            },
          ),
    ),

    bottomSheet:  BottomInput(onSendMessage: onSendMessage, chatRoomId: chatRoomId, currentUserId: currentUserId),
      
      );
  }

  Future<void> _sendRequest() async {
    
    QuerySnapshot request = await FirebaseFirestore.instance.collection('users-communication').doc(chatRoomId).collection('Request').get();
    
    if(request.docs.length > 10) {
      print("user is busy on another call");
    }else {
        await FirebaseFirestore.instance.collection('users-communication').doc(chatRoomId).collection('Request').add({
          'callerId': currentUserId,
          'receiverId': peerUserId,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          'type': 'video-call',
        });
          await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=AAAANkxjjhU:APA91bGe6aPslcypLE6foqXGoSIIavsKoa6Ken7-LnNQZ8zWS8iNuJAeE9RFOvNjFGLs91jygdJ8QJCSJA7JMz69m3EnKf5uriLkIe0BmqrYiVW0XijtGzICPVxI4eZKVJn4fGmkrYLT',
      },
      body: convert.jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': '$currentUserName is calling you...',
          'title': 'WhatsApp video call',          
          },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              'channelName': chatRoomId
            },    
            'to': peerFcmToken,       
        },
        ),
      );
  
      // await Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => VideoCallScreen(
      //       channelName: chatRoomId.toString(),
      //       currentUserId: currentUserId, 
      //       peerUserId: peerUserId,
      //       peerImageUrl: peerImageUrl
      //     )
      //   )
      // );
      }
    
    }
}