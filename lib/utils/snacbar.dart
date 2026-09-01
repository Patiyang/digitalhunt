

import 'package:flutter/material.dart';

void openSnacbar(_scaffoldkey, String snackMessage,{BuildContext?context}) {
  ScaffoldMessenger.of(context!).showSnackBar(
    SnackBar(
      content: Container(
        alignment: Alignment.centerLeft,
        height: 60,
        child: Text(
          snackMessage,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      action: SnackBarAction(
        label: 'Ok',
        textColor: Colors.blueAccent,
        onPressed: () {},
      ),
    ),
  );
}