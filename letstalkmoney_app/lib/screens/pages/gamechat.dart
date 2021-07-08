import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letstalkmoney_app/screens/pages/chats/gameschat.dart';
import 'package:letstalkmoney_app/services/auth.dart';
import 'package:letstalkmoney_app/shared/appbar.dart';
import 'package:letstalkmoney_app/shared/constants.dart';
import 'package:letstalkmoney_app/shared/drawer.dart';
import 'package:letstalkmoney_app/shared/draweranon.dart';
import 'package:letstalkmoney_app/shared/errorPost.dart';

class GameChatPage extends StatefulWidget {
  @override
  _GameChatPageState createState() => _GameChatPageState();
}

class _GameChatPageState extends State<GameChatPage> {
  final AuthService _auth = AuthService();

  String input = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  User user = FirebaseAuth.instance.currentUser!;
  String username = '';

  getAnon() {
    final User? user = auth.currentUser;
    final anon = user!.isAnonymous;
    return anon;
  }

  @override
  Widget build(BuildContext context) {
    getUserName(user.uid);

    if (!getAnon()) {
      return Scaffold(
          backgroundColor: Color(0xFFb5e1eb),
          appBar: AppBarCommon(title: Text('Games Room'), appBar: AppBar()),
          drawer: DrawerCommon(),
          body: Container(
            child: Stack(
              children: <Widget>[
                // getUserName(user.uid),
                GameList(),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                            onChanged: (value) {
                              input = value;
                            },
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Message')),
                      ),
                      SizedBox(width: 12.0),
                      GestureDetector(
                        onTap: () async {
                          if (input != '') {
                            await _auth.postGames(
                                username, input, DateTime.now().toString());
                          } else {
                            errorPost(context);
                          }
                        },
                        child: Container(
                          height: 45.0,
                          width: 45.0,
                          decoration: BoxDecoration(
                              color: Color(0xFF2a9d8f),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                              child: Icon(Icons.send, color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ));
    } else {
      return Scaffold(
          backgroundColor: Color(0xFFb5e1eb),
          appBar: AppBarCommon(title: Text('Games Room'), appBar: AppBar()),
          drawer: DrawerCommonAnon(),
          body: Container(
            child: Stack(
              children: <Widget>[
                // getUserName(user.uid),
                GameList(),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                            onChanged: (value) {
                              input = value;
                            },
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Message')),
                      ),
                      SizedBox(width: 12.0),
                      GestureDetector(
                        onTap: () async {
                          if (input != '') {
                            await _auth.postGames(
                                username, input, DateTime.now().toString());
                          } else {
                            errorPost(context);
                          }
                        },
                        child: Container(
                          height: 45.0,
                          width: 45.0,
                          decoration: BoxDecoration(
                              color: Color(0xFF2a9d8f),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                              child: Icon(Icons.send, color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ));
    }
  }

  void getUserName(documentId) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    users.doc(documentId).get().then((DocumentSnapshot documentSnapshot) {
      setState(() => username = documentSnapshot.get('Full Name'));
    });
  }
}
