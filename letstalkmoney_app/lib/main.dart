import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:letstalkmoney_app/models/user.dart';
import 'package:letstalkmoney_app/screens/wrapper.dart';
import 'package:letstalkmoney_app/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final AuthService _auth = AuthService();
  _auth.signInAnon();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ObjectUser?>.value(
      catchError: (_, __) => null,
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
