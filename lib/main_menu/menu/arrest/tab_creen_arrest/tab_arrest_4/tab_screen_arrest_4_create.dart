
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_4.dart';

class TabScreenArrest4Create extends StatefulWidget {
  @override
  _TabScreenArrest4CreateState createState() => new _TabScreenArrest4CreateState();
}
class _TabScreenArrest4CreateState extends State<TabScreenArrest4Create> {
  //node type1
  final FocusNode myFocusNodeIdentifyNumber = FocusNode();
  final FocusNode myFocusNodeNameSus = FocusNode();
  final FocusNode myFocusNodeNameFather_1 = FocusNode();
  final FocusNode myFocusNodeNameMother_1 = FocusNode();
  final FocusNode myFocusNodePlace = FocusNode();

  //node type1
  TextEditingController editIdentifyNumber = new TextEditingController();
  TextEditingController editNameSus = new TextEditingController();
  TextEditingController editFather = new TextEditingController();
  TextEditingController editMother = new TextEditingController();
  TextEditingController editPlace = new TextEditingController();

  //dropbox type1
  String dropdownValue_1 = 'นาย';
  List<String> dropdownItems_1 = ['นาย', 'นาง', 'นางสาว', "รต.ต.ต."];

  //node type2
  final FocusNode myFocusNodeEntityNumber = FocusNode();
  final FocusNode myFocusNodeCompanyName = FocusNode();
  final FocusNode myFocusNodeExciseRegistrationNumber = FocusNode();
  final FocusNode myFocusNodeCompanyNameTitle = FocusNode();
  final FocusNode myFocusNodeCompanyHeadName = FocusNode();
  final FocusNode myFocusNodeNameFather_2 = FocusNode();
  final FocusNode myFocusNodeNameMother_2 = FocusNode();

  //node type2
  TextEditingController editEntityNumber = new TextEditingController();
  TextEditingController editCompanyName = new TextEditingController();
  TextEditingController editExciseRegistrationNumber = new TextEditingController();
  TextEditingController editCompanyNameTitle = new TextEditingController();
  TextEditingController editCompanyHeadName = new TextEditingController();
  TextEditingController editNameFather_2 = new TextEditingController();
  TextEditingController editNameMother_2 = new TextEditingController();

  //dropbox type2
  String dropdownValue_2 = 'นาย';
  List<String> dropdownItems_2 = ['นาย', 'นาง', 'นางสาว', "รต.ต.ต."];


  bool _suspectType1 = false;
  bool _suspectType2 = false;
  bool _nationalityType1 = false;
  bool _nationalityType2 = false;

  List<ItemsListArrest4> _itemData = [];

  Future<File> _imageFile;
  List<File> _arrItemsImageFile = [];
  List<String> _arrItemsImageName = [];
  bool isImage = false;
  VoidCallback listener;

