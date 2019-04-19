import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_offense_list_screen.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/detail/lawsuit_not_accept_screen_offense_list.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_ suspect.dart';

class CompareSuspectScreenFragment extends StatefulWidget {
  ItemsCompareSuspect ItemsSuspect;
  CompareSuspectScreenFragment({
    Key key,
    @required this.ItemsSuspect,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<CompareSuspectScreenFragment>  with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildContent() {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 80) / 100;
    TextStyle textStyleLabel = TextStyle(
        fontSize: 16, color: Color(0xff087de1));
    TextStyle textStyleData = TextStyle(fontSize: 18, color: Colors.black);
    TextStyle textStyleLink = TextStyle(color: Color(0xff4564c2));
    EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border(
                bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text("ชื่อผู้ต้องหา", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  widget.ItemsSuspect.SuspectName,
                  style: textStyleData,),
              ),
              Padding(
                padding: paddingData,
                child: Container(
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text("ประเภทผู้ต้องหา", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  widget.ItemsSuspect.SuspectArrestType,
                  style: textStyleData,),
              ),
              Container(
                padding: paddingLabel,
                child: Text("ประเภทบุคคล", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  widget.ItemsSuspect.SuspectArrestType,
                  style: textStyleData,),
              ),
              Container(
                padding: paddingLabel,
                child: Text("เลขที่บัตรประชาชน", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  widget.ItemsSuspect.IdentifyNumber,
                  style: textStyleData,),
              ),
              Container(
                padding: paddingLabel,
                child: Text("ที่อยู่", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  widget.ItemsSuspect.Address,
                  style: textStyleData,),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Container(
            padding: EdgeInsets.only(
                left: 12.0, right: 12.0, top: 12.0, bottom: 12.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border(
                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: ListTile(
              onTap: (){
                Navigator.of(context)
                    .push(
                    new MaterialPageRoute(
                        builder: (context) => CompareOffenseListScreenFragment(ItemsOffense: widget.ItemsSuspect.Offenses)));
              },
              title: Text("จำนวนครั้งที่กระทำผิด", style: textStyleLabel,),
              subtitle: Text(widget.ItemsSuspect.Offenses.length.toString()+' ครั้ง',
                  style: textStyleData),
              trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey[400],),
            ),
          ),
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    TextStyle textStylePageName = TextStyle(color: Colors.grey[400]);
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0);
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            title: new Text("ประวัติผู้ต้องหา",
              style: styleTextAppbar,
            ),
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 34.0,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new Text(
                        'ILG60_B_04_00_09_00', style: textStylePageName,),
                    )
                  ],
                ),
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