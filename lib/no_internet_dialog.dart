import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void noInternetDialog(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: new Text('No Internet Connection'))
  );
}
