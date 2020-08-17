import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/subscription/page/widgets/centerText.dart';
import 'package:attt/view/subscription/page/widgets/resultCont.dart';
import 'package:flutter/material.dart';

Widget pageOneToTwo(BuildContext context, PageController pageController, Function checkIsIosTablet) {
  return Stack(
    children: <Widget>[
      Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        height: SizeConfig.blockSizeVertical * 100,
        color: MyColors().lightBlack.withOpacity(0.5),
      ),
      Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1),
          height: SizeConfig.blockSizeHorizontal * 12,
          width: SizeConfig.blockSizeHorizontal * 90,
          child: RaisedButton(
            color: Color.fromRGBO(255, 198, 7, 1.0),
            onPressed: () => pageController.animateToPage(3,
                duration: Duration(milliseconds: 1500),
                curve: Curves.easeInOut),
            child: Text(
              'Start Today'.toUpperCase(),
              style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 4),
            ),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(
          top: checkIsIosTablet(context) ? SizeConfig.blockSizeVertical * 11 : SizeConfig.blockSizeVertical * 11,
          left: SizeConfig.blockSizeHorizontal * 3,
        ),
        child: Text(
          'What to Expect?',
          style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.safeBlockHorizontal * 9),
        ),
      ),
      Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(
                top: checkIsIosTablet(context) ? SizeConfig.blockSizeVertical * 20 : SizeConfig.blockSizeVertical * 17,
                left: SizeConfig.blockSizeHorizontal * 3,
              ),
              child: centerText('Program designed by ', "Aleksandar's", ' world')),
          Container(
              margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 0,
                left: SizeConfig.blockSizeHorizontal * 3,
              ),
              child: centerText('class performance coach ', "Richard Staudner", '')),
        ],
      ),
      Container(
        margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 31,
          left: SizeConfig.blockSizeHorizontal * 3,
        ),
        child: Text(
          'Training programs include:',
          style: TextStyle(color: Colors.white,
              fontSize: SizeConfig.safeBlockHorizontal * 6
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 36,
          left: SizeConfig.blockSizeHorizontal * 3,
        ),
        child: resultCont('', '-', ' Full Program: Strength and Conditioning\n for MMA'),
      ),
      Container(
        margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 42,
          left: SizeConfig.blockSizeHorizontal * 3,
        ),
        child: resultCont('', '-', ' Bodyweight only: At home, no equipment'),
      ),
      Container(
        margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 47,
          left: SizeConfig.blockSizeHorizontal * 3,
        ),
        child: resultCont('', '-', ' Tabata: Intense HIIT Conditioning'),
      ),
      Container(
        margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 52,
          left: SizeConfig.blockSizeHorizontal * 3,
        ),
        child: resultCont('', '-', ' Fighter Pull Up Program: Increase pull\n ups, fast'),
      ),
      Container(
        margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 59,
          left: SizeConfig.blockSizeHorizontal * 3,
        ),
        child: resultCont('', '-', ' + more...'),
      ),
      Container(
        margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 67,
          left: SizeConfig.blockSizeHorizontal * 3,
        ),
        child: Text(
          'New content released every month including: ',
          style: TextStyle(color: Colors.white,
              fontSize: SizeConfig.safeBlockHorizontal * 6
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(
          top: checkIsIosTablet(context) ? SizeConfig.blockSizeVertical * 79 : SizeConfig.blockSizeVertical * 77,
          left: SizeConfig.blockSizeHorizontal * 3,
        ),
        child: Row(
          children: <Widget>[
            Text('Kettlebell ',  style: TextStyle(color: Colors.white,
                fontSize: SizeConfig.safeBlockHorizontal * 4
            ),),
            Text('| Barbell ',  style: TextStyle(color: Colors.white,
                fontSize: SizeConfig.safeBlockHorizontal * 4
            ),),
            Text(' | Cardio ',  style: TextStyle(color: Colors.white,
                fontSize: SizeConfig.safeBlockHorizontal * 4
            ),),
            Text(' | Mobility ',  style: TextStyle(color: Colors.white,
                fontSize: SizeConfig.safeBlockHorizontal * 4
            ),),
          ],
        ),
      ),
    ],
  );
}
