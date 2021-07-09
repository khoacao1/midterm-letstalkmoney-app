import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:letstalkmoney_app/screens/grouplist.dart';
import 'package:letstalkmoney_app/services/auth.dart';
import 'package:letstalkmoney_app/shared/appbar.dart';
import 'package:letstalkmoney_app/shared/drawer.dart';
import 'package:letstalkmoney_app/shared/draweranon.dart';

// class Home extends StatelessWidget {
// const Home({Key? key}) : super(key: key);
// Create instant object _auth

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          // body: GroupList(),
          body: FutureBuilder(
              future: _initGoogleMobileAds(),
              builder: (context, snapshot) {
                return GroupList();
              }));
    }
  }

// COMPLETE: Change return type to Future<InitializationStatus>
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }
}
