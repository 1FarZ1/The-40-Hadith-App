import 'package:ahaditapp/Screens/Splash.dart';
import 'package:ahaditapp/Screens/ahaditarb3in.dart';
import 'package:ahaditapp/Screens/hadithPage.dart';
import 'package:ahaditapp/Screens/home.dart';
import 'package:ahaditapp/Screens/listen.dart';
import 'package:ahaditapp/Screens/saved.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
 SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
 ));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/", routes: {
    "/": (context) => Splash(),
    "/home": (context) => Home(),
    "/40":(context) => Arb3in(),
  "/listen":(context) =>Listen(),
  "/saved":(context) =>SavingScreen(),
  
  }));
}
