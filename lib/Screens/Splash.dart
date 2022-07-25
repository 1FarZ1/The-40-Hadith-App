import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, "/home");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(alignment: Alignment.center, children: [
      SvgPicture.asset(
        "assets/svg/splash.svg",
        fit: BoxFit.fill,
        width: double.infinity,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/islamic.svg",
            height: 130,
            width: 150,
          ),
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: Text(
              "الاربعين النووية",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w900),
            ),
          )
        ],
      )
    ]));
  }
}
