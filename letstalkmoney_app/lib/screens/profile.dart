import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letstalkmoney_app/screens/editprofile.dart';
import 'package:letstalkmoney_app/shared/drawer.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late User _user;
  String? fname;
  String? lname;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  getUid() {
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    return uid;
  }

  getFirstName() {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('Users');
    var uid = getUid();
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          // return Text("${data['Full Name']}", style: TextStyle(fontSize: 17.0));
          return Text("${data['First Name']}",
              style: TextStyle(fontSize: 17.0));
        }

        return Text("loading");
      },
    );
  }

  getLastName() {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('Users');
    var uid = getUid();
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          // return Text("${data['Full Name']}", style: TextStyle(fontSize: 17.0));
          return Text("${data['Last Name']}", style: TextStyle(fontSize: 17.0));
        }

        return Text("loading");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb5e1eb),
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFF2a9d8f),
        elevation: 0.0,
      ),
      drawer: DrawerCommon(),
      body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 170.0),
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.account_circle, size: 200.0, color: Colors.white),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('First Name', style: TextStyle(fontSize: 17.0)),
                      getFirstName(),
                    ],
                  ),
                  Divider(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Last Name', style: TextStyle(fontSize: 17.0)),
                      getLastName()
                    ],
                  ),
                ],
              ),
            )
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final List<String> pageResults = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EditProfile()));
          setState(() {
            fname = pageResults[0];
            lname = pageResults[1];
          });
        },
        child: Icon(Icons.edit, color: Colors.white, size: 30.0),
        backgroundColor: Colors.grey[700],
        elevation: 0.0,
      ),
    );
  }
}
