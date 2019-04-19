
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_4.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_create.dart';

class TabScreenArrest4Search extends StatefulWidget {
  @override
  _TabScreenArrest4SearchState createState() => new _TabScreenArrest4SearchState();
}
class _TabScreenArrest4SearchState extends State<TabScreenArrest4Search> {
  List<ItemsListArrest4> _itemsInit = [
    new ItemsListArrest4(
        null,
        null,
        null,
        "นาย",
        "สมพงษ์ ชาติชาย",
        null,
        null,
        null,
        2,
        false,null,null,null,"",0),
    new ItemsListArrest4(
        null,
        null,
        null,
        "นาย",
        "เสนาะ อุตะมา",
        null,
        null,
        null,
        4,
        false,null,null,null,"",0)
  ];
  int _countItem = 0;
  List<ItemsListArrest4> _itemsData = [];
  List<bool> _value = [];

  @override
  void initState() {
    super.initState();
  }

  Widget _buildSearchResults() {
    Color labelColor = Colors.grey[500];
    Color labelPreview = Color(0xff2e76bc);
    TextStyle textInputStyleTitle = TextStyle(
        fontSize: 16.0, color: Colors.black);
    TextStyle textInputStyleSub = TextStyle(fontSize: 14.0, color: labelColor);
    TextStyle textPreviewStyle = TextStyle(fontSize: 14.0, color: labelPreview);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
    return ListView.builder(
      itemCount: _itemsInit.length,
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
                        child: Text(_itemsInit[index].NameTitle + ' ' +
                            _itemsInit[index].NameSus,
                          style: textInputStyleTitle,),
                      ),
                    ),
                    Center(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _itemsInit[index].isCheck =
                              !_itemsInit[index].isCheck;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: _itemsInit[index].isCheck
                                  ? Color(0xff3b69f3)
                                  : Colors.white,
                              border: _itemsInit[index].isCheck
                                  ?Border.all(color: Color(0xff3b69f3),width: 2)
                                  :Border.all(color: Colors.grey[400],width: 2),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: _itemsInit[index].isCheck
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
                    "จำนวนครั้งการกระทำผิด " +
                        _itemsInit[index].OffenseCount.toString() + " ครั้ง",
                    style: textInputStyleSub,),
                ),
                _itemsInit[index].isCheck?Row(
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
    _itemsInit.forEach((item) {
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
          _itemsInit.forEach((item) {
            if (item.isCheck)
              _itemsData.add(item);
          });
          Navigator.pop(context, _itemsData);
        },
        child: Center(
          child: Text('เลือก (${_countItem})', style: textStyleButton,),
        ),
      ),
    ) : null;
  }
  _navigateCreaet(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenArrest4Create()),
    );
    _itemsData=result;
    Navigator.pop(context,_itemsData);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white);
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: new Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            title: new Padding(
              padding: EdgeInsets.only(right: 22.0),
              child: new Text("ค้นหาผู้ต้องหา",
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
            actions: <Widget>[
              new FlatButton(
                onPressed: (){
                  _navigateCreaet(context);
                },
                child: Text("สร้าง",
                  style: styleTextAppbar,
                ),
              ),
            ],
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
              Expanded(
                child: SingleChildScrollView(
                  child: _buildSearchResults(),
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