  void _onImageButtonPressed(ImageSource source, mContext) {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: source);
      _imageFile.then((f) {

        setState(() {
          List splits = f.path.split("/");
          isImage = true;
          _arrItemsImageFile.add(f.absolute);
          _arrItemsImageName.add(splits[splits.length - 1]);
        });
        //_navigateSearchFace(context, _imageFile);
      });
      //Navigator.pop(mContext);
    });
  }
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      List splits = image.path.split("/");
      isImage = true;
      _arrItemsImageName.add(splits[splits.length - 1]);
      _arrItemsImageFile.add(image);
    });
  }

  @override
  void initState() {
    super.initState();
    _suspectType1 = true;
    _nationalityType1 = true;
  }

  @override
  void dispose() {
    super.dispose();
    //node type1
    myFocusNodeIdentifyNumber.dispose();
    myFocusNodeNameSus.dispose();
    myFocusNodeNameFather_1.dispose();
    myFocusNodeNameMother_1.dispose();
    myFocusNodePlace.dispose();
    //node type2
    myFocusNodeEntityNumber.dispose();
    myFocusNodeCompanyName.dispose();
    myFocusNodeExciseRegistrationNumber.dispose();
    myFocusNodeCompanyNameTitle.dispose();
    myFocusNodeCompanyHeadName.dispose();
    myFocusNodeNameFather_2.dispose();
    myFocusNodeNameMother_2.dispose();
  }

  Widget _buildContent(BuildContext context) {
    Color labelColor = Color(0xff087de1);
    TextStyle textSearchByImgStyle = TextStyle(
        fontSize: 16.0, color: Colors.blue.shade400);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor);
    TextStyle textStyleSelect = TextStyle(fontSize: 16.0, color: Colors.black);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 80) / 100;

    return Container(
      color: Colors.grey[200],
      child: Column(
        children: <Widget>[
          Container(
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
                  padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                  width: Width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text("ประเภทผู้ต้องหา", style: textLabelStyle,),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: size.width / 2.5,
                            child: Row(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _suspectType1 = true;
                                      _suspectType2 = false;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _suspectType1
                                          ? Colors.blue
                                          : Colors
                                          .white,
                                      border: Border.all(color: Colors.black12),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: _suspectType1
                                            ? Icon(
                                          Icons.check,
                                          size: 30.0,
                                          color: Colors.white,
                                        )
                                            : Container(
                                          height: 30.0,
                                          width: 30.0,
                                          color: Colors.transparent,
                                        )
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text('บุคคลธรรมดา',
                                    style: textStyleSelect,),
                                )
                              ],
                            ),
                          ),
                          Container(
                              width: size.width / 2.5,
                              child: Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _suspectType2 = true;
                                        _suspectType1 = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _suspectType2
                                            ? Colors.blue
                                            : Colors
                                            .white,
                                        border: Border.all(
                                            color: Colors.black12),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: _suspectType2
                                              ? Icon(
                                            Icons.check,
                                            size: 30.0,
                                            color: Colors.white,
                                          )
                                              : Container(
                                            height: 30.0,
                                            width: 30.0,
                                            color: Colors.transparent,
                                          )
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text('นิติบุคคล',
                                      style: textStyleSelect,),
                                  )
                                ],
                              )
                          )
                        ],
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("ประเภทผู้ต้องหา", style: textLabelStyle,),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: size.width / 2.5,
                            child: Row(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _nationalityType1 = true;
                                      _nationalityType2 = false;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _nationalityType1
                                          ? Colors.blue
                                          : Colors
                                          .white,
                                      border: Border.all(color: Colors.black12),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: _nationalityType1
                                            ? Icon(
                                          Icons.check,
                                          size: 30.0,
                                          color: Colors.white,
                                        )
                                            : Container(
                                          height: 30.0,
                                          width: 30.0,
                                          color: Colors.transparent,
                                        )
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text('คนไทย',
                                    style: textStyleSelect,),
                                )
                              ],
                            ),
                          ),
                          Container(
                              width: size.width / 2.5,
                              child: Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _nationalityType2 = true;
                                        _nationalityType1 = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _nationalityType2
                                            ? Colors.blue
                                            : Colors.white,
                                        border: Border.all(
                                            color: Colors.black12),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: _nationalityType2
                                              ? Icon(
                                            Icons.check,
                                            size: 30.0,
                                            color: Colors.white,
                                          )
                                              : Container(
                                            height: 30.0,
                                            width: 30.0,
                                            color: Colors.transparent,
                                          )
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text('คนต่างชาติ',
                                      style: textStyleSelect,),
                                  )
                                ],
                              )
                          ),
                        ],
                      ),
                      _suspectType1 ? _buildInputType1() : _buildInputType2(),
                      Container(height: (size.height * 10) / 100,)
                    ],
                  ),
                ),
              )
          ),
          Container(
            width: size.width,
            child: _buildButtonImgPicker(),
          ),
          _buildDataImage(context),
        ],
      ),
    );
  }

  Widget _buildInputType1() {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 80) / 100;
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
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropdownValue_1,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue_1 = newValue;
                });
              },
              items: dropdownItems_1
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
            focusNode: myFocusNodeNameSus,
            controller: editNameSus,
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
          child: Text("บิดา", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeNameFather_1,
            controller: editFather,
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
          child: Text("มารดา", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeNameMother_1,
            controller: editMother,
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
          child: Text("ที่อยู่สถานที่ประกอบ (ตำบล/อำเภอ/จังหวัด)",
            style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodePlace,
            controller: editPlace,
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
    );
  }

  Widget _buildInputType2() {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 80) / 100;
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
          child: Text("เลขนิติบุคคล", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            //maxLength: 14,
            focusNode: myFocusNodeEntityNumber,
            controller: editEntityNumber,
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
          child: Text("เลขทะเบียนสรรพสามิตย์", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeExciseRegistrationNumber,
            controller: editExciseRegistrationNumber,
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
          child: Text("ชื่อสถานประกอบการ", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeCompanyName,
            controller: editCompanyName,
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
          child: Text(
            "คำนำหน้าชื่อตัวแทนสถานประกอบการ", style: textLabelStyle,),
        ),
        Container(
          width: Width,
          //padding: paddingInputBox,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropdownValue_2,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue_2 = newValue;
                });
              },
              items: dropdownItems_2
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
            "ชื่อ-นามสกุลตัวแทนสถานประกอบการ", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeCompanyHeadName,
            controller: editCompanyHeadName,
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
          child: Text("บิดา", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeNameFather_2,
            controller: editNameFather_2,
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
          child: Text("มารดา", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeNameMother_2,
            controller: editNameMother_2,
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
    );
  }

  Widget _buildButtonImgPicker() {
    var size = MediaQuery
        .of(context)
        .size;
    Color labelColor = Color(0xff087de1);
    Color boxColor = Colors.grey[300];
    Color uploadColor = Color(0xff31517c);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: uploadColor);
    return Container(
      padding: EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Card(
              shape: new RoundedRectangleBorder(
                  side: new BorderSide(
                      color: boxColor, width: 1.5),
                  borderRadius: BorderRadius.circular(42.0)
              ),
              elevation: 0.0,
              child: Container(
                width: size.width / 2,
                child: MaterialButton(
                  onPressed: () {
                    //_onImageButtonPressed(ImageSource.gallery, context);
                    getImage();
                  },
                  splashColor: Colors.grey,
                  child: Container(
                      padding: EdgeInsets.only(top: 18.0, bottom: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            //padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.file_upload, size: 32, color: uploadColor,),
                          ),
                          Container(
                            //padding: EdgeInsets.all(4.0),
                            child: Text(
                              "แนบรูปผู้ต้องหา", style: textLabelStyle,),
                          ),

                        ],
                      )
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
  Widget _buildDataImage(BuildContext context) {
    TextStyle textInputStyleTitle = TextStyle(
        fontSize: 16.0, color: Colors.black);
    return Container(
      padding: EdgeInsets.only(bottom: 22.0),
      child: ListView.builder(
          itemCount: _arrItemsImageFile.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(top: 0.3, bottom: 0.3),
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: ListTile(
                    leading: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.white30),
                      ),
                      //margin: const EdgeInsets.only(top: 32.0, left: 16.0),
                      padding: const EdgeInsets.all(3.0),
                      child: Image.file(_arrItemsImageFile[index],fit: BoxFit.cover,),
                    ),
                    title: Text(_arrItemsImageName[index],
                      style: textInputStyleTitle,),
                    trailing: new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: Icon(Icons.delete_outline,size: 32.0,),
                        onPressed: (){
                          setState(() {
                            //print(index.toString());
                            _arrItemsImageFile.removeAt(index);
                            _arrItemsImageName.removeAt(index);
                            if(_arrItemsImageFile.length==0){
                              isImage=false;
                            }
                          });
                        },
                      ),
                    ),
                    onTap: () {
                      //
                    }
                ),
              ),
            );
          }
      ),
    );
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
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            title: new Padding(
              padding: EdgeInsets.only(right: 22.0),
              child: new Text("สร้างผู้ต้องหา",
                style: styleTextAppbar,
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context, _itemData);
                }),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  String SuspectType;
                  String IdentifyNumber;
                  String NationalityType;
                  String NameTitle;
                  String NameSus;
                  String NameFather;
                  String NameMother;
                  String Place;
                  int OffenseCount = 0;
                  bool isCheck = false;

                  String EntityNumber;
                  String CompanyName;
                  String ExciseRegistrationNumber;

                  if (_nationalityType1) {
                    NationalityType = "คนไทย";
                  } else {
                    NationalityType = "คนต่างชาติ";
                  }
                  if (_suspectType1) {
                    SuspectType = "บุคคลธรรมดา";
                    IdentifyNumber = editIdentifyNumber.text;
                    NameTitle = dropdownValue_1;
                    NameSus = editNameSus.text;
                    NameFather = editFather.text;
                    NameMother = editMother.text;
                    Place = editPlace.text;
                    EntityNumber = null;
                    CompanyName = null;
                    ExciseRegistrationNumber = null;
                  } else {
                    SuspectType = "นิติบุคคล";
                    IdentifyNumber = null;
                    NameTitle = dropdownValue_2;
                    NameSus = editCompanyHeadName.text;
                    NameFather = editNameFather_2.text;
                    NameMother = editNameMother_2.text;
                    Place = null;
                    EntityNumber = editEntityNumber.text;
                    CompanyName = editCompanyName.text;
                    ExciseRegistrationNumber =
                        editExciseRegistrationNumber.text;
                  }
                  _itemData.add(new ItemsListArrest4(
                      SuspectType,
                      NationalityType,
                      IdentifyNumber,
                      NameTitle,
                      NameSus,
                      NameFather,
                      NameMother,
                      Place,
                      OffenseCount,
                      isCheck,
                      EntityNumber,
                      CompanyName,
                      ExciseRegistrationNumber,
                      "",
                      0));
                  Navigator.pop(context, _itemData);
                },
                child: Text("บันทึก",
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
                          child: new Text('ILG60_B_01_00_06_00',
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
                      child: Column(
                        children: <Widget>[
                          _buildContent(context),
                        ],
                      )
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