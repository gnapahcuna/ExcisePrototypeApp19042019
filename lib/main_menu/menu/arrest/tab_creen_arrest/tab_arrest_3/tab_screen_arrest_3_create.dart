import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_3.dart';

class TabScreenArrest3Create extends StatefulWidget {
  List<ItemsListArrest3> Items;
  TabScreenArrest3Create({
    Key key,
    @required this.Items,
  }) : super(key: key);
  @override
  _TabScreenArrest3CreateState createState() => new _TabScreenArrest3CreateState();
}
class _TabScreenArrest3CreateState extends State<TabScreenArrest3Create> {
  TabController tabController;
  TextEditingController controller = new TextEditingController();
  List<ItemsListArrest3> _searchResult = [];

  final FocusNode myFocusNodeIdentifyNumber = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();
  final FocusNode myFocusNodePosition = FocusNode();
  final FocusNode myFocusNodeUnder = FocusNode();

  TextEditingController editIdentifyNumber = new TextEditingController();
  TextEditingController editName = new TextEditingController();
  TextEditingController editPosition = new TextEditingController();
  TextEditingController editUnder = new TextEditingController();

  String dropdownValue = 'นาย';
  List<String> dropdownItems = ['นาย','นาง','นางสาว',"รต.ต.ต."];
  @override
  void initState() {
    super.initState();
    widget.Items.forEach((item){
      editIdentifyNumber.text = item.IdentifyNumber;
      //!item.TitleName.isEmpty?dropdownValue = item.TitleName:dropdownValue=dropdownValue;
      editName.text = item.Name;
      editPosition.text = item.Position;
      editUnder.text = item.Under;
    });
  }


  @override
  void dispose() {
    super.dispose();
    myFocusNodeIdentifyNumber.dispose();
    myFocusNodeName.dispose();
    myFocusNodePosition.dispose();
    myFocusNodeUnder.dispose();
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
    /*itemsInit.forEach((userDetail) {
      if (userDetail.NumberValue.contains(text) ||
          userDetail.NumberValue.contains(text))
        _searchResult.add(userDetail);
    });*/
    setState(() {});
  }
  Widget _buildContent(BuildContext context) {
    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 80) / 100;
    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );

    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border(
              top: BorderSide(color: Colors.grey[300], width: 1.0),
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )
        ),
      width: size.width,
      child: Center(
        child: Container(
          padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
          width: Width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text("รหัสบัตรประชาชน", style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: TextField(
                  //maxLength: 14,
                  focusNode: myFocusNodeIdentifyNumber,
                  controller: editIdentifyNumber,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.words,
                  style: textInputStyle,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              _buildLine,
              Container(
                padding: paddingLabel,
                child: Text("คำนำหน้าชื่อ", style: textLabelStyle,),
              ),
              Container(
                width: Width,
                  //padding: paddingInputBox,
                  child:  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: dropdownItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                          .toList(),
                    ),
                  ),
              ),
              _buildLine,
              Container(
                padding: paddingLabel,
                child: Text("ชื่อ-นามสกุล", style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: TextField(
                  focusNode: myFocusNodeName,
                  controller: editName,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  style: textInputStyle,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              _buildLine,
              Container(
                padding: paddingLabel,
                child: Text("ตำแหน่ง", style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: TextField(
                  focusNode: myFocusNodePosition,
                  controller: editPosition,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  style: textInputStyle,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              _buildLine,
              Container(
                padding: paddingLabel,
                child: Text("หน่วยงาน", style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: TextField(
                  focusNode: myFocusNodeUnder,
                  controller: editUnder,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  style: textInputStyle,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              _buildLine,
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Card(
                        shape: new RoundedRectangleBorder(
                            side: new BorderSide(
                                color: labelColor, width: 1.5),
                            borderRadius: BorderRadius.circular(12.0)
                        ),
                        elevation: 0.0,
                        child: Container(
                          width: 100.0,
                          child: MaterialButton(
                            onPressed: () {
                              String identify = editIdentifyNumber.text;
                              String titleName = dropdownValue;
                              String name=editName.text;
                              String position=editPosition.text;
                              String under=editUnder.text;
                              String arrestType="ผู้จับกุม";
                              bool check = false;
                              List<ItemsListArrest3>items=[new ItemsListArrest3(identify, titleName, name, position, under,check,arrestType)];
                              Navigator.pop(context,items);
                            },
                            splashColor: labelColor,
                            //highlightColor: Colors.blue,
                            child: Center(
                              child: Text("บันทึก", style: textLabelStyle,),),
                          ),
                        )
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0);
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
            child: new Text("สร้างผู้จับกุม",
              style: styleTextAppbar,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context,widget.Items);
              }),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
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
                    child: new Text('ILG60_B_01_00_05_00',
                      style: TextStyle(color: Colors.grey[400]),),
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
    ),
    );
  }
}
