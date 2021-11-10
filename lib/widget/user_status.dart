
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserStatus extends StatefulWidget {
  final String chatRoomId;
  final String peerUserId;
  UserStatus({Key? key, required this.chatRoomId, required this.peerUserId}) : super(key : key);

  @override
  _UserStatusState createState() => _UserStatusState(chatRoomId: chatRoomId, peerUserId: peerUserId);
}

class _UserStatusState extends State<UserStatus> {
  late final String chatRoomId;
  late final String peerUserId;
  _UserStatusState({ required this.chatRoomId, required this.peerUserId});
  @override
  
  Widget build(BuildContext context) {
    return Container(
       child: StreamBuilder(
         stream: FirebaseFirestore.instance
                .collection('user-messages')
                .doc(chatRoomId)
                .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            
            Map<String, dynamic> isTyping = snapshot.data!.data() as Map<String, dynamic>;
            if(isTyping[peerUserId] == true) {
              return Text('typing...');
            }
            else {
              return Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('users').doc(peerUserId).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                    Map<String, dynamic> isOnline = snapshot.data!.data() as Map<String, dynamic>;
                    if(isOnline['online'] == true) {
                      return Text('online');
                    }
                    else{
                      return Container();
                    }
                  },
                ),
              );
            }
          }
       ),
    );
  }
}