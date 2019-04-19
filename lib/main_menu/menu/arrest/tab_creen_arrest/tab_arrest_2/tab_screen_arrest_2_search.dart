import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_2.dart';
import 'package:expandable/expandable.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;

class TabScreenArrest2Search extends StatefulWidget {
  @override
  _TabScreenArrest2SearchState createState() => new _TabScreenArrest2SearchState();
}
class _TabScreenArrest2SearchState extends State<TabScreenArrest2Search> {
  Future<List<ItemsList>> apiRequest(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestNoticegetByKeyword",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsList.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }


  TabController tabController;
  TextEditingController controller = new TextEditingController();
  List<ItemsList> _searchResult = [];
  int _countItem = 0;
  List<ItemsList> _itemsData = [];
  List<bool> _value = [];

  @override
  void initState() {
    super.initState();
  }

  CupertinoAlertDialog _createCupertinoCancelDeleteDialog(){
    TextStyle TitleStyle = TextStyle(fontSize: 16.0,);
    TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold,);
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 22.0, bottom: 22.0),
          child: Text("ไม่พบใบแจ้งความ",
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }
  void _showSearchEmptyAlertDialog(mContext) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelDeleteDialog();
      },
    );
  }

  //on show dialog
  Future<bool> onLoadAction(Map map) async {
    await apiRequest(map).then((onValue) {
      _searchResult = onValue;
    });
    setState(() {});
    return true;
  }

  //on submitted search
  onSearchTextSubmitted(String text, mContext) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    Map map = {'TEXT_SEARCH': text};
    await onLoadAction(map);
    Navigator.pop(context);
    if (_searchResult.length == 0) {
      _showSearchEmptyAlertDialog(mContext);
    }
  }

  buildCollapsedNonCheck(index,expandContext) {
    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 6.0, bottom: 6.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
    var size = MediaQuery
        .of(context)
        .size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: paddingLabel,
                child: Text("เลขที่ใบจับกุม", style: textLabelStyle,),
              ),
            ),
            Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _searchResult[index].IsCheck =
                      !_searchResult[index].IsCheck;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: _searchResult[index].IsCheck
                          ? Color(0xff3b69f3)
                          : Colors.white,
                      border: _searchResult[index].IsCheck
                          ? Border.all(color: Color(0xff3b69f3), width: 2)
                          : Border.all(color: Colors.grey[400], width: 2),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: _searchResult[index].IsCheck
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
            _searchResult[index].NOTICE_CODE, style: textInputStyle,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้รับแจ้งความ", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: Text(
            _searchResult[index].STAFF_TITLE_SHORT_NAME_TH +
                _searchResult[index].STAFF_FIRST_NAME + " " +
                _searchResult[index].STAFF_LAST_NAME
            , style: textInputStyle,),
        ),

      ],
    );
  }
  buildCollapsedChecked(index,expandContext) {
    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 6.0, bottom: 6.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: paddingLabel,
                child: Text("เลขที่ใบจับกุม", style: textLabelStyle,),
              ),
            ),
            Center(
              child : Builder(
                builder: (context) {
                  var exp = ExpandableController.of(context);
                  return InkWell(
                    onTap: () {
                      exp.toggle();
                      setState(() {
                        _searchResult[index].IsCheck = !_searchResult[index].IsCheck;
                        exp.expanded;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: _searchResult[index].IsCheck
                            ? Color(0xff3b69f3)
                            : Colors.white,
                        border: _searchResult[index].IsCheck
                            ?Border.all(color: Color(0xff3b69f3),width: 2)
                            :Border.all(color: Colors.grey[400],width: 2),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: _searchResult[index].IsCheck
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
                  );
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: paddingInputBox,
          child: Text(
            _searchResult[index].NOTICE_CODE, style: textInputStyle,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้รับแจ้งความ", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: Text(
            _searchResult[index].STAFF_TITLE_SHORT_NAME_TH +
                _searchResult[index].STAFF_FIRST_NAME + " " +
                _searchResult[index].STAFF_LAST_NAME
            , style: textInputStyle,),
        ),

      ],
    );
  }
  buildExpandedChecked(index,expandContext) {
    String suspect_name;
    String middle;
    String other;
    _searchResult[index].SUSPECT_MIDDLE_NAME==null?middle="":middle=_searchResult[index].SUSPECT_MIDDLE_NAME;
    _searchResult[index].SUSPECT_OTHER_NAME==null?other="":other=_searchResult[index].SUSPECT_OTHER_NAME;

    suspect_name=_searchResult[index].SUSPECT_TITLE_SHORT_NAME_TH+
        _searchResult[index].SUSPECT_FIRST_NAME+" "+middle+
        _searchResult[index].SUSPECT_LAST_NAME+" "+other;

    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 6.0, bottom: 6.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: paddingLabel,
                child: Text("เลขที่ใบจับกุม", style: textLabelStyle,),
              ),
            ),
            Center(
              child : Builder(
                builder: (context) {
                  var exp = ExpandableController.of(context);
                  return InkWell(
                    onTap: () {
                      exp.toggle();
                      setState(() {
                        _searchResult[index].IsCheck = !_searchResult[index].IsCheck;
                        exp.expanded;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: _searchResult[index].IsCheck
                            ? Color(0xff3b69f3)
                            : Colors.white,
                        border: _searchResult[index].IsCheck
                            ?Border.all(color: Color(0xff3b69f3),width: 2)
                            :Border.all(color: Colors.grey[400],width: 2),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: _searchResult[index].IsCheck
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
                  );
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: paddingInputBox,
          child: Text(
            _searchResult[index].NOTICE_CODE, style: textInputStyle,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้รับแจ้งความ", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: Text(
            _searchResult[index].STAFF_TITLE_SHORT_NAME_TH +
                _searchResult[index].STAFF_FIRST_NAME + " " +
                _searchResult[index].STAFF_LAST_NAME
            , style: textInputStyle,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้ต้องสงสัย", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: Text(
            suspect_name, style: textInputStyle,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("วันที่แจ้งความ", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: Text(
            _searchResult[index].NOTICE_DATE, style: textInputStyle,),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    Color labelColor = Color(0xff087de1);
    TextStyle textExpandStyle = TextStyle(fontSize: 16.0, color: labelColor);
    return ListView.builder(
      itemCount: _searchResult.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Container(
            padding: EdgeInsets.all(18.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border(
                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: !_searchResult[index].IsCheck ? buildCollapsedNonCheck(index, context)
                :
            ExpandableNotifier(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expandable(
                    collapsed: buildExpandedChecked(index, context),
                    expanded: buildCollapsedChecked(index, context),
                  ),
                  _searchResult[index].IsCheck ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Builder(
                        builder: (context) {
                          var exp = ExpandableController.of(context);
                          return FlatButton(
                              onPressed: () {
                                exp.toggle();
                              },
                              child: Text(
                                exp.expanded ? "ดูเพิ่มเติม..." : "ย่อ...",
                                style: textExpandStyle,
                              )
                          );
                        },
                      ),
                    ],
                  ) : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget _buildBottom(){
    var size = MediaQuery
        .of(context)
        .size;
    TextStyle textStyleButton = TextStyle(color: Colors.white, fontSize: 18.0);
    bool isCheck =false;
    _countItem=0;
    _searchResult.forEach((item){
      if(item.IsCheck)
        setState(() {
          isCheck=item.IsCheck;
          _countItem++;
        });

    });
    return  isCheck ? Container(
      width: size.width,
      height: 65,
      color: Color(0xff2e76bc),
      child: MaterialButton(
        onPressed: () {
          _searchResult.forEach((item){
            if(item.IsCheck)
              _itemsData.add(item);
          });
          Navigator.pop(context,_itemsData);
        },
        child: Center(
          child: Text('เลือก (${_countItem})', style: textStyleButton,),
        ),
      ),
    ) : null;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextSearch = TextStyle(fontSize: 16.0);
    return new WillPopScope(
        onWillPop: () {
      //
    },
    child: new Theme(
      data: new ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.white,
          hintColor: Colors.grey[400]
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0), // here the desired height
          child: AppBar(
            title: new Padding(
              padding: EdgeInsets.only(right: 22.0),
              child: new Row(children: <Widget>[
                new SizedBox(width: 10.0,),
                new Expanded(child: new Stack(
                    alignment: const Alignment(1.0, 1.0),
                    children: <Widget>[
                      new TextField(
                        decoration: InputDecoration(
                          hintText: 'ค้นหา', hintStyle: styleTextSearch,),
                        onChanged: (text) {
                          setState(() {
                            print(text);
                          });
                        },
                        onSubmitted: (String text) {
                          onSearchTextSubmitted(text, context);
                        },
                        controller: controller,),
                      controller.text.length > 0 ? new IconButton(
                          icon: new Icon(Icons.clear), onPressed: () {
                        setState(() {
                          controller.clear();
                        });
                      }) : new Container(height: 0.0,)
                    ]
                ),),
              ],
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,), onPressed: () {
              Navigator.pop(context,_itemsData);
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
                      //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new Text('ILG60_B_01_00_24_00',
                        style: TextStyle(color: Colors.grey[400]),),
                    )
                  ],
                ),
              ),
              Expanded(
                child: _searchResult.length != 0 || controller.text.isNotEmpty
                    ? _buildSearchResults() : new Container(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottom(),
      ),
    ),
    );
  }
}
