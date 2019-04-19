import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_offense.dart';
class LawsuitNotAcceptOffenseDetailScreenFragment extends StatefulWidget {
  List<ItemsLawsuitOffense> ItemsOffense;
  int Indexs;
  String Title;
  LawsuitNotAcceptOffenseDetailScreenFragment({
    Key key,
    @required this.ItemsOffense,
    @required this.Indexs,
    @required this.Title,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<LawsuitNotAcceptOffenseDetailScreenFragment>  with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    print(widget.ItemsOffense[widget.Indexs].Number);
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
                child: Text("เลขรับคำกล่าวโทษ ", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  widget.ItemsOffense[widget.Indexs].Number,
                  style: textStyleData,),
              ),
              Container(
                padding: paddingLabel,
                child: Text("ฐานความผิดมาตรา", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  widget.ItemsOffense[widget.Indexs].SectionDetail,
                  style: textStyleData,),
              ),
              Container(
                padding: paddingLabel,
                child: Text("วันที่จับกุม", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  widget.ItemsOffense[widget.Indexs].ArrestDate,
                  style: textStyleData,),
              ),
              Container(
                padding: paddingLabel,
                child: Text("ประเภทของกลาง", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  widget.ItemsOffense[widget.Indexs].EvidenceName,
                  style: textStyleData,),
              ),
              Container(
                padding: paddingLabel,
                child: Text("สถานที่จับกุม", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  widget.ItemsOffense[widget.Indexs].ArrestPlace,
                  style: textStyleData,),
              ),
              Container(
                padding: paddingLabel,
                child: Text("เลขที่เปรียบเทียบคดี", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  widget.ItemsOffense[widget.Indexs].CompareNumber,
                  style: textStyleData,),
              ),
              Container(
                padding: paddingLabel,
                child: Text("ค่าปรับ", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  widget.ItemsOffense[widget.Indexs].Fine,
                  style: textStyleData,),
              ),
              Container(
                padding: paddingLabel,
                child: Text("คดีสิ้นสุดชั้น", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  widget.ItemsOffense[widget.Indexs].LawsuitFinal,
                  style: textStyleData,),
              ),
            ],
          ),
        ),
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
            title: new Text(widget.Title,
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
                        'ILG60_B_02_00_10_00', style: textStylePageName,),
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