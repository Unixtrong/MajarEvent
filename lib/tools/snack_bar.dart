import 'package:flutter/material.dart';

class SnackTool {
  static show(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(text)));
  }
}
