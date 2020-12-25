import 'dart:async';

import 'package:flutter/material.dart';
import 'package:groundlia/Pages/Api/download.dart';
import 'package:groundlia/Pages/Extra/loading_container.dart';
import 'package:groundlia/Pages/Scores/basketball_score.dart';
import 'package:groundlia/Pages/util/Data.dart';
import 'package:groundlia/Pages/util/Listview.dart';
import 'package:groundlia/Pages/util/widget.dart';

download dn = new download();

class watchbasketball extends StatefulWidget {
  LData data;
  BasketballScore Score = new BasketballScore();
  watchbasketball(this.data,this.Score);

  @override
  _watchbasketballState createState() => _watchbasketballState();
}

class _watchbasketballState extends State<watchbasketball> {
  Timer time;
  bool isloading = true;
  @override
  void initState(){
    time = new Timer.periodic(Duration(seconds: 5), (Timer t) => Update());
    super.initState();
  }

  @override
  void dispose() {
    time.cancel();
    super.dispose();
  }

  Update() async {
    download dn = download();
    await dn.BasketballScore(widget.data).then((value) {
      widget.Score.dataelements(value["data"]["Team_A"]["Members"],
          value["data"]["Team_A"]["Score"].toString(),
          value["data"]["Team_B"]["Members"],
          value["data"]["Team_B"]["Score"].toString(),
          value["data"]["winner"].toString(),
          value["data"]["new"].toString());
    });
    setState(() {isloading = false;});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent[400],
        title: Text("Basketball Score Updates"),
      ),

      body: (isloading)?loading_container():Container(
        width: MediaQuery.of(context).size.width,
        child: (widget.Score.data.dataNew ==  "no")?Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Indicator(MediaQuery.of(context).size.width,"Organizer: "+ widget.Score.organizer),
              Indicator(MediaQuery.of(context).size.width,"Location: " + widget.Score.location),
              Container(
                  margin: EdgeInsets.only(top: 10.0),
                  width: MediaQuery.of(context).size.width-40.0,
                  height: MediaQuery.of(context).size.height-270,
                  color: Colors.blue,
                  child: Center(child: SingleChildScrollView(child: BasketballEachGameScore(widget.Score, MediaQuery.of(context).size.width)))
              ),
              GestureDetector(
                onTap: ()async {
                  await Update();
                },
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent[400],
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  margin: EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.refresh),
                      Text("Refresh"),
                    ],
                  ),
                ),
              )
            ],
          ),
        ):Center(
          child: Image.asset("Assets/Images/nothingfound/nothing_found.png"),
        ),
      ),
    );
  }
}
