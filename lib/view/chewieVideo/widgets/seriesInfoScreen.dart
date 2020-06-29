import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view_model/chewieVideoViewModel.dart';
import 'package:attt/view_model/workoutViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SeriesInfoScreen extends StatefulWidget {
  final String trainerID, weekID, workoutID, seriesID;
  final int sets;
  const SeriesInfoScreen(
      {Key key,
      this.sets,
      this.seriesID,
      this.workoutID,
      this.trainerID,
      this.weekID})
      : super(key: key);

  @override
  _SeriesInfoScreenState createState() => _SeriesInfoScreenState();
}

class _SeriesInfoScreenState extends State<SeriesInfoScreen> with TickerProviderStateMixin {
  List<DocumentSnapshot> seriesDocuments = [];
  DocumentSnapshot seriesDocument;
  String seriesName = '';
  AnimationController _controller;
  AnimationController controllerColor;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1),
      vsync: this,
    )..forward();

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.8, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    super.initState();
    getSeriesName();
  }

  getSeriesName() async {
    List<dynamic> seriesNameWords = [];
    seriesDocuments = await ChewieVideoViewModel().getSeriesName(
        widget.trainerID, widget.weekID, widget.workoutID, widget.seriesID);
    seriesDocument = seriesDocuments[0];
    setState(() {
      seriesName = seriesDocument.data['name'];
    });
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      seriesNameWords = seriesName.split(' ');
      if (seriesNameWords.length == 4) {
        setState(() {
          seriesName = seriesNameWords[0] +
              ' ' +
              seriesNameWords[1] +
              '\n' +
              seriesNameWords[2] +
              ' ' +
              seriesNameWords[3];
        });
      }
    }
  }

  String name;
  final Source source =
      hasActiveConnection ? Source.serverAndCache : Source.cache;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SlideTransition(
      position: _offsetAnimation,
      child: Scaffold(
        backgroundColor: MyColors().lightBlack,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: SizeConfig.blockSizeVertical * 100,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 0),
                child: Text(
                  seriesName,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).orientation ==
                        Orientation.landscape
                        ? SizeConfig.safeBlockHorizontal * 5
                        : SizeConfig.safeBlockHorizontal * 9.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ]
          ),
        ),
        bottomNavigationBar: btnCustom()
      ),
    );
  }
}

Widget btnCustom() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    margin: EdgeInsets.only(
      left: SizeConfig.blockSizeHorizontal * 5,
        right: SizeConfig.blockSizeHorizontal * 5,
        bottom: SizeConfig.blockSizeVertical * 3,
        top: SizeConfig.blockSizeVertical * 0),
    height: SizeConfig.blockSizeVertical * 5,
    width: SizeConfig.blockSizeHorizontal * 90,
    child: RaisedButton(
      elevation: 0,
      onPressed: () => overlayEntry.remove(),
      child: Center(
        child: Text(
          'BEGIN' ,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: SizeConfig.blockSizeHorizontal * 4,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      color: Colors.white,
    ),
  );
}
