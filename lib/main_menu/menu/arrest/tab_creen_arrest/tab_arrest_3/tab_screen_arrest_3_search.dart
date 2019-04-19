import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_3.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_creen_arrest/tab_arrest_3/tab_screen_arrest_3_create.dart';

class TabScreenArrest3Search extends StatefulWidget {
  @override
  _TabScreenArrest3SearchState createState() => new _TabScreenArrest3SearchState();
}
class _TabScreenArrest3SearchState extends State<TabScreenArrest3Search> {
  TabController tabController;
  TextEditingController controller = new TextEditingController();
  final FocusNode myFocusNodeSearch = FocusNode();
  List<ItemsListArrest3> _searchResult = [];
  List<ItemsListArrest3> _itemsInit = [
    new ItemsListArrest3("148123123123","รต.ต.ต","สมพงษ์ ชาติชาย", "เจ้าหน้าที่ตำรวจ","กองบัญชาการตำรวจนครบาล",false,"ผู้จับกุม"),
    new ItemsListArrest3("148123123124","พต.ต.ต","สมพงษ์ ชิงดวง", "เจ้าหน้าที่ทหาร","กองบัญชาการสงครามพิเศษทางเรือ",false,"ผู้จับกุม")
  ];
  int _countItem = 0;
  List<ItemsListArrest3> _itemsData = [];
  List<bool> _value = [];

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
    myFocusNodeSearch.dispose();
  }

  onSearchTextChanged(String text) async {
    print(text);
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    /*for(int i=0;i<_items.length;i++){
      if (_items[i].contains(text) ||
          _searchDetails[i].contains(text)) {
        _searchResult.add(_searchDetails[i]);
        _searchResult1.add(_searchDetails1[i]);
      }
    }*/
    _itemsInit.forEach((userDetail) {
      if (userDetail.Name.contains(text) ||
          userDetail.Name.contains(text))
        _searchResult.add(userDetail);
    });
    setState(() {});
  }

  Widget _buildSearchResults() {
    Color labelColor = Colors.grey[500];
    TextStyle textInputStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black);
    TextStyle textInputStyleSub = TextStyle(fontSize: 14.0, color: labelColor);
    TextStyle textLabelEditCheckedStyle = TextStyle(fontSize: 16.0, color: Colors.red);
    TextStyle textLabelEditNonCheckStyle = TextStyle(fontSize: 16.0, color: Colors.red[100]);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
    var size = MediaQuery
        .of(context)
        .size;
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: paddingLabel,
                        child: Text(_searchResult[index].TitleName+' '+_searchResult[index].Name, style: textInputStyleTitle,),
                      ),
                    ),
                    Center(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _searchResult[index].isCheck = !_searchResult[index].isCheck;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: _searchResult[index].isCheck
                                  ? Color(0xff3b69f3)
                                  : Colors.white,
                              border: _searchResult[index].isCheck
                                  ?Border.all(color: Color(0xff3b69f3),width: 2)
                                  :Border.all(color: Colors.grey[400],width: 2),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: _searchResult[index].isCheck
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
                    _searchResult[index].Position, style: textInputStyleSub,),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: paddingInputBox,
                        child: Text(
                          _searchResult[index].Under, style: textInputStyleSub,),
                      ),
                    ),
                    Center(
                        child: InkWell(
                          onTap: () {
                            _searchResult[index].isCheck?_navigateEdit(context,index):null;
                          },
                          child: Container(
                              child: Text("แก้ไข",style: _searchResult[index].isCheck?textLabelEditCheckedStyle:textLabelEditNonCheckStyle,)
                          ),
                        )
                    ),
                  ],
                )
              ],
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
      if(item.isCheck)
        setState(() {
          isCheck=item.isCheck;
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
            if(item.isCheck)
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
  _navigateCreate(BuildContext context) async {
    List<ItemsListArrest3>item=[];
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenArrest3Create(Items: item,)),
    );
    /*setState(() {
      _searchResult=result;
    });*/
    _searchResult=result;
  }
  _navigateEdit(BuildContext context,index) async {
    List<ItemsListArrest3>item = [new ItemsListArrest3(
        _searchResult[index].IdentifyNumber,
        _searchResult[index].TitleName,
        _searchResult[index].Name,
        _searchResult[index].Position,
        _searchResult[index].Under,
        _searchResult[index].isCheck,
        _searchResult[index].ArrestType
    )
    ];
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest3Create(Items: item,)),
    );
    /*setState(() {
      _searchResult=result;
    });*/
    _searchResult = result;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextSearch = TextStyle(fontSize: 16.0);
    TextStyle textStyleCreate = TextStyle(color: Color(0xff087de1), fontSize: 18.0);
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
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            title: new Padding(
                padding: EdgeInsets.only(right: 0.0),
              child: new TextField(
                style: styleTextSearch,
                controller: controller,
                focusNode: myFocusNodeSearch,
                decoration: new InputDecoration(
                  hintText: "ค้นหา",
                  hintStyle: styleTextSearch,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]),
                  ),
                ),
                onChanged: onSearchTextChanged,
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,), onPressed: () {
              Navigator.pop(context,_itemsData);
            }),
            actions: <Widget>[
              new Center(
                  child: new FlatButton(onPressed: (){
                    _navigateCreate(context);
                  }, child: new Text("สร้าง",style: textStyleCreate),)
              ),
            ],
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
                      child: new Text('ILG60_B_01_00_01_00',
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
