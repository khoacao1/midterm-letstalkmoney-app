import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:letstalkmoney_app/screens/grouplist.dart';
import 'package:letstalkmoney_app/services/auth.dart';
import 'package:letstalkmoney_app/shared/appbar.dart';
import 'package:letstalkmoney_app/shared/drawer.dart';
import 'package:letstalkmoney_app/shared/draweranon.dart';

class Home extends StatelessWidget {
  // const Home({Key? key}) : super(key: key);
  // Create instant object _auth
  final AuthService _auth = AuthService();

  final FirebaseAuth authuser = FirebaseAuth.instance;

  getAnon() {
    final User? user = authuser.currentUser;
    final anon = user!.isAnonymous;
    return anon;
  }

  @override
  Widget build(BuildContext context) {
    if (!getAnon()) {
      return Scaffold(
        backgroundColor: Color(0xFFb5e1eb),
        appBar: AppBarCommon(
            title: Text('Welcome! Select A Room'), appBar: AppBar()),
        drawer: DrawerCommon(),
        body: GroupList(),
      );
    } else {
      return Scaffold(
        backgroundColor: Color(0xFFb5e1eb),
        appBar: AppBarCommon(
            title: Text('Welcome! Select A Room'), appBar: AppBar()),
        drawer: DrawerCommonAnon(),
        body: GroupList(),
      );
    }
  }
}
