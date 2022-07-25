import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SvgPicture.asset(
          "assets/svg/background.svg",
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 30, 20, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  "assets/svg/logo.svg",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: "الاربعون النووية\n",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 19,
                          fontWeight: FontWeight.w900)),
                  TextSpan(
                      text: " لحفظ وسماع الاحاديث النبوية",
                      style: TextStyle(
                          fontSize: 28.5,
                          fontWeight: FontWeight.w900,
                          color: Color(0xff3DA53D),
                          wordSpacing: 1))
                ]),
                textAlign: TextAlign.right,
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CardGr(
                      Color(0xff49C649),
                      Color(0xff336325),
                      "الاحاديث الاربعين",
                      "assets/quran.png",
                      "assets/svg/one.svg",
                      "/40"),
                  CardGr(Colors.yellow, Colors.red, "الاستماع للالاحاديث ",
                      "assets/play.png", "assets/svg/twoo.svg", "/listen"),
                  CardGr(
                      Color(0xff422563),
                      Color(0xffB42C2C),
                      "الاحاديث المحفوظة",
                      "assets/save-instagram.png",
                      "assets/svg/three.svg",
                      "/saved")
                ],
              )
              // CardGr(first_color:Colors.red,second_color:Colors.blue,inputtext:("me"),srclogo:"me"),
              // CardGr(first_color:Colors.red,second_color:Colors.blue,inputtext:("me"),srclogo:"me"),
              // CardGr(first_color:Colors.red,second_color:Colors.blue,inputtext:("me"),srclogo:"me")
            ],
          ),
        )
      ],
    ));
  }
}

class CardGr extends StatelessWidget {
  final Color first_color;
  final Color second_color;
  final String inputtext;
  final String srclogo1;
  final String srclogo2;
  final String path;
  CardGr(Color this.first_color, Color this.second_color, String this.inputtext,
      String this.srclogo1, String this.srclogo2, String this.path);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, this.path);
        },
        child: Container(
          width: 335,
          height: 117,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(this.srclogo1),
                Text(this.inputtext,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w900)),
                SvgPicture.asset(this.srclogo2),
              ],
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                this.first_color,
                this.second_color,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
