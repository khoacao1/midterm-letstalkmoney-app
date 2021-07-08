import 'package:flutter/material.dart';
import 'package:letstalkmoney_app/screens/authenticate/authentication.dart';
import 'package:letstalkmoney_app/screens/wrapper.dart';
import 'package:letstalkmoney_app/services/auth.dart';
import 'package:letstalkmoney_app/shared/customlisttile.dart';

class DrawerCommonAnon extends StatefulWidget {
  @override
  _DrawerCommonAnonState createState() => _DrawerCommonAnonState();
}

class _DrawerCommonAnonState extends State<DrawerCommonAnon> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          CustomListTile(Icons.backpack, 'Message Boards', () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Wrapper()));
          }),
          CustomListTile(Icons.app_registration, 'Log Out & Register',
              () async {
            await _auth.signOut();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Wrapper()));
          }),
        ],
      ),
    );
  }
}
