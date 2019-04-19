import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/lawsuit_accept_case_screen.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_sentence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_main.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_creen_arrest/tab_arrest_1/tab_screen_arrest_1_saved_constants.dart';
import 'package:prototype_app_pang/picker/date_picker.dart';

class LawsuitAcceptSentenceScreenFragment extends StatefulWidget {
  ItemsLawsuitSentence ItemSentence;
  LawsuitAcceptSentenceScreenFragment({
    Key key,
    @required this.ItemSentence,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<LawsuitAcceptSentenceScreenFragment>  with TickerProviderStateMixin {
  //เมื่อบันทึกข้อมูล
  bool _onSaved = false;
  bool _onSave = false;
  //เมื่อแก้ไขข้อมูล
  bool _onEdited = false;
  //เมื่อลบข้อมูล
  bool _onDeleted = false;
  //เมื่อทำรายการเสร็จ
  bool _onFinish = false;
  //ศาลยกฟ้อง
  bool _isDismissed=false;
  //สั่งปรับ
  bool _isFine=true;
  //สั่งจำคุก
  bool _isImprison=false;
  //จ่ายครั้งเดียว
  bool _isOneTime=true;
  //แบ่งจ่ายเป็นงวด
  bool _isPeriod=false;

  //dropdown หน่วยการชำระเงินเป็นงวด
  String dropdownValueFine = 'วัน';
  List<String> dropdownItemsFine = ['วัน', 'เดือน', 'ปี'];
  //dropdown หน่วยการสั่งจำคุก
  String dropdownValueImprison = 'วัน';
  List<String> dropdownItemsImprison = ['วัน', 'เดือน', 'ปี','ตลอดชีวิต'];

  //node focus
  final FocusNode myFocusNodeCourtName = FocusNode();
  final FocusNode myFocusNodeUndecidedCase = FocusNode();
  final FocusNode myFocusNodeDecidedCase = FocusNode();
  final FocusNode myFocusNodeFineValue= FocusNode();
  final FocusNode myFocusNodeImprison= FocusNode();
  final FocusNode myFocusNodePeriod= FocusNode();
  final FocusNode myFocusNodePeriodNum= FocusNode();

  //textfield
  TextEditingController editCourtName = new TextEditingController();
  TextEditingController editUndecidedCase= new TextEditingController();
  TextEditingController editDecidedCase= new TextEditingController();
  TextEditingController editFineValue= new TextEditingController();
  TextEditingController editImprison= new TextEditingController();
  TextEditingController editPeriod= new TextEditingController();
  TextEditingController editPeriodNum= new TextEditingController();

  //วันเดือนปี เวลา ปัจจุบัน
  String _currentDate,_currentTime;
  var dateFormatDate,dateFormatTime;
  DateTime _initDate=DateTime.now();
  //วันที่กำหนดชำระค่าปรับ
  String _currentDateFine;
  DateTime _dtDateFine=DateTime.now();

  //รูปภาพ
  Future<File> _imageFile;
  List<File> _arrItemsImageFile = [];
  List<String> _arrItemsImageName = [];
  bool isImage = false;
  VoidCallback listener;

  //model คำพิพากษาศาล
  ItemsLawsuitSentence itemMain;

  //style text
  TextStyle textStyleLabel = TextStyle(
      fontSize: 16, color: Color(0xff087de1));
  TextStyle textStyleData = TextStyle(fontSize: 18, color: Colors.black);
  TextStyle textStyleData1 = TextStyle(fontSize: 16, color: Colors.black);
  TextStyle textStyleSubData = TextStyle(fontSize: 16, color: Colors.black38);
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400]);
  TextStyle textStyleStar = TextStyle(color: Colors.red);
  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
  TextStyle textStyleSub = TextStyle(fontSize: 16, color: Colors.black);
  @override
  void initState() {
    super.initState();
    //set วันเดือนปี เวลา ปัจจุบัน
    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0]+" "+splits[1]+" "+(int.parse(splits[3])+543).toString();
    _currentDate=date;
    _currentTime = dateFormatTime.format(DateTime.now()).toString();

    if(widget.ItemSentence!=null) {
      itemMain=widget.ItemSentence;
      _onSaved=true;
      _isFine=itemMain.IsFine;
      _isPeriod=itemMain.IsPeriod;
      _isImprison=itemMain.IsImprison;
      _isDismissed=itemMain.IsDismissed;

      itemMain.IsOneTime?_setInitData1():_setInitData2();

      print("ชื่อศาล : " + itemMain.CourtName);
    }

  }

