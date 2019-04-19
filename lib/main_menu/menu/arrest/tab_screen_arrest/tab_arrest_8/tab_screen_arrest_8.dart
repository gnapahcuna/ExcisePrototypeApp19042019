import 'package:flutter/material.dart';

class TabScreenArrest8 extends StatefulWidget {
  bool onSaved;
  bool onEdited;
  bool onDeleted;
  TabScreenArrest8({
    Key key,
    @required this.onSaved,
    @required this.onEdited,
    @required this.onDeleted,
  }) : super(key: key);
  @override
  _TabScreenArrest8State createState() => new _TabScreenArrest8State();
}
class _TabScreenArrest8State extends State<TabScreenArrest8>  {
  final FocusNode myFocusNodeArrestBehavior = FocusNode();
  final FocusNode myFocusNodeTestimony= FocusNode();
  final FocusNode myFocusNodeNotificationOfRights = FocusNode();

  TextEditingController editArrestBehavior = new TextEditingController();
  TextEditingController editTestimony = new TextEditingController();
  TextEditingController editNotificationOfRights= new TextEditingController();

  @override
  void initState() {
    super.initState();
    print("tab 7 Save: "+widget.onSaved.toString());
    print("tab 7 Edit: "+widget.onEdited.toString());
    print("tab 7 Delete: "+widget.onDeleted.toString());
  }


  @override
  void dispose() {
    super.dispose();
    myFocusNodeArrestBehavior.dispose();
    myFocusNodeTestimony.dispose();
    myFocusNodeNotificationOfRights.dispose();
  }

  Widget _buildContent() {
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black);
    EdgeInsets paddindTextTitle = EdgeInsets.only(bottom: 18.0);
    return Container(
      padding: EdgeInsets.only(bottom: 22.0),
      margin: EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(bottom: 24.0),
            child: new Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              elevation: 1.0,
              child: Container(
                  margin: EdgeInsets.all(24.0),
                  // hack textfield height
                  //padding: EdgeInsets.only(bottom: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: paddindTextTitle,
                        child: Text(
                          "พฤติกรรมการจับกุม", style: textInputStyle,),
                      ),
                      TextField(
                        maxLines: 10,
                        focusNode: myFocusNodeArrestBehavior,
                        controller: editArrestBehavior,
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[500], width: 0.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[400], width: 0.5),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ),
          new Container(
            padding: EdgeInsets.only(bottom: 24.0),
            child: new Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              elevation: 1.0,
              child: Container(
                  margin: EdgeInsets.all(24.0),
                  // hack textfield height
                  //padding: EdgeInsets.only(bottom: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: paddindTextTitle,
                        child: Text(
                          "คำให้การของผู้ต้องหา", style: textInputStyle,),
                      ),
                      TextField(
                        focusNode: myFocusNodeTestimony,
                        controller: editTestimony,
                        maxLines: 10,
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[500], width: 0.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[400], width: 0.5),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ),
          new Container(
            padding: EdgeInsets.only(bottom: 24.0),
            child: new Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              elevation: 1.0,
              child: Container(
                  margin: EdgeInsets.all(24.0),
                  // hack textfield height
                  //padding: EdgeInsets.only(bottom: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: paddindTextTitle,
                        child: Text("การแจ้งสิทธิ", style: textInputStyle,),
                      ),
                      TextField(
                        focusNode: myFocusNodeNotificationOfRights,
                        controller: editNotificationOfRights,
                        maxLines: 10,
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[500], width: 0.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[400], width: 0.5),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                //height: 34.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border(
                        top: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: Column(
                    children: <Widget>[Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: new Text('ILG60_B_01_00_09_00',
                            style: TextStyle(color: Colors.grey[400]),),
                        ),
                      ],
                    ),
                    ],
                  )
              ),
              Expanded(
                child: new ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: SingleChildScrollView(
                    child: _buildContent(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}