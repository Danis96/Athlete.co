import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/chewieVideo/widgets/globals.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///REST
class Paused extends StatefulWidget {
  final DocumentSnapshot userDocument, userTrainerDocument;
  Paused({this.userDocument, this.userTrainerDocument});

  @override
  _PausedState createState() => _PausedState();
}

class _PausedState extends State<Paused> with TickerProviderStateMixin {
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0),
      body: WillPopScope(
        onWillPop: () => onWillPop(),
        child: InkWell(
          onTap: () {
            overlayEntryPaused.remove();
            chewieController.play();
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Container(
              height: SizeConfig.blockSizeVertical * 20,
              width: SizeConfig.blockSizeHorizontal * 24,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(28, 28, 28, 0.7),
                  borderRadius: BorderRadius.all(Radius.circular(4.0))),
              padding: EdgeInsets.all(20.0),
              child: Text(
                'PAUSED',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.blockSizeVertical * 9,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            )),
          ),
        ),
      ),
    );
  }

  onWillPop() async {
    print('Nema nazad, hajde vjezbaj');
  }
}
