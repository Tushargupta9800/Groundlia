import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groundlia/Pages/Api/download.dart';
import 'package:groundlia/Pages/Api/storing_locally.dart';
import 'package:groundlia/Pages/Extra/loading_container.dart';
import 'package:groundlia/Pages/player_data/Admin_file.dart';
import 'package:groundlia/Pages/util/Data.dart';
import 'package:groundlia/Pages/util/widget.dart';

admin_file file = new admin_file();

class SelectSport extends StatefulWidget {

  SelectSport();

  @override
  _SelectSportState createState() => _SelectSportState();
}

class _SelectSportState extends State<SelectSport> {
  download dn = download();

  bool isloading = false;

  Widget Options(IconData icon, String name,BuildContext context,double size){
    return GestureDetector(
      onTap: () async {
        setState(() {
          isloading = true;
        });
        if(name == "Cricket"){
          Navigator.pushNamed(context, "/playCricket");
        }
        else if(name == "Basketball"){
          saving sv = saving();
          await sv.readfile().then((value) async {
            print("value" + value.toString());
            if(await dn.Basketballnewgame(value["OrganizerCode"])){
              setState(() {
                isloading = false;
              });
              Navigator.pushNamed(context, "/newbasketball");
            }else{
              setState(() {
                isloading = false;
              });
              Navigator.pushNamed(context, "/updatebasketball");
            }
          });
        }
        else if(name == "Badminton"){
          saving sv = saving();
          await sv.readfile().then((value) async {
            print("value" + value.toString());
            if(await dn.Badmintonnewgame(value["OrganizerCode"])){
              setState(() {
                isloading = false;
              });
              Navigator.pushNamed(context, "/newbadminton");
            }else{
              setState(() {
                isloading = false;
              });
              Navigator.pushNamed(context, "/updatebadminton");
            }
            });
        }
        else{
          setState(() {
            isloading = false;
          });
          Navigator.pushNamed(context, "/watchwhich");
        }
      },
      child:Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 40.0,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Text(name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: size,
                    fontFamily: "mainfont"
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: (isloading)?loading_container():Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[900],
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Heading("Editor Panel",context),
                Options(Icons.sports_cricket_outlined, "Cricket",context,45),
                Options(Icons.sports_basketball_outlined, "Basketball",context,45),
                Options(Icons.sports_tennis_outlined, "Badminton",context,45),
                Options(Icons.watch_later, "Watch Ongoing game\n(If Any)",context,25),
              ]
          ),
        ),
      ),
    );
  }
}
