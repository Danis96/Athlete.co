import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

class NoteTextField extends StatelessWidget {
  final Function updateNewNote;
  final bool finishScreen;
  const NoteTextField({Key key, this.finishScreen, this.updateNewNote})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Material(
        color: MyColors().lightBlack,
        child: new TextFormField(
          enableInteractiveSelection: false,
          onChanged: (input) => updateNewNote(input),
          initialValue: userNotes,
          autofocus: false,
          enableSuggestions: false,
          maxLines: null,
          autocorrect: false,
          style: new TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).orientation == Orientation.portrait
                ? SizeConfig.safeBlockHorizontal * 4.5
                : SizeConfig.safeBlockHorizontal * 2.5,
          ),
          cursorColor: Colors.white60,
          decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical * 2.5),
            labelStyle: new TextStyle(
              color: Colors.white60,
              fontSize:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? SizeConfig.safeBlockHorizontal * 4.5
                      : SizeConfig.safeBlockHorizontal * 2.5,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              fontStyle: FontStyle.italic,
            ),
            labelText: 'Add a note',
            filled: true,
            fillColor: MyColors().black,
            prefixIcon: new Icon(
              Icons.edit,
              color: MyColors().white,
            ),
            suffixIcon: finishScreen == true
                ? GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          color: Colors.white,
                          icon: Icon(
                            Icons.check_circle,
                          ),
                          onPressed: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          },
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          },
                          child: Text(
                            'DONE',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
