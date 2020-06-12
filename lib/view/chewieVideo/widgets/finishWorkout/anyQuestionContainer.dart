import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/trainingPlan/widgets/socialMediaDialog.dart';
import 'package:flutter/material.dart';

class AnyQuestionContainer extends StatefulWidget {
  final String userName;
  AnyQuestionContainer({Key key, this.userName}) : super(key: key);

  @override
  _AnyQuestionContainerState createState() => _AnyQuestionContainerState();
}

class _AnyQuestionContainerState extends State<AnyQuestionContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          onTap: () {
            setState(() {
              focused = false;
            });
            showSocialMediaDialog(context, widget.userName);
          },
          readOnly: true,
          enableInteractiveSelection: false,
          initialValue: 'Can we help? Contact Us.',
          autofocus: false,
          enableSuggestions: false,
          maxLines: 1,
          autocorrect: false,
          style: TextStyle(
            color: Colors.white,
            fontSize: SizeConfig.safeBlockHorizontal * 4.5,
          ),
          cursorColor: Colors.white60,
          decoration: InputDecoration(
            enabled: false,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              vertical: SizeConfig.blockSizeVertical * 3,
            ),
            filled: true,
            fillColor: MyColors().black,
            prefixIcon: Icon(
              Icons.mail,
              color: MyColors().white,
            ),
          ),
        ),
      ],
    );
  }
}
