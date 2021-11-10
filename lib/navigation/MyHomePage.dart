import 'package:wa_chat/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../screens/calls_screen.dart';
import '../screens/camera_screen.dart';
import '../screens/chats_screen.dart';
import '../screens/status_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

class MyHomePage extends StatefulWidget {
  late final String currentUserId;
  MyHomePage({Key? key,required this.currentUserId}) : super(key: key);

  @override
  _MyHomePage createState() => _MyHomePage(currentUserId: currentUserId);
}


class _MyHomePage extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  
  late final String currentUserId;

  _MyHomePage({required this.currentUserId});

  late TabController _controller;
  int _selectedIndex = 0;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  List<Widget> list = [
   
    Container(
      child: Tab(icon: Icon(Icons.camera_alt)),
      width: 15,
      
    ),
        
    Container(
      child: Tab(text: 'CHATS'),
      width: 60,
    ),

    Container(
      child: Tab(text: 'STATUS'),
      width: 60,
    ),

    Container(
      child: Tab(text: 'CALLS'),
      width: 60,
    )
  ];
  List<Choice> choices = const <Choice>[
    const Choice(title: 'New Group'),
    const Choice(title: 'Settings'),
    const Choice(title: 'Logout'),
  ];
  @override
  void initState() {
   
    super.initState();
    // Create TabController for getting the index of current tab
    
    _controller = TabController(length: list.length, vsync: this,initialIndex: 1);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
    setOnlineTrue();
    print("Online State true");
    //here is code firebase cloud messaging
    getPermission();
    _registerOnFirebase();
    listenCallNotification();
     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
  void setOnlineTrue() async{
      await  FirebaseFirestore.instance.collection('users').doc(currentUserId).update({
      'online': true
    });
  }
  Future<void> getPermission() async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;

      NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
  }
  Future<void> _registerOnFirebase() {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic('all');
    return messaging.getToken().then((token) async {
      print(token);
      await FirebaseFirestore.instance.collection('users').doc(currentUserId).update({
      'fcmToken': token
     });
   });
  
 }
  Future<void> listenCallNotification() async{
     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //  Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => VideoCallingPage(
           
      //     )
      //   )
      // );        
      print("listening foreground message");
      });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Got a message whilst in the resume!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }    
        
    });
  }
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
 
  print("Handling a background message: ${message.messageId}");
  
}

  
  Future<Null> handleSignOut() async {
    

    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();

    

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyApp()),
        (Route<dynamic> route) => false);
      setState(() {});
  }
  @override
  void deactivate() {
  
    setOnlineFalse();
    print("online state false");
    super.deactivate();
  }
  void setOnlineFalse() async{
  
    await  FirebaseFirestore.instance.collection('users').doc(currentUserId).update({
      'online': false
    });
  }
  void _onItemSelected(Choice choice){
    if(choice.title == 'Logout'){
      handleSignOut();
    }
  }
  @override
  Widget build(BuildContext context) {
    return 
       Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            onTap: (index) {
              // Should not used it as it only called when tab options are clicked,
              // not when user swapped
            },
            controller: _controller,
            tabs: list,
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(horizontal: 30.0),
            indicatorColor: Colors.white,
          ),
          title: Text('WhatsApp'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              color: Colors.white,
              onPressed: () {},
            ),
            
            PopupMenuButton<Choice>( 
              onSelected: _onItemSelected,               
              itemBuilder: (context) => choices.map((Choice choice) {
                    return PopupMenuItem(
                      value: choice,
                      child: Text(choice.title)
                    );
              }).toList()
            ),
          ],
          backgroundColor: HexColor("#075E54"),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            CameraScreen(),
            ChatsScreen(),
            StatusScreen(),
            CallsScreen()
          ],
        ),
      );
    
  }
}
class Choice {
  const Choice({required this.title});

  final String title;
}