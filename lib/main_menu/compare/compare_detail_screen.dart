import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_detailed_fine_screen.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_%20suspect.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_%20suspect_detail.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_case_information.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_evidence.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prototype_app_pang/picker/date_picker.dart';

class CompareDetailScreenFragment extends StatefulWidget {
  ItemsCompareCaseInformation ItemInformations;
  ItemsCompareSuspect ItemSuspect;
  ItemsCompareSuspectDetail ItemSuspectDetail;
  CompareDetailScreenFragment({
    Key key,
    @required this.ItemInformations,
    @required this.ItemSuspect,
    @required this.ItemSuspectDetail,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<CompareDetailScreenFragment>  with TickerProviderStateMixin {
  //เมื่อบันทึกข้อมูล
  bool _onSaved = false;
  bool _onSave = false;
  //เมื่อแก้ไขข้อมูล
  bool _onEdited = false;
  //เมื่อลบข้อมูล
  bool _onDeleted = false;
  //เมื่อทำรายการเสร็จ
  bool _onFinish = false;
  //ปล่อยตัวชั่วคราว
  bool IsRelease=false;
  //ไม่ร้องขอ
  bool IsNotRequested=false;
  //ร้องขอ
  bool IsRequested=true;
  //เงินสด
  bool IsCash=true;
  //เครดิต
  bool IsCredit=false;

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete_outline),
  ];

  //node focus
  final FocusNode myFocusNodeCompareNumber = FocusNode();
  final FocusNode myFocusNodeCompareYear = FocusNode();
  final FocusNode myFocusNodeComparePerson = FocusNode();
  final FocusNode myFocusNodeComparePlace= FocusNode();
  final FocusNode myFocusNodeCompareBillNumber= FocusNode();
  final FocusNode myFocusNodeCompareBillBookNo= FocusNode();
  final FocusNode myFocusNodeCompareBail= FocusNode();
  final FocusNode myFocusNodeCompareDepositBail= FocusNode();

  //textfield
  TextEditingController editCompareNumber = new TextEditingController();
  TextEditingController editCompareYear = new TextEditingController();
  TextEditingController editComparePerson = new TextEditingController();
  TextEditingController editComparePlace = new TextEditingController();
  TextEditingController editCompareBillNumber = new TextEditingController();
  TextEditingController editCompareBillBookNo = new TextEditingController();
  TextEditingController editCompareBail= new TextEditingController();
  TextEditingController editCompareDepositBail= new TextEditingController();

  //วันเดือนปี เวลา ปัจจุบัน
  String _currentCompareDate,_currentCompareTime;
  var dateFormatDate,dateFormatTime;
  DateTime _initDate=DateTime.now();

  DateTime _dtCompare=DateTime.now();

  //วันที่กำหนดชำระภาษี
  String _currentTaxDueDate="";
  DateTime _dtTaxDueDate=DateTime.now();
  //วันที่กำหนดชำระค่าปรับ
  String _currentFineDueDate="";
  DateTime _dtFineDueDate=DateTime.now();

  //รูปภาพ
  Future<File> _imageFile;
  List<File> _arrItemsImageFile = [];
  List<String> _arrItemsImageName = [];
  bool isImage = false;
  VoidCallback listener;

  //model คำพิพากษาศาล
  ItemsCompareSuspect itemMain;
  ItemsCompareCaseInformation itemInfor;
  List<ItemsCompareEvidence> itemEvidence;

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

  String _titleAppbar;
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
    _currentCompareDate=date;
    _currentCompareTime = dateFormatTime.format(DateTime.now()).toString();

    itemMain=widget.ItemSuspect;
    itemInfor=widget.ItemInformations;

    if(itemMain.SuspectDetails!=null) {
      IsRelease = itemMain.SuspectDetails.IsRelease;
    }

    _onSaved=itemMain.IsActive;
    /*if(widget.ItemSuspect!=null) {
      itemMain=widget.ItemSuspect;
      _onSaved=true;
      _isFine=itemMain.IsFine;
      _isPeriod=itemMain.IsPeriod;
      _isImprison=itemMain.IsImprison;
      _isDismissed=itemMain.IsDismissed;

      itemMain.IsOneTime?_setInitData1():_setInitData2();

      print("ชื่อศาล : " + itemMain.CourtName);
    }
*/
    if(itemMain.SuspectName.length>17){
      _titleAppbar= itemMain.SuspectName.substring(0,17)+"...";
    }else{
      _titleAppbar= itemMain.SuspectName;
    }
  }

