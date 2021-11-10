import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wa_chat/screens/personalchat_screen.dart';

class ChatContact extends StatelessWidget {
  final QueryDocumentSnapshot contactInfo;

  ChatContact({required this.contactInfo});

  

  void selectChatContact(BuildContext ctx) async  {

      final result = await FirebaseFirestore.instance.collection('users').doc(contactInfo['id']).get();
      
      await Navigator.push(
                ctx,
                MaterialPageRoute(
                    builder: (ctx) => PersonalChatScreen(
                          peerUserId: contactInfo['id'],
                          peerUserName: contactInfo['name'],
                          peerImageUrl: contactInfo['imageUrl'],
                          peerFcmToken: result['fcmToken']
                        )));
    
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectChatContact(context),
      splashColor: Colors.grey,
      child: Center(
        child: Column(
            children: [ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('${contactInfo['imageUrl']}'),
              radius: 30,
            ),
            title: Text(contactInfo['name']),
            subtitle: Text('last message'),
            trailing: Text('08:20',),
          
          ),
          const Divider(           
              height: 1,
              thickness: 1,
              indent: 80,
              endIndent: 0,
            ),
        ]
        ),
      ),
    );
  }
}