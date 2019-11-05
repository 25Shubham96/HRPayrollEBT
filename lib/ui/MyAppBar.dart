import 'package:flutter/material.dart';

class MyAppBar {
  static getAppBar(String title) {
    return new AppBar(
      title: new Title(
        color: Colors.white,
        child: new Text(title),
      ),
      centerTitle: true,
      backgroundColor: Colors.redAccent,
    );
  }
}