  @override
  void dispose() {
    super.dispose();
    editCourtName.dispose();
    editUndecidedCase.dispose();
    editDecidedCase.dispose();
    editFineValue.dispose();
    editImprison.dispose();
    editPeriod.dispose();
    editPeriodNum.dispose();
  }

  // set text data ชำระครั้งเดียว
  void _setInitData1(){
    editCourtName.text=itemMain.CourtName;
    editUndecidedCase.text=itemMain.UndecidedCase;
    editDecidedCase.text=itemMain.DecidedCase;
    editFineValue.text=itemMain.FineValue.toString();
    editImprison.text=itemMain.Imprison.toString();
    dropdownValueImprison = itemMain.ImprisonType;
    _currentDate=itemMain.SentenceDate;
    _currentDateFine=itemMain.FineDate;
  }
  // set text data ชำระเป็นงวด
  void _setInitData2(){
    editCourtName.text=itemMain.CourtName;
    editUndecidedCase.text=itemMain.UndecidedCase;
    editDecidedCase.text=itemMain.DecidedCase;
    editFineValue.text=itemMain.FineValue.toString();
    editImprison.text=itemMain.Imprison.toString();
    dropdownValueImprison = itemMain.ImprisonType;
    _currentDate=itemMain.SentenceDate;
    _currentDateFine=itemMain.FineDate;
    editPeriod.text=itemMain.Period.toString();
    editPeriodNum.text=itemMain.PeriodNum.toString();
    dropdownValueFine = itemMain.FineType;

  }

  //ล้างย้อมูลใน textfield
  void clearTextfield(){
    editCourtName.clear();
    editUndecidedCase.clear();
    editDecidedCase.clear();
    editFineValue.clear();
    editImprison.clear();
    editPeriod.clear();
    editPeriodNum.clear();
  }

