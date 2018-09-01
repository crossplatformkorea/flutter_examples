import 'package:flutter/material.dart';

import '../utils/theme.dart' as Theme;
import '../utils/localization.dart' show Localization;
import '../utils/general.dart';

class ExBottomSheet extends StatefulWidget {
  ExBottomSheet({Key key}) : super(key: key);

  @override
  _ExBottomSheetState createState() => new _ExBottomSheetState();
}

class _ExBottomSheetState extends State<ExBottomSheet> {
  _navigate() {
    General.instance.navigateScreenNamed(context, '/ExBottomDialog', reset: true);
  }

  List<DateTime> data = [
    DateTime(2018, 8, 16),
    DateTime(2018, 8, 18),
    DateTime(2018, 8, 20),
    DateTime(2018, 8, 23),
    DateTime(2018, 8, 26),
    DateTime(2018, 8, 30),
  ];

  String _txt = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Sheet'),
      ),
      body: Container(
        child: Center(
          child: FlatButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (builder){
                  return Container(
                    color: Color.fromRGBO(240, 240, 240, 1.0),
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        var datum = '${data[index].year}/${data[index].month}/${data[index].day}';
                        return Container(
                          child: FlatButton(
                            onPressed: () {
                              print('select: ${data[index].toString()}');
                              setState(() {
                                _txt = datum;
                              });
                              Navigator.of(context).pop();
                            },
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 64.0,
                                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Center(
                                    child: Text(
                                      datum,
                                      style: TextStyle(
                                        color:  Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "AppleSDGothicNeo",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: data.length,
                    ),
                  );
                }
              );
            },
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: this._txt == '' ? 'Select Date!!' : 'Selected Date: ',
                    style: TextStyle(
                      color:  Theme.Colors.dodgerBlue,
                      fontWeight: FontWeight.w400,
                      fontFamily: "AppleSDGothicNeo",
                      fontStyle:  FontStyle.normal,
                      fontSize: 18.0,
                    ),
                  ),
                  TextSpan(
                    text: _txt,
                    style: TextStyle(
                      color:  Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: "AppleSDGothicNeo",
                      fontStyle:  FontStyle.normal,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
