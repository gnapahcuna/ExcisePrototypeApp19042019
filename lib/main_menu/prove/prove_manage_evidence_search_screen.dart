import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_5.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_creen_arrest/tab_arrest_5/tab_screen_arrest_5_search.dart';
import 'package:prototype_app_pang/main_menu/prove/model/evidence.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_manage_evidence_select_evidence_screen.dart';

class ProveManageEvidenceSearchScreenFragment extends StatefulWidget {
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<ProveManageEvidenceSearchScreenFragment> {
  ItemsEvidence _itemsData;

  final FocusNode myFocusNodeMainBrand = FocusNode();
  final FocusNode myFocusNodeSecondaryBrand = FocusNode();
  final FocusNode myFocusNodeProductModel = FocusNode();
  final FocusNode myFocusNodeCapacity = FocusNode();

  TextEditingController editMainBrand = new TextEditingController();
  TextEditingController editSecondaryBrand = new TextEditingController();
  TextEditingController editProductModel = new TextEditingController();
  TextEditingController editCapacity = new TextEditingController();

  List<String> dropdownItemsUnit = ["ขวด", 'ลัง', 'ลิตร'];
  List<String> dropdownItemsProductGroup = ["สุรา", 'เบียร์'];
  List<String> dropdownItemsProductCategory = ["สุราแช่"];
  List<String> dropdownItemsProductType = ["ชนิดเบียร์"];
  List<String> dropdownItemsSubProductType = [];
  List<String> dropdownItemsSubSetProductType = [];

  String dropdownValueUnit = "ขวด";
  String dropdownValueProductGroup = "สุรา";
  String dropdownValueProductCategory = "สุราแช่";
  String dropdownValueProductType = "ชนิดเบียร์";
  String dropdownValueSubProductType;
  String dropdownValueSubSetProductType;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildContent(BuildContext context) {
    Color labelColor = Color(0xff087de1);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor);
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 85) / 100;
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
                _buildInput(),
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
                                _navigate(context);
                              },
                              splashColor: Colors.grey,
                              child: Center(
                                child: Text("ค้นหา", style: textLabelStyle,),),
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

  Widget _buildInput() {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 100) / 100;
    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text(
            "หมวดหมู่สินค้า", style: textLabelStyle,),
        ),
        Container(
          width: Width,
          //padding: paddingInputBox,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropdownValueProductGroup,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueProductGroup = newValue;
                });
              },
              items: dropdownItemsProductGroup
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
          child: Text(
            "กลุ่มสินค้า", style: textLabelStyle,),
        ),
        Container(
          width: Width,
          //padding: paddingInputBox,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropdownValueProductCategory,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueProductCategory = newValue;
                });
              },
              items: dropdownItemsProductCategory
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
          child: Text(
            "ประเภทสินค้า", style: textLabelStyle,),
        ),
        Container(
          width: Width,
          //padding: paddingInputBox,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropdownValueProductType,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueProductType = newValue;
                });
              },
              items: dropdownItemsProductType
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
          child: Text(
            "ประเภทย่อยสินค้า", style: textLabelStyle,),
        ),
        Container(
          width: Width,
          //padding: paddingInputBox,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropdownValueSubProductType,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueSubProductType = newValue;
                });
              },
              items: dropdownItemsSubSetProductType
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
          child: Text(
            "เซตประเภทย่อยสินค้า", style: textLabelStyle,),
        ),
        Container(
          width: Width,
          //padding: paddingInputBox,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropdownValueSubSetProductType,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueSubSetProductType = newValue;
                });
              },
              items: dropdownItemsSubSetProductType
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
          child: Text(
            "ยี่ห้อหลักสินค้า", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeMainBrand,
            controller: editMainBrand,
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
          child: Text("ยี่ห้อรองสินค้า", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeSecondaryBrand,
            controller: editSecondaryBrand,
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
          child: Text("รุ่นสินค้า", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeProductModel,
            controller: editProductModel,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        /*widget.IsScientific?Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: ((size.width * 75) / 100) / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("ขนาดบรรจุ", style: textLabelStyle,),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: TextField(
                      focusNode: myFocusNodeCapacity,
                      controller: editCapacity,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      style: textInputStyle,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  _buildLine,
                ],
              ),
            ),
            Container(
              width: ((size.width * 75) / 100) / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("หน่วย", style: textLabelStyle,),
                  ),
                  Container(
                    width: Width,
                    //padding: paddingInputBox,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: dropdownValueUnit,
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValueUnit = newValue;
                          });
                        },
                        items: dropdownItemsUnit
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
                ],
              ),
            ),
          ],
        ):Container(),*/
      ],
    );
  }

  _navigate(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProveManageSelectEvidenceScreenFragment()),
    );
    if(result.toString()!="Back"){
      _itemsData = result;
      Navigator.pop(context,result);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white);
    return new WillPopScope(
      onWillPop: () {
        //
      }, child: Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          title: new Text("ค้นหาของกลาง",
            style: styleTextAppbar,
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context, "Back");
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
                        child: new Text('ILG60_B_03_00_07_00',
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
                    child: _buildContent(context),
                  )
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}