  @override
  void dispose() {
    super.dispose();
    editCompareNumber.dispose();
    editCompareYear.dispose();
    editComparePerson.dispose();
    editComparePlace.dispose();
    editCompareBillNumber.dispose();
    editCompareBillBookNo.dispose();
    editCompareBail.dispose();
    editCompareDepositBail.dispose();
  }

  //ล้างย้อมูลใน textfield
  void clearTextfield(){
    editCompareNumber.clear();
    editCompareYear.clear();
    editComparePerson.clear();
    editComparePlace.clear();
    editCompareBillNumber.clear();
    editCompareBillBookNo.clear();
    editCompareBail.clear();
    editCompareDepositBail.clear();
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
  CupertinoAlertDialog _createCupertinoDeleteDialog() {
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
                  itemMain.IsActive=false;
                  //itemInfor.IsCompare=false;
                  clearTextfield();
                  //Navigator.pop(context,itemMain);
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
        return _createCupertinoDeleteDialog();
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
                Navigator.pop(mContext,"Back");
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
  //ไปที่หน้ารายละเอียดค่าปรับ
  _navigate(BuildContext context,ItemsCompareCaseInformation itemsInfor,ItemsCompareSuspect itemSuspect) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CompareDetailFineScreenFragment(
          ItemsInformations: itemsInfor,
          ItemsSuspect: itemSuspect
      )),
    );
    if(result.toString()!="Back") {
      //itemMain.E.Evidenses = result;
    }
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
                            padding: EdgeInsets.only(
                                right: 18.0, top: 8, bottom: 8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  IsRelease = !IsRelease;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: IsRelease ? Color(0xff3b69f3) : Colors
                                      .white,
                                  border: Border.all(
                                    width: 1.5,
                                      color: Colors.black38
                                  ),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: IsRelease
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
                              "ปล่อยตัวชั่งคราว", style: textStyleLabel,),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "คดีเปรียบเทียบที่", style: textStyleLabel,),
                          Text("*", style: textStyleStar,),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Padding(
                            padding: paddingData,
                            child: new Text("น.",
                              style: textStyleData,
                            ),
                          ),
                          Container(
                            width: ((size.width * 75) / 100) / 2,
                            child: itemInfor.IsCompare?
                            new Padding(
                              padding: paddingData,
                              child: Center(
                                child: new Text(itemInfor.CompareNumber,
                                  style: textStyleData,
                                ),
                              )
                            ):Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  //padding: paddingData,
                                  child: TextField(
                                    focusNode: myFocusNodeCompareNumber,
                                    controller: editCompareNumber,
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
                          new Padding(
                            padding: paddingData,
                            child: new Text("/",
                              style: textStyleData,
                            ),
                          ),
                          Container(
                            width: ((size.width * 75) / 100) / 2,
                            child: itemInfor.IsCompare?
                            new Padding(
                              padding: paddingData,
                              child: Center(
                                child: new Text(itemInfor.CompareYear,
                                  style: textStyleData,
                                ),
                              )
                            ):Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  //padding: paddingData,
                                  child: TextField(
                                    focusNode: myFocusNodeCompareYear,
                                    controller: editCompareYear,
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
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          IsRelease?Text(
                            "วันที่บันทึกคำให้การผู้ต้องหา", style: textStyleLabel,):Text(
                            "วันที่เปรียบเทียบปรับ", style: textStyleLabel,),
                          Text("*", style: textStyleStar,),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingData,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new ListTile(
                            title: Text(
                              _currentCompareDate, style: textStyleData,),
                            trailing: Icon(
                                FontAwesomeIcons.calendarAlt, size: 28.0),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DynamicDialog(
                                        Current: _dtCompare);
                                  }).then((s) {
                                String date = "";
                                List splits = dateFormatDate.format(
                                    s).toString().split(" ");
                                date = splits[0] + " " + splits[1] +
                                    " " +
                                    (int.parse(splits[3]) + 543)
                                        .toString();
                                setState(() {
                                  _dtCompare = s;
                                  _currentCompareDate = date;
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
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "เวลา", style: textStyleLabel,),
                          Text("*", style: textStyleStar,),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingData,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new ListTile(
                            title: Text(
                              _currentCompareTime, style: textStyleData,),
                            onTap: () {

                            },
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
                        "ชื่อผู้เปรียบเทียบคดี", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            //padding: paddingData,
                            child: TextField(
                              focusNode: myFocusNodeComparePerson,
                              controller: editComparePerson,
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
                      child: Row(
                        children: <Widget>[
                          Text(
                            "เขียนที่", style: textStyleLabel,),
                          Text("*", style: textStyleStar,),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            //padding: paddingData,
                            child: TextField(
                              focusNode: myFocusNodeComparePlace,
                              controller: editComparePlace,
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
                        "สิทธิ์ให้แจ้งญาติหรือผู้ซึ่งไว้วางใจทราบ",
                        style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            width: ((size.width * 75) / 100) / 2,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      right: 18.0, left: 12.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        IsRequested = true;
                                        IsNotRequested = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: IsRequested
                                            ? Color(0xff3b69f3)
                                            : Colors
                                            .white,
                                        border: Border.all(
                                            color: Colors.black12),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: IsRequested
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
                                    "ร้องขอ", style: textStyleLabel,),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: paddingLabel,
                            width: ((size.width * 75) / 100) / 2,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      right: 18.0, left: 12.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        IsRequested = false;
                                        IsNotRequested = true;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: IsNotRequested ? Color(
                                            0xff3b69f3) : Colors
                                            .white,
                                        border: Border.all(
                                            color: Colors.black12),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: IsNotRequested
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
                                    "ไม่ร้องขอ", style: textStyleLabel,),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "วันที่กำหนดชำระภาษี", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingData,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new ListTile(
                            title: Text(
                              _currentTaxDueDate, style: textStyleData,),
                            trailing: Icon(
                                FontAwesomeIcons.calendarAlt, size: 28.0),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DynamicDialog(
                                        Current: _dtTaxDueDate);
                                  }).then((s) {
                                String date = "";
                                List splits = dateFormatDate.format(
                                    s).toString().split(" ");
                                date = splits[0] + " " + splits[1] +
                                    " " +
                                    (int.parse(splits[3]) + 543)
                                        .toString();
                                setState(() {
                                  _dtTaxDueDate = s;
                                  _currentTaxDueDate = date;
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
                    !IsRelease?Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Row(
                            children: <Widget>[
                              Text(
                                "ใบเสร็จเลขที่", style: textStyleLabel,),
                              Text("*", style: textStyleStar,),
                            ],
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                //padding: paddingData,
                                child: TextField(
                                  focusNode: myFocusNodeCompareBillNumber,
                                  controller: editCompareBillNumber,
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
                        Container(
                          padding: paddingLabel,
                          child: Row(
                            children: <Widget>[
                              Text(
                                "ใบเสร็จเล่มที่", style: textStyleLabel,),
                              Text("*", style: textStyleStar,),
                            ],
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                //padding: paddingData,
                                child: TextField(
                                  focusNode: myFocusNodeCompareBillBookNo,
                                  controller: editCompareBillBookNo,
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
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "การชำระเงิน",
                            style: textStyleLabel,),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                width: ((size.width * 75) / 100) / 2,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          right: 18.0, left: 12.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            IsCash = true;
                                            IsCredit = false;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(4.0),
                                            color: IsCash
                                                ? Color(0xff3b69f3)
                                                : Colors
                                                .white,
                                            border: Border.all(
                                                color: Colors.black12),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: IsCash
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
                                        "เงินสด", style: textStyleLabel,),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: paddingLabel,
                                width: ((size.width * 75) / 100) / 2,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          right: 18.0, left: 12.0),
                                      child: InkWell(
                                        onTap: () {
                                          /*setState(() {
                                        IsCash = false;
                                        IsCredit = true;
                                      });*/
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(4.0),
                                            color: IsCredit ? Color(
                                                0xff3b69f3) : Colors.grey[400],
                                            border: Border.all(
                                                width: 1.5,
                                                color: Colors.black38),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: IsCredit
                                                  ? Icon(
                                                Icons.check,
                                                size: 16.0,
                                                color: Colors.white,
                                              )
                                                  : Container(
                                                height: 16.0,
                                                width: 16.0,
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "บัตรเครดิต", style: textStyleLabel,),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ):Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Row(
                            children: <Widget>[
                              Text(
                                "วันที่กำหนดชำระค่าปรับ", style: textStyleLabel,),
                              Text("*", style: textStyleStar,),
                            ],
                          ),
                        ),
                        Container(
                          padding: paddingData,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new ListTile(
                                title: Text(
                                  _currentFineDueDate, style: textStyleData,),
                                trailing: Icon(
                                    FontAwesomeIcons.calendarAlt, size: 28.0),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DynamicDialog(
                                            Current: _dtFineDueDate);
                                      }).then((s) {
                                    String date = "";
                                    List splits = dateFormatDate.format(
                                        s).toString().split(" ");
                                    date = splits[0] + " " + splits[1] +
                                        " " +
                                        (int.parse(splits[3]) + 543)
                                            .toString();
                                    setState(() {
                                      _dtFineDueDate = s;
                                      _currentFineDueDate = date;
                                    });
                                  });
                                },
                              ),
                              Container(
                                height: 1.0,
                                color: Colors.grey[300],
                              ),
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "ประกัน", style: textStyleLabel,),
                              ),
                              Container(
                                padding: paddingData,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Container(
                                      //padding: paddingData,
                                      child: TextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        focusNode: myFocusNodeCompareBail,
                                        controller: editCompareBail,
                                        textCapitalization: TextCapitalization.words,
                                        style: textStyleData,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[500], width: 0.5),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[400], width: 0.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "หลักประกัน", style: textStyleLabel,),
                              ),
                              Container(
                                padding: paddingData,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Container(
                                      //padding: paddingData,
                                      child: TextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        focusNode: myFocusNodeCompareDepositBail,
                                        controller: editCompareDepositBail,
                                        textCapitalization: TextCapitalization.words,
                                        style: textStyleData,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[500], width: 0.5),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[400], width: 0.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  _navigate(context,widget.ItemInformations,widget.ItemSuspect);
                },
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.only(top: 4.0),
                  child: Container(
                      padding: EdgeInsets.only(
                          left: 12.0, right: 12.0, top: 12.0, bottom: 12.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          border: Border(
                            top: BorderSide(color: Colors.grey[300], width: 1.0),
                            bottom: BorderSide(
                                color: Colors.grey[300], width: 1.0),
                          )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 12.0,top: 12.0, bottom: 4.0),
                            child: Text(
                              "ยอดชำระค่าปรับ", style: textStyleLabel,),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 22.0),
                                child:  Icon(
                                  Icons.arrow_forward_ios, color: Colors.grey[400],
                                  size: 18.0,),
                              )
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 12.0,top: 4.0, bottom: 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(right: 22.0),
                                    child: Text(
                                        itemMain.FineValue.toString(),
                                        style: textStyleData),
                                  ),
                                  Text(
                                      "บาท",
                                      style: textStyleData),
                                ],
                              )
                          ),
                        ],
                      )
                  ),
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
    EdgeInsets paddindSentence = EdgeInsets.only(
        top: 8.0, bottom: 8.0, left: 14.0, right: 14.0);
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
                      child: Text("คดีเปรียบเทียบที่", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: Text(
                        "น."+itemInfor.CompareNumber+"/"+itemInfor.CompareYear,
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
                      child: Text(IsRelease?"วันที่บันทึกคำให้การผู้ต้องหา":"วันที่เปรียบเทียบปรับ", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: Text(
                        itemMain.SuspectDetails.Date+" "+itemMain.SuspectDetails.Time,
                        style: textStyleData,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text("ชื่อผู้เปรียบเทียบคดี", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: Text(
                        itemMain.SuspectDetails.Person, style: textStyleData,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text("เขียนที่", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: Text(
                        itemMain.SuspectDetails.Place, style: textStyleData,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text("สิทธิ์ให้แจ้งญาติหรือผู้ซึ่งไว้วางใจทราบ", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: Text(
                        itemMain.SuspectDetails.IsRequested?"ร้องขอ":"ไม่ร้องขอ", style: textStyleData,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text("วันที่กำหนดชำระภาษี", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: Text(
                        itemMain.SuspectDetails.TaxDueDate, style: textStyleData,),
                    ),
                    IsRelease?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Text("ประกัน", style: textStyleLabel,),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            itemMain.SuspectDetails.Bail, style: textStyleData,),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text("หลักประกัน", style: textStyleLabel,),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            itemMain.SuspectDetails.DepositBail, style: textStyleData,),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text("ยอดชำระค่าปรับ", style: textStyleLabel,),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            itemMain.FineValue.toString(), style: textStyleData,),
                        ),
                      ]
                    ):Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Text("ใบเสร็จเลขที่/ใบเสร็จเล่มที่", style: textStyleLabel,),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            itemMain.SuspectDetails.BillNumber+"/"+itemMain.SuspectDetails.BillBookNo, style: textStyleData,),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text("ยอดชำระค่าปรับ", style: textStyleLabel,),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            itemMain.FineValue.toString(), style: textStyleData,),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text("การชำระเงิน", style: textStyleLabel,),
                        ),
                        Container(
                          padding: paddingLabel,
                          width: ((size.width * 75) / 100) / 2,
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    right: 18.0, left: 12.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      IsCash = true;
                                      IsCredit = false;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(4.0),
                                      color: Color(0xff3b69f3),
                                      border: Border.all(
                                          color: Colors.black12),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(
                                          Icons.check,
                                          size: 16.0,
                                          color: Colors.white,
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              itemMain.SuspectDetails.IsCash?Container(
                                child: Text(
                                  "เงินสด", style: textStyleLabel,),
                              ):Container(
                                child: Text(
                                  "บัตรเครดิต", style: textStyleLabel,),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
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

      //สร้างเลขที่เปรียบเทียบคดีแล้ว
      itemInfor.IsCompare=true;
      //เปรียบคดีผู้ต้องหานี้แล้ว
      itemMain.IsActive=true;
      //เพิ่มข้อมูล
      //itemInfor.SuspectDetails.IsRelease=IsRelease;
      itemInfor.CompareNumber=editCompareNumber.text;
      itemInfor.CompareYear=editCompareYear.text;

      /*IsRelease?itemMain.SuspectDetails = new ItemsCompareSuspectDetail(
          IsRelease,
          _currentCompareDate,
          _currentCompareTime,
          editComparePerson.text,
          editComparePlace.text,
          IsRequested,
          IsNotRequested,
          _currentTaxDueDate,
          null,
          null,
          null,
          null,
          _currentFineDueDate,
          editCompareBail.text,
          editCompareDepositBail.text
      ): new ItemsCompareSuspectDetail(
          IsRelease,
          _currentCompareDate,
          _currentCompareTime,
          editComparePerson.text,
          editComparePlace.text,
          IsRequested,
          IsNotRequested,
          _currentTaxDueDate,
          editCompareBillNumber.text,
          editCompareBillBookNo.text,
          IsCash,
          IsCredit,
          null,
          null,
          null
      );*/
      itemMain.SuspectDetails = new ItemsCompareSuspectDetail(
          IsRelease,
          _currentCompareDate,
          _currentCompareTime,
          editComparePerson.text,
          editComparePlace.text,
          IsRequested,
          IsNotRequested,
          _currentTaxDueDate,
          editCompareBillNumber.text,
          editCompareBillBookNo.text,
          IsCash,
          IsCredit,
          "",
          "",
          ""
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
          width: width / 3.5,
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
          child: Center(child: Text(_titleAppbar, style: appBarStyle),
          )),
      new SizedBox(
          width: width / 3.5,
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
              PopupMenuButton<Constants>(
                onSelected: choiceAction,
                icon: Icon(Icons.more_vert, color: Colors.white,),
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
              )
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
                                'ILG60_B_04_00_05_00', style: textStylePageName,),
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

