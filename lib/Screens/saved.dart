import 'package:ahaditapp/Screens/hadithPage.dart';
import 'package:ahaditapp/db/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fancy_containers/fancy_containers.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:easy_container/easy_container.dart';
class SavingScreen extends StatefulWidget {
  @override
  State<SavingScreen> createState() => _SavingScreenState();
}

class _SavingScreenState extends State<SavingScreen> {
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
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right:18.0),
                              child: Container(
                                padding: EdgeInsets.fromLTRB(30,5,30,5),
                                decoration: BoxDecoration(
                                  gradient:  LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
               Color(0xff422563),
                Color(0xffB42C2C),
              ],
            ),
                                  borderRadius:BorderRadius.circular(160),
                          
                                  backgroundBlendMode:BlendMode.darken,
                                   ),
                                
                                child: Text(
                                  "ألأحاديث المحفوظة",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 28),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: FutureBuilder(

                    //we call the method, which is in the folder db file database.dart
                    future: Mydata.getSaveddata(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            var item = snapshot.data[index];
                            //delete one register for id
                            return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HadithPage(item)));
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
