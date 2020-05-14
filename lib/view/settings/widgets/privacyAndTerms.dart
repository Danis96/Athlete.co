import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/settings/widgets/textPrivacy.dart';
import 'package:flutter/material.dart';

class PrivacyAndTerms extends StatelessWidget {
  const PrivacyAndTerms({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: MyColors().lightBlack,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 8,
                ),
                child: Text(
                  'Trainer + Plus Ltd - Privacy & Policies ',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.safeBlockHorizontal * 5),
                ),
              ),
              Container(
                child: Text(
                  'June 2020',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              privacyContainer(TextPrivacy().health1, TextPrivacy().health2),
              privacyContainer(TextPrivacy().data1, TextPrivacy().data2),
              privacyContainer(
                  TextPrivacy().principle1, TextPrivacy().principle2),
              privacyContainer(
                  TextPrivacy().collection1, TextPrivacy().collection2),
              privacyContainer(TextPrivacy().reg1, TextPrivacy().reg2),
              privacyContainer(TextPrivacy().regFb1, TextPrivacy().regFB2),
              privacyContainer(TextPrivacy().access1, TextPrivacy().access2),
              privacyContainer(TextPrivacy().push1, TextPrivacy().push2),
              privacyContainer(TextPrivacy().google1, TextPrivacy().google2),
              privacyContainer(TextPrivacy().twitter1, TextPrivacy().twitter2),
              privacyContainer(TextPrivacy().face1, TextPrivacy().face2),
              privacyContainer(
                  TextPrivacy().fbCustom1, TextPrivacy().fbCustom2),
              privacyContainer(
                  TextPrivacy().firebase1, TextPrivacy().firebase2),
              privacyContainer(TextPrivacy().third1, TextPrivacy().third2),
              privacyContainer(TextPrivacy().info1, TextPrivacy().info2),
              privacyContainer(TextPrivacy().lodge1, TextPrivacy().lodge2),
              privacyContainer(TextPrivacy().with1, TextPrivacy().with2),
              privacyContainer(TextPrivacy().right1, TextPrivacy().right2),
              privacyContainer(TextPrivacy().balance1, TextPrivacy().balance2),
              privacyContainer(TextPrivacy().amad1, TextPrivacy().amad2),
            ],
          ),
        ),
      ),
    );
  }
}

Widget privacyContainer(String headline, textPrivacy) {
  return Column(
    children: <Widget>[
      Container(
        width: SizeConfig.blockSizeHorizontal * 80,
        margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 8,
        ),
        child: Text(
          headline,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: SizeConfig.safeBlockHorizontal * 5),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Text(
            textPrivacy,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ],
  );
}
