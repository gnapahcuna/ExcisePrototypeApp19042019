import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/arrest_screen_1.dart';

class ArrestFragment extends StatefulWidget {
  @override
  _ArrestFragmentState createState() => new _ArrestFragmentState();
}
class _ArrestFragmentState extends State<ArrestFragment>  {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return new Scaffold(
        body: new Center(
            child: new Container(
              padding: EdgeInsets.only(top: size.height / 4.5),
              child: new Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new SizedBox(
                      height: 180.0,
                      width: 180.0,
                      child: new IconButton(
                        padding: new EdgeInsets.all(0.0),
                        color: Colors.white,
                        icon: new Icon(
                            Icons.add_circle, color: Color(0xff087de1),
                            size: 180.0),
                        onPressed: () {
                          Navigator.of(context)
                              .push(
                              new MaterialPageRoute(
                                  builder: (context) => ArrestMainScreenFragment()));
                        },
                      )
                  ),
                  new Padding(padding: EdgeInsets.only(top: 32.0),
                    child: Text("สร้างบันทึกจับกุม สส.2/39", style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),),)
                ],
              ),
            )
        )
    );
  }
}