import 'package:flutter/material.dart';
import 'package:groundlia/Pages/util/Data.dart';
import 'package:groundlia/Pages/util/widget.dart';

class Startevent extends StatefulWidget {
  SData data;
  Startevent(this.data);

  @override
  _StarteventState createState() => _StarteventState();
}

class _StarteventState extends State<Startevent> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(

        ),
        onWillPop: onWillPop
    );
  }
}
