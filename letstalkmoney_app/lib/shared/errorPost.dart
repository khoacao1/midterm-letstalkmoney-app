import 'package:flutter/material.dart';

void errorPost(context) {
  showDialog(
    context: context,
    builder: (BuildContext bc) {
      return AlertDialog(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ALERT',
              style: TextStyle(
                  color: Color(0xFFe76f51),
                  fontWeight: FontWeight.w900,
                  fontSize: 30),
            ),
          ],
        ),
        content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Message Required',
                style: TextStyle(
                    color: Color(0xFFe76f51),
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
              SizedBox(
                height: 15,
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80)),
                padding: EdgeInsets.all(8),
                minWidth: 180,
                color: Color(0xFF2a9d8f),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              )
            ]),
      );
    },
  );
}
