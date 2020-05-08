import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

class InfoExercise extends StatefulWidget {
  final List<dynamic> exerciseTips;
  final Function refreshParent;
  const InfoExercise({Key key, this.exerciseTips, this.refreshParent})
      : super(key: key);

  @override
  _InfoExerciseState createState() => _InfoExerciseState();
}

class _InfoExerciseState extends State<InfoExercise> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: SizeConfig.blockSizeHorizontal * 100,
              child: Container(
                  height: SizeConfig.blockSizeVertical * 30,
                  color: MyColors().black,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 2),
                              child: IconButton(
                                color: MyColors().white,
                                iconSize: SizeConfig.blockSizeHorizontal * 8,
                                icon: Icon(Icons.clear),
                                onPressed: () => onDone(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 2),
                              child: Text(
                                exerciseNameForInfo,
                                style: TextStyle(
                                    color: MyColors().white,
                                    fontSize: SizeConfig.safeBlockHorizontal * 5,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 2.5),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.exerciseTips.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(
                                  bottom: SizeConfig.blockSizeVertical * 1,
                                  left: SizeConfig.blockSizeHorizontal * 5),
                              child: Text(
                                widget.exerciseTips[index].toString(),
                                style: TextStyle(color: MyColors().white),
                              ),
                            );
                          },
                        ),
                      ),

                      /// done
                      Container(
                        alignment: Alignment.bottomRight,
                        child: FlatButton(
                            color: MyColors().black,
                            onPressed: () => onDone(),
                            child: Text(
                              'DONE',
                              style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 4,
                                color: MyColors().white,
                              ),
                            )),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  onDone() {
    setState(() {
      isInfo = false;
      widget.refreshParent();
    });
  }
}
