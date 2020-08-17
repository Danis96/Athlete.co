import 'package:attt/utils/checkForInternet.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/home/widgets/buttonList.dart';
import 'package:attt/view/home/widgets/logo.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({Key key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String name = '';
  String folderInAppImage;
  String folderInAppVideo;
  String imageFileFolderName;
  bool downloading = false;
  var progressString = '';

  Future getTrainers() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('Trainers').getDocuments(source: hasActiveConnection ? Source.serverAndCache : Source.cache);
    return qn.documents;
  }


  @override
  void initState() {
    super.initState();
    SignInViewModel().autoLogIn(context);
    InternetConnectivity().checkForConnectivity();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                /// TRAINERS
                child: FutureBuilder(
                    future: getTrainers(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              String trainerName =
                                  snapshot.data[index].data['trainer_name'];
                              return EmptyContainer();

                            });
                      }
                      return EmptyContainer();
                    }),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 16,
              ),
              logo(context),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 35,
              ),
              buttonList(context)
            ],
          ),
        ),
      ),
    );
  }

}

