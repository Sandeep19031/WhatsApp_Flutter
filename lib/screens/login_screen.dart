import 'package:wa_chat/navigation/MyHomePage.dart';
import 'package:wa_chat/widget/loading.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late SharedPreferences prefs;

  bool isLoading = false;
  bool isLoggedIn = false;
  late User currentUser;

  @override
  void initState() {
    super.initState();
    
    isSignedIn();
  }

  void isSignedIn() async {
    this.setState(() {
      isLoading = true;
    });

    prefs = await SharedPreferences.getInstance();

    isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MyHomePage(currentUserId: prefs.getString('id') as String)
                ),
      );
    }

    this.setState(() {
      isLoading = false;
    });
  }
  Future<Null> handleSignIn() async {
    prefs = await SharedPreferences.getInstance();

    this.setState(() {
      isLoading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    User? firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;

    if (firebaseUser != null) {
      // Check is already sign up
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: firebaseUser.uid)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        // Update data to server if new user
        print("yes i am new to the wa chat");
        FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .set({
          'name': firebaseUser.displayName,
          'imageUrl': firebaseUser.photoURL,
          'id': firebaseUser.uid,
        });
        print("data uploaded to firebaseUser");
      
        currentUser = firebaseUser;
        
        await prefs.setString('id', firebaseUser.uid);
        await prefs.setString('name', firebaseUser.displayName as String);
        await prefs.setString('imageUrl', currentUser.photoURL as String);
      } else {
        

        await prefs.setString('id', documents[0]['id']);
        await prefs.setString('name', documents[0]['name']);
        await prefs.setString('imageUrl', documents[0]['imageUrl']);
      }
      
      this.setState(() {
        isLoading = false;
      });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MyHomePage(currentUserId: firebaseUser.uid)));
    } else {
      
      this.setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: <Widget>[
            Center(
              child: FlatButton(
                  onPressed: handleSignIn,
                  child: Text(
                    'SIGN IN WITH GOOGLE',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  color: Color(0xffdd4b39),
                  highlightColor: Color(0xffff7f7f),
                  splashColor: Colors.transparent,
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0)),
            ),

            // Loading
            Positioned(
              child: isLoading ? const Loading() : Container(),
            ),
          ],
        )
    );
  }
}