  //popup เมื่อกดแก้ไขหรือลบ
  void choiceAction(Constants constants) {
    print(constants.text);
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _onSaved = false;

      } else {
        _showDeleteAlertDialog();
      }
    });
  }
  //popup delete
  CupertinoAlertDialog _createCupertinoCancelDeleteDialog() {
    TextStyle TitleStyle = TextStyle(fontSize: 16.0,);
    TextStyle ButtonAcceptStyle = TextStyle(
      color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold,);
    TextStyle ButtonCancelStyle = TextStyle(
      fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.bold,);
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text("ยืนยันการลบข้อมูลทั้งหมด.",
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[

          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text(
                  'ยกเลิก', style: ButtonCancelStyle)),
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _onSaved = false;
                  _onEdited = false;
                  _onSave = false;
                  itemMain=null;
                  clearTextfield();
                  Navigator.pop(context,itemMain);
                });
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }

  void _showDeleteAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelDeleteDialog();
      },
    );
  }

  // popup layout ยกเลิกรายการ
  CupertinoAlertDialog _createCupertinoCancelAlertDialog(mContext){
    TextStyle TitleStyle = TextStyle(fontSize: 16.0,);
    TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold,);
    TextStyle ButtonCancelStyle = TextStyle(fontSize: 18.0,color: Colors.red, fontWeight: FontWeight.bold,);
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text("ยืนยันการยกเลิกข้อมูลทั้งหมด.",
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[

          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text(
                  'ยกเลิก', style: ButtonCancelStyle)),
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(mContext,itemMain);
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }
  // popup method ยกเลิกรายการ
  void _showCancelAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelAlertDialog(context);
      },
    );
  }
  //แสดง popup ปฏิทิน วันอ่านคำพิพากษา
  Future<DateTime> _selectDateSentence(context) async {
    return await showDatePicker(
      context: context,
      firstDate: _initDate,
      initialDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
  }
  //แสดง popup ปฏิทิน วันที่กำหนดชำระค่าปรับ
  Future<DateTime> _selectDateFine(context) async {
    return await showDatePicker(
      context: context,
      firstDate: _initDate,
      initialDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
  }
  //get file รูปภาพ
  Future getImage(ImageSource source,mContext) async {
    var image = await ImagePicker.pickImage(source: source);
    setState(() {
      List splits = image.path.split("/");
      isImage = true;
      _arrItemsImageName.add(splits[splits.length - 1]);
      _arrItemsImageFile.add(image);
    });
    Navigator.pop(mContext);
  }

  //แสดง popup ให้เลือกรูปจากกล้องหรทอแกลอรี่
  void _showDialogImagePicker(){
    showDialog(context: context,builder: (context) => _onTapImage(context)); // Call the Dialog.
  }
  _onTapImage(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: width / 3,
                  height: height / 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Icon(
                    Icons.camera_alt, color: Colors.blue, size: 38.0,),
                ),
                onTap: () {
                  getImage(ImageSource.camera,context);
                },
              ),
              GestureDetector(
                child: Container(
                  width: width / 3,
                  height: height / 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Icon(Icons.image, color: Colors.blue, size: 38.0,),
                ),
                onTap: () {
                  getImage(ImageSource.gallery,context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  //ส่วนของ body
  Widget _buildContent() {
    var size = MediaQuery
        .of(context)
        .size;
    return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(22.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 18.0,top: 8,bottom: 8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _isDismissed = !_isDismissed;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: _isDismissed ? Color(0xff3b69f3) : Colors
                                      .white,
                                  border: Border.all(color: Colors.black38,width: 1.5),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: _isDismissed
                                        ? Icon(
                                      Icons.check,
                                      size: 16.0,
                                      color: Colors.white,
                                    )
                                        : Container(
                                      height: 16.0,
                                      width: 16.0,
                                      color: Colors.transparent,
                                    )
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "ศาลยกฟ้อง", style: textStyleLabel,),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text("ชื่อศาล", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            //padding: paddingData,
                            child: TextField(
                              focusNode: myFocusNodeCourtName,
                              controller: editCourtName,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization
                                  .words,
                              style: textStyleData,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text("หมายเลขคดีดำ", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            //padding: paddingData,
                            child: TextField(
                              focusNode: myFocusNodeUndecidedCase,
                              controller: editUndecidedCase,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization
                                  .words,
                              style: textStyleData,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text("หมายเลขคดีแดง", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            //padding: paddingData,
                            child: TextField(
                              focusNode: myFocusNodeDecidedCase,
                              controller: editDecidedCase,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization
                                  .words,
                              style: textStyleData,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "วันอ่านคำพิพากษา", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingData,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new ListTile(
                            title: Text(_currentDate, style: textStyleData,),
                            trailing: Icon(FontAwesomeIcons.calendarAlt, size: 28,),
                            onTap: () {
                              /*_selectDateSentence(context).then((value) {
                                setState(() {
                                  //_initDate = value.toLocal();
                                  _currentDate =
                                      dateFormatDate.format(value.toLocal())
                                          .toString();
                                });
                              });*/
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DynamicDialog(
                                        Current: _initDate);
                                  }).then((s) {
                                String date = "";
                                List splits = dateFormatDate.format(
                                    s).toString().split(" ");
                                date = splits[0] + " " + splits[1] +
                                    " " +
                                    (int.parse(splits[3]) + 543)
                                        .toString();
                                setState(() {
                                  _initDate=s;
                                  _currentDate=date;
                                });
                              });
                            },
                          ),
                          Container(
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ),
                    !_isDismissed?Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(right: 18.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _isFine = true;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(4.0),
                                        color: _isFine ? Color(0xff3b69f3) : Colors
                                            .white,
                                        border: Border.all(color: Colors.black12),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: _isFine
                                              ? Icon(
                                            Icons.check,
                                            size: 16.0,
                                            color: Colors.white,
                                          )
                                              : Container(
                                            height: 16.0,
                                            width: 16.0,
                                            color: Colors.transparent,
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "สั่งปรับเป็นจำนวน", style: textStyleLabel,),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: paddingData,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  //padding: paddingData,
                                  child: TextField(
                                    focusNode: myFocusNodeFineValue,
                                    controller: editFineValue,
                                    keyboardType: TextInputType.number,
                                    textCapitalization: TextCapitalization
                                        .words,
                                    style: textStyleData,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        suffixText: 'บาท',
                                        suffixStyle: textStyleSubData
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 1.0,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: paddingLabel,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(right: 18.0, left: 12.0,bottom: 8,top: 8),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                _isOneTime = true;
                                                _isPeriod = false;
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: _isOneTime ? Color(0xff3b69f3) : Colors
                                                    .white,
                                                border: Border.all(color: Colors.black12),
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: _isOneTime
                                                      ? Icon(
                                                    Icons.check,
                                                    size: 16.0,
                                                    color: Colors.white,
                                                  )
                                                      : Container(
                                                    height: 16.0,
                                                    width: 16.0,
                                                    color: Colors.transparent,
                                                  )
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "ชำระครั้งเดียว", style: textStyleData1,),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(right: 18.0, left: 12.0),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                _isPeriod = true;
                                                _isOneTime = false;
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: _isPeriod ? Color(0xff3b69f3) : Colors
                                                    .white,
                                                border: Border.all(color: Colors.black12),
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: _isPeriod
                                                      ? Icon(
                                                    Icons.check,
                                                    size: 16.0,
                                                    color: Colors.white,
                                                  )
                                                      : Container(
                                                    height: 16.0,
                                                    width: 16.0,
                                                    color: Colors.transparent,
                                                  )
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "เเบ่งชำระเป็นงวด", style: textStyleData1,),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                          ),
                          _isPeriod?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text("จำนวนงวด", style: textStyleLabel,),
                              ),
                              Container(
                                padding: paddingLabel,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Container(
                                      //padding: paddingData,
                                      child: TextField(
                                        focusNode: myFocusNodeDecidedCase,
                                        controller: editDecidedCase,
                                        keyboardType: TextInputType.number,
                                        textCapitalization: TextCapitalization
                                            .words,
                                        style: textStyleData,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 1.0,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ):Container(),
                          Container(
                            padding: paddingLabel,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    "วันที่กำหนดชำระค่าปรับ", style: textStyleLabel,),
                                ),
                                Container(
                                  padding: paddingData,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new ListTile(
                                        title: Text(_currentDateFine!=null?_currentDateFine:'', style: textStyleData,),
                                        trailing: Icon(FontAwesomeIcons.calendarAlt, size: 28,),
                                        onTap: () {
                                         /* _selectDateSentence(context).then((value) {
                                            setState(() {
                                              _currentDateFine =
                                                  dateFormatDate.format(value.toLocal())
                                                      .toString();
                                            });
                                          });*/
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return DynamicDialog(
                                                    Current: _dtDateFine);
                                              }).then((s) {
                                            String date = "";
                                            List splits = dateFormatDate.format(
                                                s).toString().split(" ");
                                            date = splits[0] + " " + splits[1] +
                                                " " +
                                                (int.parse(splits[3]) + 543)
                                                    .toString();
                                            setState(() {
                                              _dtDateFine=s;
                                              _currentDateFine=date;
                                            });
                                          });
                                        },
                                      ),
                                      Container(
                                        height: 1.0,
                                        color: Colors.grey[300],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _isPeriod?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text("รอบชำระค่าปรับทุก", style: textStyleLabel,),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: ((size.width * 75) / 100) / 1.5,
                                    child: Container(
                                      padding: paddingData,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Container(
                                            //padding: paddingData,
                                            child: TextField(
                                              focusNode: myFocusNodePeriod,
                                              controller: editPeriod,
                                              keyboardType: TextInputType.number,
                                              textCapitalization: TextCapitalization
                                                  .words,
                                              style: textStyleData,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 1.0,
                                            color: Colors.grey[300],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  /*Container(
                                    width: ((size.width * 75) / 100) / 2.5,
                                    child:  Container(
                                      padding: paddingData,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Container(
                                            //padding: paddingData,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  DropdownButtonHideUnderline(
                                                    child: DropdownButton<String>(
                                                      value: dropdownValueFine,
                                                      onChanged: (String newValue) {
                                                        setState(() {
                                                          dropdownValueFine = newValue;
                                                        });
                                                      },
                                                      items: dropdownItemsFine
                                                          .map<DropdownMenuItem<String>>((String value) {
                                                        return DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Text(value,style: textStyleData1,),
                                                        );
                                                      })
                                                          .toList(),
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                          Container(
                                            height: 1.0,
                                            color: Colors.grey[300],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),*/
                                  Container(
                                    width: ((size.width * 75) / 100) / 2.5,
                                    child:  Container(
                                      padding: paddingData,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Container(
                                            //padding: paddingData,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  DropdownButtonHideUnderline(
                                                    child: DropdownButton<String>(
                                                      value: dropdownValueFine,
                                                      onChanged: (String newValue) {
                                                        setState(() {
                                                          dropdownValueFine = newValue;
                                                        });
                                                      },
                                                      items: dropdownItemsFine
                                                          .map<DropdownMenuItem<String>>((String value) {
                                                        return DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Text(value,style: textStyleData1,),
                                                        );
                                                      })
                                                          .toList(),
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                          Container(
                                            height: 1.0,
                                            color: Colors.grey[300],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ):Container(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(right: 18.0, left: 12.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _isImprison = true;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: _isImprison ? Color(0xff3b69f3) : Colors
                                                .white,
                                            border: Border.all(color: Colors.black12),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: _isImprison
                                                  ? Icon(
                                                Icons.check,
                                                size: 16.0,
                                                color: Colors.white,
                                              )
                                                  : Container(
                                                height: 16.0,
                                                width: 16.0,
                                                color: Colors.transparent,
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "สั่งจำคุกเป็นจำนวน", style: textStyleLabel,),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: ((size.width * 75) / 100) / 1.5,
                                    child: Container(
                                      padding: paddingData,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Container(
                                            //padding: paddingData,
                                            child: TextField(
                                              focusNode: myFocusNodeImprison,
                                              controller: editImprison,
                                              keyboardType: TextInputType.number,
                                              textCapitalization: TextCapitalization
                                                  .words,
                                              style: textStyleData,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 1.0,
                                            color: Colors.grey[300],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: ((size.width * 75) / 100) / 2.5,
                                    child:  Container(
                                      padding: paddingData,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Container(
                                            //padding: paddingData,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  DropdownButtonHideUnderline(
                                                    child: DropdownButton<String>(
                                                      value: dropdownValueImprison,
                                                      onChanged: (String newValue) {
                                                        setState(() {
                                                          dropdownValueImprison = newValue;
                                                        });
                                                      },
                                                      items: dropdownItemsImprison
                                                          .map<DropdownMenuItem<String>>((String value) {
                                                        return DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Text(value,style: textStyleData1,),
                                                        );
                                                      })
                                                          .toList(),
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                          Container(
                                            height: 1.0,
                                            color: Colors.grey[300],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ):Container()
                  ],
                ),
              ),
              Container(
                width: size.width,
                child: _buildButtonImgPicker(),
              ),
              _buildDataImage(context),
            ],
          ),
        )
    );
  }
  Widget _buildContent_saved(BuildContext context) {
    TextStyle textStyleSentence = TextStyle(color: Color(0xff087de1));
    EdgeInsets paddindSentence = EdgeInsets.only(top: 8.0,bottom: 8.0,left: 14.0,right: 14.0);
    var size = MediaQuery
        .of(context)
        .size;
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              left: 22.0, right: 22.0, top: 22.0, bottom: 44.0),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border(
                //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              )
          ),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("หมายเลขคดีเเดง", style: textStyleLabel,),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemMain.DecidedCase,
                          style: textStyleData,),
                      ),
                    ],
                  ),
                  Padding(
                    padding: paddingData,
                    child: Container(
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                  ),
                  itemMain.IsDismissed?Container(
                    padding: paddingLabel,
                    child: Text("ศาลยกฟ้อง", style: textStyleLabel,),
                  ):Container(),
                  Container(
                    padding: paddingLabel,
                    child: Text("ชื่อศาล", style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      itemMain.CourtName,
                      style: textStyleData,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text("หมายเลขคดีดำ", style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      itemMain.UndecidedCase, style: textStyleData,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text("วันอ่านคำพิพากษาศาล", style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      itemMain.SentenceDate, style: textStyleData,),
                  ),
                  !itemMain.IsDismissed?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text("สั่งปรับเป็นจำนวน", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemMain.FineValue.toString()+" บาท", style: textStyleData,),
                      ),
                      itemMain.IsOneTime?Container(
                        padding: paddingLabel,
                        child: Text("ชำระครั้งเดียว", style: textStyleLabel,),
                      )
                          :Container(
                        padding: paddingLabel,
                        child: Text("แบ่งชำระเป็นงวด", style: textStyleLabel,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("วันที่กำหนดชำระค่าปรับ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemMain.FineDate, style: textStyleData,),
                      ),
                      itemMain.IsImprison?Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text( "สั่งจำคุกเป็นจำนวน", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              itemMain.Imprison.toString()+" "+itemMain.ImprisonType, style: textStyleData,),
                          ),
                        ],
                      ):Container()
                    ],
                  ):Container()
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: PopupMenuButton<Constants>(
                  onSelected: choiceAction,
                  icon: Icon(Icons.more_vert, color: Colors.black,),
                  itemBuilder: (BuildContext context) {
                    return constants.map((Constants contants) {
                      return PopupMenuItem<Constants>(
                        value: contants,
                        child: Row(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(right: 4.0),
                              child: Icon(
                                contants.icon, color: Colors.grey[400],),),
                            Padding(padding: EdgeInsets.only(left: 4.0),
                              child: Text(contants.text),)
                          ],
                        ),
                      );
                    }).toList();
                  },
                ),
              )
            ],
          )
        ),
      ),
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
      padding: EdgeInsets.only(left:18.0,top: 18.0),
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
                    //getImage();
                    _showDialogImagePicker();
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
                              "เลือกไฟล์/รูปภาพ", style: textLabelStyle,),
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
            return Container(
              padding: EdgeInsets.only(top: 0.1, bottom: 0.1),
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

  void onSaved()async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadAction();
    Navigator.pop(context);

    setState(() {
      _onSaved = true;
      _onFinish = true;

      !_isDismissed ? (_isPeriod ? itemMain = new ItemsLawsuitSentence(
          editDecidedCase.text,
          editUndecidedCase.text,
          editCourtName.text,
          _currentDate,
          double.parse(editFineValue.text),
          dropdownValueFine,
          null,
          _isOneTime,
          _isPeriod,
          int.parse(editPeriod.text),
          int.parse(editPeriodNum.text),
          _isImprison ? int.parse(editImprison.text) : null,
          dropdownValueImprison,
          _isFine,
          _isImprison,
          _isDismissed
      ) : itemMain = new ItemsLawsuitSentence(
          editDecidedCase.text,
          editUndecidedCase.text,
          editCourtName.text,
          _currentDate,
          double.parse(editFineValue.text),
          dropdownValueFine,
          _currentDateFine,
          _isOneTime,
          _isPeriod,
          null,
          null,
          _isImprison ? int.parse(editImprison.text) : null,
          dropdownValueImprison,
          _isFine,
          _isImprison,
          _isDismissed
      )) : itemMain = new ItemsLawsuitSentence(
          editDecidedCase.text,
          editUndecidedCase.text,
          editCourtName.text,
          _currentDate,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          _isFine,
          _isImprison,
          _isDismissed
      );
    });
  }

  Future<bool> onLoadAction() async {
    await new Future.delayed(const Duration(seconds: 3));
    return true;
  }
  @override
  Widget build(BuildContext context) {
    TextStyle textStylePageName = TextStyle(color: Colors.grey[400]);
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0);
    TextStyle tabStyle = TextStyle(fontSize: 16.0, color: Colors.black54);
    TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white);
    TextStyle appBarStylePay = TextStyle(fontSize: 16.0, color: Colors.white);
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    final List<Widget> rowContents = <Widget>[
      new SizedBox(
          width: width / 3,
          child: new Center(
            child: new FlatButton(
              onPressed: () {
                _onEdited ?
                setState(() {
                  _onSave = false;
                  _onEdited = false;
                }) :
                _onSaved ? Navigator.pop(context, itemMain) :
                _showCancelAlertDialog(context);
              },
              padding: EdgeInsets.all(10.0),
              child: new Row(
                children: <Widget>[
                  new Icon(Icons.arrow_back_ios, color: Colors.white,),
                  !_onSaved
                      ? new Text("ยกเลิก", style: appBarStyle,)
                      : new Container(),
                ],
              ),
            ),
          )
      ),
      Expanded(
          child: Center(child: Text("คำพิพากษาศาล", style: appBarStyle),
          )),
      new SizedBox(
          width: width / 3,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _onSaved ? (_onSave ? new FlatButton(
                  onPressed: () {
                    setState(() {
                      _onSaved = true;
                      _onSave = false;
                      _onEdited = false;
                    });
                    //TabScreenArrest1().createAcceptAlert(context);
                  },
                  child: Text('บันทึก', style: appBarStyle))
                  :
              Container()
              )
                  :
              new FlatButton(
                  onPressed: () {
                    onSaved();
                  },
                  child: Text('บันทึก', style: appBarStyle)),
            ],
          )
      )
    ];

    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              primary: true,
              pinned: false,
              flexibleSpace: new BottomAppBar(
                elevation: 0.0,
                color: Color(0xff2e76bc),
                child: new Row(
                    children: rowContents),
              ),
              automaticallyImplyLeading: false,
            ),
            SliverFillRemaining(
              child: Scaffold(
                backgroundColor: Colors.grey[200],
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
                                'ILG60_B_02_00_06_00', style: textStylePageName,),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: _onSaved?_buildContent_saved(context):_buildContent(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
