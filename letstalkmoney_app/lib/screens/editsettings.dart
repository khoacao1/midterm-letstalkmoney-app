import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letstalkmoney_app/shared/drawer.dart';

class EditSettings extends StatefulWidget {
  EditSettings({Key? key}) : super(key: key);

  @override
  _EditSettingsState createState() => _EditSettingsState();
}

class _EditSettingsState extends State<EditSettings> {
  late String social;
  String password = '';
  TextEditingController passwordController = TextEditingController();
  TextEditingController socialController = TextEditingController();

  void _changePassword(String password) async {
    User? user = await FirebaseAuth.instance.currentUser;

    user!.updatePassword(password).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });
  }

  Column buildPasswordField() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Enter new password.",
              style: TextStyle(
                  color: Color(0xFF264653),
                  fontWeight: FontWeight.w400,
                  fontSize: 18),
            ),
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
          ),
        ]);
  }

  Widget cancelButton() {
    return FlatButton(
      child: Text("Cancel", style: TextStyle(color: Color(0xFFFFFFFF))),
      color: Color(0xFF2a9d8f),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Column buildSocialField() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Enter your social media handles",
              style: TextStyle(
                  color: Color(0xFF264653),
                  fontWeight: FontWeight.w400,
                  fontSize: 18),
            ),
          ),
          TextFormField(
            controller: socialController,
            onChanged: (value) {
              social = value;
            },
          ),
        ]);
  }

  Future<void> addSocial(social_media) {
    // Call the user's CollectionReference to add a new user
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    var uid = FirebaseAuth.instance.currentUser!.uid;
    return users
        .doc(uid)
        .update({
          'social': social_media,
        })
        .then((value) => print("Social Added"))
        .catchError((error) => print("Failed to add social: $error"));
  }

  Widget socialButton() {
    return FlatButton(
      child: Text("Update Social Medias",
          style: TextStyle(color: Color(0xFFFFFFFF))),
      color: Color(0xFFe76f51),
      onPressed: () {
        print(socialController);
        //Navigator.pop(context,[social]);
        addSocial(social);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb5e1eb),
      appBar: AppBar(
        title: Text('Edit Settings'),
        backgroundColor: Color(0xFF2a9d8f),
        elevation: 0.0,
      ),
      drawer: DrawerCommon(),
      body: ListView(children: <Widget>[
        Container(
            child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  buildPasswordField(),
                  RaisedButton(
                    onPressed: () {
                      _changePassword(passwordController.text);
                      Navigator.pop(context);
                    },
                    child: Text("Update password",
                        style: TextStyle(color: Color(0xFFFFFFFF))),
                    color: Color(0xFFe76f51),
                  ),
                  cancelButton(),
                  buildSocialField(),
                  socialButton(),
                ],
              ),
            ),
          ],
        ))
      ]),
    );
  }
}
