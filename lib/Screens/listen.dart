import 'package:ahaditapp/audio/audio.dart';
import 'package:ahaditapp/db/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Listen extends StatefulWidget {
  @override
  State<Listen> createState() => _ListenState();
}

class _ListenState extends State<Listen> {
  Future getit() async {
    var data = await Mydata.getAlldata();
    return data;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          SvgPicture.asset(
            "assets/svg/background.svg",
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("         "),
                            SvgPicture.asset(
                              "assets/svg/logo.svg",
                            ),
                            InkWell(
                                onTap: () {
                                  print(getit());
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_forward_ios)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "الاستماع للاحاديث",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: Color(0xff3DA53D),
                              fontWeight: FontWeight.w900,
                              fontSize: 28),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: FutureBuilder(

                    //we call the method, which is in the folder db file database.dart
                    future: Mydata.getAlldata(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            var item = snapshot.data[index];
                            //delete one register for id
                            return GestureDetector(
                                onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LocalAudio(item)));
                                },
                                child: Aya(item.key, item.nameHadith));
                          },
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 390,
                            mainAxisSpacing: 1,
                            childAspectRatio: 1.999 / 2,
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

class Aya extends StatelessWidget {
  final String key1;
  final String namehadith;
  Aya(this.key1, this.namehadith);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset("assets/img.png"),
        SvgPicture.asset("assets/svg/grey.svg"),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              key1,
              style: TextStyle(fontSize: 16, color: Color(0xffFFD434)),
            ),
            Text(
              namehadith,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffFFD434)),
              textScaleFactor: .5,
            ),
          ],
        )
      ],
    );
  }
}
