import 'package:flutter/material.dart';
import 'features/login_page.dart';

class FlutterBasicApp extends StatefulWidget {
  @override
  _FlutterBasicAppState createState() => _FlutterBasicAppState();
}

class _FlutterBasicAppState extends State<FlutterBasicApp> {

  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }

}
