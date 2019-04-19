import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_8.dart';

class TabScreenArrest8Dowload extends StatefulWidget {
  String Title;
  TabScreenArrest8Dowload({
    Key key,
    @required this.Title,
  }) : super(key: key);
  @override
  _TabScreenArrest8DowloadState createState() => new _TabScreenArrest8DowloadState();
}
class _TabScreenArrest8DowloadState extends State<TabScreenArrest8Dowload>  {
  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          title: new Padding(
            padding: EdgeInsets.only(right: 22.0),
            child: new Text(widget.Title,
              style: styleTextAppbar,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {

              },
              child: Icon(Icons.file_download,color: Colors.white,),
            ),
          ],
        ),
      ),
      body: Center(),
    );
  }
}