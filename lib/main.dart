import 'dart:io';
import 'package:e_simple/providers/login_provider.dart';
import 'package:e_simple/repositories/auth_repository.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'app.dart';

Future<void> main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => LoginProvider(authRepository: AuthRepository())),
      ],
      child:
      MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: FlutterBasicApp(),
    );
  }
}
