import 'package:wa_chat/widget/loading.dart';
import 'package:flutter/material.dart';
import '../widget/chat_contact.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final bool isLoading = false;
  late SharedPreferences prefs;
  late String currentUserId;
  final List<Object>  data = [
     {
        'id': 1,
        'name': 'Harry Potter',
        'imageUrl': 'https://static.independent.co.uk/s3fs-public/thumbnails/image/2016/09/29/15/hp.jpg?width=982&height=726',
        'lastMessage': 'Last message ',
        'lastMessageTime': '08:27'
    },
    {
        'id': 2,
        'name': 'Harry Potter',
        'imageUrl': 'https://static.independent.co.uk/s3fs-public/thumbnails/image/2016/09/29/15/hp.jpg?width=982&height=726',
        'lastMessage': 'Last message ',
        'lastMessageTime': '08:27'
    },
    {
        'id': 3,
        'name': 'Harry Potter',
        'imageUrl': 'https://static.independent.co.uk/s3fs-public/thumbnails/image/2016/09/29/15/hp.jpg?width=982&height=726',
        'lastMessage': 'Last message ',
        'lastMessageTime': '08:27'
    },
    {
        'id': 4,
        'name': 'Harry Potter',
        'imageUrl': 'https://static.independent.co.uk/s3fs-public/thumbnails/image/2016/09/29/15/hp.jpg?width=982&height=726',
        'lastMessage': 'Last message ',
        'lastMessageTime': '08:27'
    },
    {
        'id': 5,
        'name': 'Harry Potter',
        'imageUrl': 'https://static.independent.co.uk/s3fs-public/thumbnails/image/2016/09/29/15/hp.jpg?width=982&height=726',
        'lastMessage': 'Last message ',
        'lastMessageTime': '08:27'
    },
    
  ];

  @override
  void initState() {
    
    print("I am init of chatsscreen");
    getUser();
    
   
    super.initState();
  }
  getUser() async{
    prefs = await SharedPreferences.getInstance();
    
    
    setState(() {
      currentUserId = prefs.getString('id') ?? '';
    });
  }
  @override
  void didChangeDependencies(){
    print("I am didChangeDependencies");
    print(data[0]);
    
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    print("I am deactivate");
    super.deactivate();
  }

  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // List
        Container(
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('users').doc(currentUserId).collection('chatContacts').snapshots(),
                
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  ),
                );
              } else {
                return ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemBuilder: (context, index) =>
                      ChatContact(
                      contactInfo: snapshot.data!.docs[index]),
                  itemCount: snapshot.data!.docs.length,
                );
              }
            },
          ),
        ),

        // Loading
        Positioned(
          child: isLoading ? const Loading() : Container(),
        )
      ],
    );
  }
}