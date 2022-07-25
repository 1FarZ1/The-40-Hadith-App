import 'package:ahaditapp/audio/audio.dart';
import 'package:ahaditapp/models/hadith.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import "package:flutter_icons/flutter_icons.dart";
import 'package:share/share.dart';

class HadithPage extends StatefulWidget {
  final dynamic data;
  HadithPage(this.data);

  @override
  State<HadithPage> createState() => _HadithPageState();
}

class _HadithPageState extends State<HadithPage> {
  int _currentIndex = 0;
  bool isPressed = false;
  String? info;
  String? choose = "hadit";
  String getText() {
    if (choose == "hadit") {
      return widget.data.key;
    } else if (choose == "exp") {
      return "شرح ${widget.data.key} ";
    } else {
      return "تفسير ${widget.data.key} ";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    info = widget.data.textHadith;
  }

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
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 55,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(""),
                              SvgPicture.asset("assets/svg/logo.svg"),
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.arrow_right))
                            ],
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.end,

                              children: [
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(getText(),
                                        style: TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.w800))),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          {
                                            setState(() {
                                              if (isPressed) {
                                                isPressed = false;
                                              } else {
                                                isPressed = true;
                                              }
                                            });
                                          }
                                        },
                                        color: (isPressed)
                                            ? Colors.red
                                            : Colors.grey,
                                        highlightColor: Color.fromARGB(
                                            255, 18, 195, 50), //<-- SEE HERE
                                        iconSize: 30,
                                        icon: (isPressed)
                                            ? Icon(
                                                Icons.favorite,
                                                size: 30,
                                              )
                                            : Icon(
                                                Icons.favorite_border,
                                                size: 30,
                                              )),
                                    Container(
                                      width: 260,
                                      child: Text(widget.data.nameHadith,
                                          textDirection: TextDirection.rtl,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Color(0xff49C649),
                                              fontWeight: FontWeight.w800)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                      _convertHadith(context, info as String),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        bottomNavigationBar: CustomNavigationBar(
          iconSize: 28.0,
          scaleFactor: 0.5,
          selectedColor: Color.fromARGB(0, 43, 43, 223),
          strokeColor: Color(0xff49C649),
          unSelectedColor: Colors.grey[600],
          backgroundColor: Colors.white,
          items: [
            CustomNavigationBarItem(
              icon: Icon(
                AntDesign.file1,
              ),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.folder),
            ),
            CustomNavigationBarItem(
              icon: Icon(
                Icons.share,
                color: Colors.blueAccent,
              ),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.book),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.multitrack_audio_sharp),
            ),
          ],
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              if (_currentIndex == 0) {
                choose = "hadit";
                print("im here");
              }
              else if (_currentIndex == 2) {
                Share.share('check out my website https://example.com',
                    subject: 'Look what I made!');
              } else if (index == 1) {
                info = widget.data.explanationHadith;
                choose = "exp";
              } else if (index == 3) {
                info = widget.data.translateNarrator;
                choose = "tns";
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LocalAudio(widget.data)));
              }
            });
          },
        ));
  }
}

Padding _convertHadith(BuildContext context, String text) {
  text = text.replaceAll('(', '{');
  text = text.replaceAll(')', '}');

  List<String> split = text.split(RegExp("{"));

  List<String> hadiths = split.getRange(1, split.length).fold([], (t, e) {
    var texts = e.split("}");

    if (texts.length > 1) {
      return List.from(t)
        ..addAll(
            ["{${texts.first}}", "${e.substring(texts.first.length + 1)}"]);
    }
    return List.from(t)..add("{${texts.first}");
  });

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40.0),
    child: RichText(
      textAlign: TextAlign.right,
      text: TextSpan(
        style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 154, 106, 89),
            fontWeight: FontWeight.w800),
        //style: DefaultTextStyle.of(context).style,
        children: [TextSpan(text: split.first)]..addAll(hadiths
            .map((text) => text.contains("{")
                ? TextSpan(
                    text: text,
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ))
                : TextSpan(text: text))
            .toList()),
      ),
      textDirection: TextDirection.rtl,
    ),
  );
}
