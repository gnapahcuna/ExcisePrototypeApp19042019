import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_6_section.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_6_suspect.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_evidence.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;

class TabScreenArrest6Section extends StatefulWidget {
  String Title;
  TabScreenArrest6Section({
    Key key,
    @required this.Title,
  }) : super(key: key);
  @override
  _TabScreenArrest6SectionState createState() => new _TabScreenArrest6SectionState();
}
class _TabScreenArrest6SectionState extends State<TabScreenArrest6Section>  {
  TabController tabController;
  TextEditingController controller = new TextEditingController();
  int _countItem = 0;
  List<ItemsListArrest6Suspect> _itemsData = [];
  List<bool> _value = [];
  bool isCheckAll=false;

  List<ItemsListArrest6Suspect>ItemsSuspect=[];

  Future<List<ItemsListArrest6Section>> apiRequest(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestMasGuiltbasegetByKeyword",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    print(response.body.toString());
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsListArrest6Section.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
  }
  Widget _buildContent(BuildContext context) {
    Color labelColor = Colors.grey[500];
    Color labelPreview = Color(0xff2e76bc);
    TextStyle textInputStyleTitle = TextStyle(
        fontSize: 16.0, color: Colors.black);
    TextStyle textInputStyleSub = TextStyle(fontSize: 14.0, color: labelColor);
    TextStyle textPreviewStyle = TextStyle(fontSize: 14.0, color: labelPreview);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
    return ListView.builder(
      itemCount: ItemsSuspect.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Container(
            padding: EdgeInsets.all(22.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border(
                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: paddingLabel,
                        child: Text(ItemsSuspect[index].NameSuspect,
                          style: textInputStyleTitle,),
                      ),
                    ),
                    Center(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              ItemsSuspect[index].isCheck =
                              !ItemsSuspect[index].isCheck;

                              int count = 0;
                              ItemsSuspect.forEach((ev){
                                if(ev.isCheck){
                                  count++;
                                }
                              });
                              count==ItemsSuspect.length?isCheckAll=true:isCheckAll=false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: ItemsSuspect[index].isCheck
                                  ? Color(0xff3b69f3)
                                  : Colors.white,
                              border: ItemsSuspect[index].isCheck
                                  ?Border.all(color: Color(0xff3b69f3),width: 2)
                                  :Border.all(color: Colors.grey[400],width: 2),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: ItemsSuspect[index].isCheck
                                    ? Icon(
                                  Icons.check,
                                  size: 18.0,
                                  color: Colors.white,
                                )
                                    : Container(
                                  height: 18.0,
                                  width: 18.0,
                                  color: Colors.transparent,
                                )
                            ),
                          ),
                        )
                    ),
                  ],
                ),
                Padding(
                  padding: paddingInputBox,
                  child: Text(
                    "จำนวนครั้งการกระทำผิด " + ItemsSuspect[index].OffenseCount.toString() + " ครั้ง",
                    style: textInputStyleSub,),
                ),
                ItemsSuspect[index].isCheck?Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Center(
                        child: InkWell(
                          onTap: () {
                            /*setState(() {
                              _itemsData.removeAt(index);
                            });*/
                          },
                          child: Container(
                              child: Text("ดูประวัติผู้ต้องหา", style: textPreviewStyle,)
                          ),
                        )
                    ),
                  ],
                ):Container(),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _buildBottom() {
    var size = MediaQuery
        .of(context)
        .size;
    TextStyle textStyleButton = TextStyle(color: Colors.white, fontSize: 18.0);
    bool isCheck = false;
    _countItem = 0;
    ItemsSuspect.forEach((item) {
      if (item.isCheck)
        setState(() {
          isCheck = item.isCheck;
          _countItem++;
        });
    });
    return isCheck ? Container(
      width: size.width,
      height: 65,
      color: Color(0xff2e76bc),
      child: MaterialButton(
        onPressed: () {
          ItemsSuspect.forEach((item) {
            if (item.isCheck)
              _itemsData.add(item);
          });
          //Navigator.pop(context, _itemsData);
          _navigateEvidence(context);
        },
        child: Center(
          child: Text('ถัดไป (${_countItem})', style: textStyleButton,),
        ),
      ),
    ) : null;
  }

  _navigateEvidence(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenArrest6Evidence(Title: widget.Title,ItemsSuspect: ItemsSuspect,)),
    );
    //print("result section: "+result.toString());
    if(result.toString()!="back"){
      //_itemsData = result;
      Navigator.pop(context,result);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white);
    Color labelColor= Color(0xff2e76bc);
    TextStyle textInputStyleCheckAll = TextStyle(
        fontSize: 16.0, color:labelColor);
    var size = MediaQuery
        .of(context)
        .size;
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
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
                  Navigator.pop(context, "back");
                }),
          ),
        ),
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
                          child: new Text('ILG60_B_01_00_01_00',
                            style: TextStyle(color: Colors.grey[400]),),
                        ),
                      ],
                    ),
                    ],
                  )
              ),
              Container(
                padding: EdgeInsets.only(left: 22.0,right: 22.0,bottom: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: Text("เลือกผู้ต้องหาทั้งหมด",
                        style: textInputStyleCheckAll,),
                      padding: EdgeInsets.all(8.0),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isCheckAll =
                          !isCheckAll;
                          if(isCheckAll){
                            ItemsSuspect.forEach((item) {
                              item.isCheck=true;
                            });
                          }else{
                            ItemsSuspect.forEach((item) {
                              item.isCheck=false;
                            });
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: isCheckAll
                              ? Color(0xff3b69f3)
                              : Colors.grey[200],
                          border: isCheckAll
                              ?Border.all(color: Color(0xff3b69f3),width: 2)
                              :Border.all(color: Colors.grey[400],width: 2),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: isCheckAll
                                ? Icon(
                              Icons.check,
                              size: 18.0,
                              color: Colors.white,
                            )
                                : Container(
                              height: 18.0,
                              width: 18.0,
                              color: Colors.transparent,
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: new ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: SingleChildScrollView(
                    child: _buildContent(context),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottom(),
      ),
    );
  }
}
