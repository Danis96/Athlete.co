import 'package:attt/utils/colors.dart';
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
      {Key key, this.sets, this.seriesID, this.workoutID, this.trainerID, this.weekID})
      : super(key: key);

  @override
  _SeriesInfoScreenState createState() => _SeriesInfoScreenState();
}

class _SeriesInfoScreenState extends State<SeriesInfoScreen> {
  List<DocumentSnapshot> seriesDocuments = [];
  DocumentSnapshot seriesDocument;
  String seriesName = '';
  Future _future;
  List<dynamic> exercisesList = [];

  @override
  void initState() {
    super.initState();
    getSeriesName();
    _future = WorkoutViewModel().getExercises(
        widget.trainerID,
        widget.weekID,
        widget.workoutID,
        widget.seriesID,
        hasActiveConnection ? Source.serverAndCache : Source.cache);
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
                ? SizeConfig.blockSizeHorizontal * 4.5
                : SizeConfig.blockSizeHorizontal * 2,
            right: MediaQuery.of(context).orientation == Orientation.portrait
                ? SizeConfig.blockSizeHorizontal * 4.5
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
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Circuit exercises - ' + widget.sets.toString() + ' sets:',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? SizeConfig.safeBlockHorizontal * 2.5
                          : SizeConfig.safeBlockHorizontal * 5.5,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              FutureBuilder(
                  future: _future,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              (index + 1).toString() +
                                  '. ' +
                                  snapshot.data[index].data['name'],
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).orientation ==
                                        Orientation.landscape
                                    ? SizeConfig.safeBlockHorizontal * 2.5
                                    : SizeConfig.safeBlockHorizontal * 5.5,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.left,
                            );
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: RaisedButton(
        child: Text('START SERIES'),
        onPressed: () => overlayEntry.remove(),
      ),
    );
  }
}
