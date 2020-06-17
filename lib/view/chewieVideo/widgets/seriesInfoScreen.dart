import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view_model/chewieVideoViewModel.dart';
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

class _SeriesInfoScreenState extends State<SeriesInfoScreen> {
  List<DocumentSnapshot> seriesDocuments = [];
  DocumentSnapshot seriesDocument;
  String seriesName = '';

  @override
  void initState() {
    super.initState();
    getSeriesName();
  }

  getSeriesName() async {
    seriesDocuments = await ChewieVideoViewModel().getSeriesName(
        widget.trainerID, widget.weekID, widget.workoutID, widget.seriesID);
    seriesDocument = seriesDocuments[0];
    setState(() {
      seriesName = seriesDocument.data['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: MyColors().lightBlack,
      body: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).orientation == Orientation.portrait
                ? SizeConfig.blockSizeHorizontal * 5
                : SizeConfig.blockSizeHorizontal * 2,
            right: MediaQuery.of(context).orientation == Orientation.portrait
                ? SizeConfig.blockSizeHorizontal * 5
                : SizeConfig.blockSizeHorizontal * 2),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                seriesName,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? SizeConfig.safeBlockHorizontal * 5
                      : SizeConfig.safeBlockHorizontal * 9.5,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          elevation: 0,
          onPressed: () => overlayEntry.remove(),
          child: Padding(
            padding: EdgeInsets.all(22.0),
            child: Text(
              'START CIRCUIT',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: SizeConfig.blockSizeHorizontal * 4,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}
