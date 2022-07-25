import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/hadith.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class LocalAudio extends StatefulWidget {
  Hadith data;
  LocalAudio(this.data);

  @override
  State<LocalAudio> createState() => _LocalAudioState();
}

class _LocalAudioState extends State<LocalAudio> {
  final audio = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPressed = false;
  bool is_playing = false;
  String getFormattedTime(Duration time) {
    String mymins = time.inMinutes.toString();
    String mysec = (time.inSeconds % 60).toString();
    if (int.parse(mymins) < 10) {
      mymins = "0${mymins}";
    }
    if (int.parse(mysec) < 10) {
      mysec = "0${mysec}";
    }
    return "${mymins}:${mysec}";
  }

  Future setAudio() async {
    final url = "audio/${widget.data.audioHadith}";
    print("im here");
    audio.setSourceAsset(url);
  }

  @override
  void dispose() {
    audio.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setAudio();
    audio.onPlayerStateChanged.listen((event) {
      setState(() {
        is_playing = event == PlayerState.playing;
      });
    });
    audio.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });
    audio.onPositionChanged.listen((event) {
      position = event;
    });
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
        Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Row(
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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, top: 20.0),
                      child: Text(widget.data.nameHadith,
                          textDirection: ui.TextDirection.rtl,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: 27,
                              color: Color(0xff49C649),
                              fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/Group 31.jpg",
                      width: double.infinity,
                      height: 290,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.end,

                    children: [
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(widget.data.key,
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.w800))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              color: (isPressed) ? Colors.red : Colors.grey,
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
                            width: 200,
                            child: Text(widget.data.nameHadith,
                                textDirection: ui.TextDirection.rtl,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                    fontSize: 27,
                                    color: Color(0xff49C649),
                                    fontWeight: FontWeight.w800)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Slider(
                    activeColor: Color(0xff49C649),
                    inactiveColor: Color.fromARGB(255, 134, 236, 134),
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: (value) async {
                      final position = Duration(seconds: value.toInt());
                      await audio.seek(position);
                      await audio.resume();
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(getFormattedTime(position)),
                      Text(getFormattedTime(duration - position)),
                    ],
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Color(0xff49C649),
                  radius: 35,
                  child: IconButton(
                    color: Colors.white,
                      iconSize: 40,
                      onPressed: () async {
                        if (is_playing) {
                          await audio.pause();
                        } else {
                          await audio.resume();
                        }
                      },
                      icon: Icon(
                        is_playing ? Icons.pause : Icons.play_arrow,
                      )),
                )
              ],
            )),
      ],
    ));
  }
}
