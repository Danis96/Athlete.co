import 'dart:io';

import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(Icons.clear), onPressed: () => Navigator.pop(context)),
        title: Text('Privacy and Terms'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 3,
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
              Platform.isIOS
                  ? privacyContainer('App usage info & Subscription details',
                      'Athlete.co comes with 7 days free trial.After this free trial you must purchase an auto-renewing subscription through an In-App Purchase.  (If you do not maintain a subscription you cannot use the app with all the content)\n\n• Auto-renewable subscription\n• 1 month (\$9.99) and annual/12 month (\$89.99) durations. (Prices may vary by location)\n• Your subscription will be charged to your iTunes account at confirmation of purchase and will automatically renew  (at the duration selected) unless auto-renew is turned off at least 24 hours before the end of the current period.\n• Current subscription may not be cancelled during the active subscription period; however, you can manage your subscription and/or turn off auto-renewal by visiting your iTunes Account Settings after purchase.\n\nThe renewal rate will be according to your subscription \$9.99 or \$89.99\nIn addition, we offer free trial periods on 7 days!')
                  : EmptyContainer()
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
