import 'dart:async';
import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/Model/choice.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/check_evidence_search_screen.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/delivery_book_search_screen.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_detail_controller.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_form_list.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_infor.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_infor_delivered.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_main.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_detail_screen.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_reward_screen.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_suspect_screen.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_%20suspect.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_%20suspect_detail.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_case_information.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_form_list.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_main.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_form_list.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_manage_evidence_screen.dart';
import 'package:prototype_app_pang/picker/date_picker.dart';

class CheckEvidenceMainScreenFragment extends StatefulWidget {
  ItemsCheckEvidenceMain itemsCheckEvidenceMain;
  String title;
  bool IsCreate;
  bool IsActive;
  CheckEvidenceMainScreenFragment({
    Key key,
    @required this.itemsCheckEvidenceMain,
    @required this.IsCreate,
    @required this.title,
    @required this.IsActive,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<CheckEvidenceMainScreenFragment>  with TickerProviderStateMixin {
  TabController tabController;
  TabPageSelector _tabPageSelector;
  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = false;
  bool _onSave = false;
  bool _onFinish = false;
  //ตรวจรับกา่รนำออก
  bool _onExport = false;
  //ตรวจรับจากหน่วยงานภายใน
  bool _onWithOut=false;

  bool IsCreate=false;

  List<Choice> choices = [];

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete),
  ];

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
  TextStyle textLabelEditNonCheckStyle = TextStyle(
      fontSize: 16.0, color: Colors.red[100]);

  //item หลักทั้งหมด
  ItemsCheckEvidenceMain itemMain;
  //item ข้อมูลนำส่ง
  ItemsCheckEvidenceInformationDevivered itemInforDelivered;
  //item ตรวจรับของกลาง
  ItemsCheckEvidenceInformationChecked itemInforChecked;
  //item controller ข้อมูลนำส่ง
  List<ItemsCheckEvidenceDetailController> itemEvidenceDetailCon;
  //item ของกลาง
  List<ItemsEvidence> itemEvidence=[];
  //item forms
  List<ItemsCheckEvidenceForms> itemsFormsTab=[];

  //วันที่อละเวลาปัจจุบัน
  String _currentDevieredDate,_currentReturnDate="",_currentGetDate,
      _currentDevieredTime,_currentGetTime;
  var dateFormatDate, dateFormatTime;
  //_dt
  DateTime _dtReturn = DateTime.now();
  //node focus ข้อมูลการนำส่ง
  final FocusNode myFocusNodeCheckEvidenceNumber = FocusNode();
  final FocusNode myFocusNodeCheckEvidencePerson = FocusNode();
  final FocusNode myFocusNodeCheckEvidencePosition = FocusNode();
  final FocusNode myFocusNodeCheckEvidenceDepartment = FocusNode();
  final FocusNode myFocusNodeCheckEvidenceComment = FocusNode();
  final FocusNode myFocusNodeCheckEvidenceStock = FocusNode();
  //textfield ข้อมูลการนำส่ง
  TextEditingController editCheckEvidenceNumber= new TextEditingController();
  TextEditingController editCheckEvidencePerson = new TextEditingController();
  TextEditingController editCheckEvidencePosition = new TextEditingController();
  TextEditingController editCheckEvidenceDepartment = new TextEditingController();
  TextEditingController editCheckEvidenceComment = new TextEditingController();
  TextEditingController editCheckEvidenceStock = new TextEditingController();
  //node focus ข้อมูลการนำส่ง
  final FocusNode myFocusNodeCheckEvidencePersonGet = FocusNode();
  //textfield ข้อมูลการนำส่ง
  TextEditingController editCheckEvidencePersonGet= new TextEditingController();

  //dropdown คลังจัดเก็บ
  String dropdownValueStock = "ส่วนกลาง";
  List<String> dropdownItemsStock = ['ส่วนกลาง'];

  List<Widget> list_widget_tab = [];
  String _title;
  @override
  void initState() {
    super.initState();

    if (widget.title.length > 18) {
      _title = widget.title.substring(0, 18) + '...';
    } else {
      _title = widget.title;
    }

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " +
        (int.parse(splits[3]) + 543).toString();
    //วันและเวลาที่ส่ง
    _currentDevieredDate = date;
    _currentDevieredTime = dateFormatTime.format(DateTime.now()).toString();
    //วันและเวลาที่รับ
    _currentGetDate = date;
    _currentGetTime = dateFormatTime.format(DateTime.now()).toString();

    /*itemEvidenceDetailCon.editTotalNumber.text="0";
    itemEvidenceDetailCon.editTotalVolumn.text="0";*/


    if (!widget.IsCreate) {
      itemMain = widget.itemsCheckEvidenceMain;

      if(itemMain.CheckEvidenceType==1){
        choices = <Choice>[
          Choice(title: 'ตรวจรับของกลาง'),
          Choice(title: 'ข้อมูลคดี'),
        ];

        //editCheckEvidencePersonGet.text=itemMain.InforChecked.Person;
        //dropdownValueStock = itemMain.InforChecked.Stock;
        itemEvidence =itemMain.InforChecked.Evidences;
      }else if(itemMain.CheckEvidenceType==2){
        _onWithOut=true;
        itemInforDelivered = itemMain.InforDelivered;
        itemEvidence =itemMain.InforChecked.Evidences;

        choices = <Choice>[
          Choice(title: 'ข้อมูลการนำส่ง'),
          Choice(title: 'ตรวจรับของกลาง'),
        ];
      }else{
        _onExport=true;
        choices = <Choice>[
          Choice(title: 'ข้อมูลการนำส่ง'),
          Choice(title: 'ตรวจรับของกลาง'),
        ];
      }
    } else {
      IsCreate = true;
      choices = <Choice>[
        Choice(title: 'ข้อมูลการนำส่ง'),
        Choice(title: 'ตรวจรับของกลาง'),
      ];
    }

    /*****************************controller main tab**************************/
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);
  }
  void _setDataSaved() {
    _onFinish = true;

    if (choices.length == 2) {
      setState(() {
        //เพิ่ม tab แบบฟอร์ม
        choices.add(Choice(title: 'แบบฟอร์ม'));
        //เพิ่ม item forms
        itemsFormsTab.add(new ItemsCheckEvidenceForms(
            "บันทึกการรับมอบของกลางจากคณะกรรม การเก็บรักษาของกลาง (ขก.3)"));
      });
    }
    if(widget.IsCreate||_onExport){
      itemInforDelivered = new ItemsCheckEvidenceInformationDevivered(
          editCheckEvidenceNumber.text,
          _currentDevieredDate,
          _currentDevieredTime,
          _currentReturnDate,
          editCheckEvidencePerson.text,
          editCheckEvidencePosition.text,
          editCheckEvidenceDepartment.text,
          editCheckEvidenceComment.text,
          editCheckEvidenceStock.text,
          true);
    }

    itemInforChecked = new ItemsCheckEvidenceInformationChecked(
        "RC0807006200002",
        _currentGetDate,
        _currentGetTime,
        editCheckEvidencePersonGet.text,
        dropdownValueStock,
        itemEvidence);

    itemInforChecked.Evidences.forEach((item){
      item.EvidenceDetailController.expController.expanded=false;
    });

    tabController =
        TabController(length: choices.length, vsync: this);
    _tabPageSelector =
    new TabPageSelector(controller: tabController);
  }


  @override
  void dispose() {
    super.dispose();
    editCheckEvidenceNumber.dispose();
    editCheckEvidencePerson.dispose();
    editCheckEvidencePosition.dispose();
    editCheckEvidenceDepartment.dispose();
    editCheckEvidenceComment.dispose();
    editCheckEvidenceStock.dispose();

    editCheckEvidencePersonGet.dispose();

    if (itemEvidence.length>0) {
      itemEvidence.forEach((item){
        item.EvidenceDetailController.editDeliveredNumber.dispose();
        item.EvidenceDetailController.editDefectiveNumber.dispose();
        item.EvidenceDetailController.editDefectiveNumberUnit.dispose();
        item.EvidenceDetailController.editDeliveredVolumn.dispose();
        item.EvidenceDetailController.editDefectiveVolumn.dispose();
        item.EvidenceDetailController.editDefectiveVolumnUnit.dispose();
        item.EvidenceDetailController.editEvidenceComment.dispose();
      });
    }

  }

  /*****************************method for main tab**************************/
  //เมื่อกด popup แสดงการแก้ไขหรือลบ
  void choiceAction(Constants constants) {
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _onSaved = false;
        _onEdited = true;
        _onFinish=false;
        tabController.animateTo(0);
        choices.removeLast();
      } else {
        _onDeleted = true;
        _showDeleteAllAlertDialog();
      }
    });
  }
  //คำสั่งที่เลือกอย่างไดอย่างหนึ่งใน delete dialog
  CupertinoAlertDialog _createCupertinoDeleteAllDialog() {
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
                  _onEdited = true;
                  _onFinish=false;
                  tabController.animateTo(0);
                  choices.removeLast();
                  clearTextfield();

                  //Navigator.pop(context, itemMain);
                });
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }
  //แสดง dialog ลบรายการ
  void _showDeleteAllAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoDeleteAllDialog();
      },
    );
  }

  //คำสั่งที่เลือกอย่างไดอย่างหนึ่งใน delete dialog
  CupertinoAlertDialog _createCupertinoDeleteEvidenceDialog() {
    TextStyle TitleStyle = TextStyle(fontSize: 16.0,);
    TextStyle ButtonAcceptStyle = TextStyle(
      color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold,);
    TextStyle ButtonCancelStyle = TextStyle(
      fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.bold,);
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text("ยืนยันการลบข้อมูล.",
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
                    itemEvidence=[];
                });
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }
  //แสดง dialog ลบรายการ
  void _showDeleteEvidenceAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoDeleteEvidenceDialog();
      },
    );
  }

  //ล้างข้อมูลใน text field
  void clearTextfield() {

  }

  //คำสั่งที่เลือกอย่างไดอย่างหนึ่งใน cancel dialog
  CupertinoAlertDialog _createCupertinoCancelAlertDialog(mContext) {
    TextStyle TitleStyle = TextStyle(fontSize: 16.0,);
    TextStyle ButtonAcceptStyle = TextStyle(
      color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold,);
    TextStyle ButtonCancelStyle = TextStyle(
      fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.bold,);
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

                if (!_onEdited) {
                  Navigator.pop(mContext, "Back");
                } else {
                  setState(() {
                    _onSaved = true;
                    _onEdited = false;
                  });
                }
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }
  //แสดง dialog ยกเลิกรายการ
  void _showCancelAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelAlertDialog(context);
      },
    );
  }
  //เมื่อกดปุ่มบันทึก
  void onSaved() async {
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
      //เมื่อกดบันทึก
      _onSaved = true;
      _onFinish = true;


      _setDataSaved();
      //ให้ไปที่ tab แบบฟอร์มตอนกดบันทึก
      tabController.animateTo((choices.length - 1));
    });
  }

  //timing progress dialog
  Future<bool> onLoadAction() async {
    await new Future.delayed(const Duration(seconds: 3));
    return true;
  }

  @override
  Widget build(BuildContext context) {
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
          width: width / 4,
          child: new Center(
            child: new FlatButton(
              onPressed: () {
                /* _onEdited ?
                setState(() {
                  _onSave = false;
                  _onEdited = false;
                }) :*/
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
          child: Center(child: Text(_title, style: appBarStyle),
          )),
      new SizedBox(
          width: width / 4,
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

    if(itemMain!=null&&!widget.IsCreate){
      if(itemMain.CheckEvidenceType==1){
        list_widget_tab = _onFinish?[
          _buildContent_tab_2(),
          _buildContent_tab_infor(),
          _buildContent_tab_3(),
        ]:[
          _buildContent_tab_2(),
          _buildContent_tab_infor(),
        ];
      }else{
        list_widget_tab=_onFinish ? <Widget>[
          _buildContent_tab_1(),
          _buildContent_tab_2(),
          _buildContent_tab_3(),
        ] :
        <Widget>[
          _buildContent_tab_1(),
          _buildContent_tab_2(),
        ];
      }
    }else{
      list_widget_tab=_onFinish ? <Widget>[
        _buildContent_tab_1(),
        _buildContent_tab_2(),
        _buildContent_tab_3(),
      ] :
      <Widget>[
        _buildContent_tab_1(),
        _buildContent_tab_2(),
      ];
    }

    return WillPopScope(
      onWillPop: () {
        setState(() {
          if (_onSaved) {
            if (_onEdited) {
              _onEdited = false;
              _onSaved = false;
            } else {
              Navigator.pop(context, itemMain);
            }
          } else {
            Navigator.pop(context, itemMain);
          }
        });
      },
      child: Scaffold(
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
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(140.0),
                  child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey[500],
                    labelStyle: tabStyle,
                    controller: tabController,
                    isScrollable: false,
                    tabs: choices.map((Choice choice) {
                      return Tab(
                        text: choice.title,
                      );
                    }).toList(),
                  ),
                ),
                body: TabBarView(
                  //physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: list_widget_tab,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //************************end_tab_1*******************************
  _navigateEvidence(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CheckEvidenceSearchScreenFragment(
          )),
    );
    if (result.toString() != "Back") {
      setState(() {
        ItemsEvidence item = result;
        itemEvidence.add(item);
        itemEvidence.forEach((item){
          item.EvidenceDetailController.expController.expanded=true;
        });
      });
    }
  }
  navigateDeliveredBook(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DeliveryBookSearchScreenFragment(
          )),
    );
    if (result.toString() != "Back") {
      setState(() {
        ItemsEvidence item = result;
        itemEvidence.add(item);
        itemEvidence.forEach((item){
          item.EvidenceDetailController.expController.expanded=true;
        });
      });
    }
  }


  Widget _buildContent_tab_1() {
    //style content
    var size = MediaQuery
        .of(context)
        .size;

    Widget _buildContent(BuildContext context) {
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
                  ),
                  child: _onExport? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Row(
                          children: <Widget>[
                            Text(
                              "เลขที่หนังสือนำส่ง", style: textStyleLabel,),
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
                                focusNode: myFocusNodeCheckEvidenceNumber,
                                controller: editCheckEvidenceNumber,
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
                              "วันที่นำส่ง", style: textStyleLabel,),
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
                                _currentDevieredDate, style: textStyleData,),
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
                                _currentDevieredTime, style: textStyleData,),
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
                        child: Row(
                          children: <Widget>[
                            Text(
                              "ผู้นำส่ง", style: textStyleLabel,),
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
                                focusNode: myFocusNodeCheckEvidencePerson,
                                controller: editCheckEvidencePerson,
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
                              "คลังจัดเก็บ", style: textStyleLabel,),
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
                                focusNode: myFocusNodeCheckEvidenceStock,
                                controller: editCheckEvidenceStock,
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
                    ],
                  )
                      :Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Row(
                          children: <Widget>[
                            Text(
                              "เลขที่หนังสือนำส่ง", style: textStyleLabel,),
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
                                focusNode: myFocusNodeCheckEvidenceNumber,
                                controller: editCheckEvidenceNumber,
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
                              "วันที่นำส่ง", style: textStyleLabel,),
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
                                _currentDevieredDate, style: textStyleData,),
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
                                _currentDevieredTime, style: textStyleData,),
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
                        child: Row(
                          children: <Widget>[
                            Text(
                              "วันที่รับคืน", style: textStyleLabel,),
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
                                _currentReturnDate, style: textStyleData,),
                              trailing: Icon(
                                  FontAwesomeIcons.calendarAlt, size: 28.0),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DynamicDialog(
                                          Current: _dtReturn);
                                    }).then((s) {
                                  String date = "";
                                  List splits = dateFormatDate.format(
                                      s).toString().split(" ");
                                  date = splits[0] + " " + splits[1] +
                                      " " +
                                      (int.parse(splits[3]) + 543)
                                          .toString();
                                  setState(() {
                                    _dtReturn = s;
                                    _currentReturnDate = date;
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
                              "ผู้นำส่ง", style: textStyleLabel,),
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
                                focusNode: myFocusNodeCheckEvidencePerson,
                                controller: editCheckEvidencePerson,
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
                              "ตำแหน่ง", style: textStyleLabel,),
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
                                focusNode: myFocusNodeCheckEvidencePosition,
                                controller: editCheckEvidencePosition,
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
                              "หน่วยงาน", style: textStyleLabel,),
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
                                focusNode: myFocusNodeCheckEvidenceDepartment,
                                controller: editCheckEvidenceDepartment,
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
                              "เหตุผลในการนำส่ง", style: textStyleLabel,),
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
                                focusNode: myFocusNodeCheckEvidenceComment,
                                controller: editCheckEvidenceComment,
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
                    ],
                  ),
                ),
              ],
            ),
          )
      );
    }

    Widget _buildContent_saved(BuildContext context) {
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
                  ),
                  child: _onExport?Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text("เลขหนังสือนำส่ง", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemInforDelivered.Number,
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
                        child: Text("วันที่นำส่ง", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemInforDelivered.DeliveredDate+" "+itemInforDelivered.DeliveredTime,
                          style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("ผู้นำส่ง", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemInforDelivered.PersonDelivered, style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("คลังจัดเก็บ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemInforDelivered.Stock, style: textStyleData,),
                      ),

                    ],
                  )
                      :Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text("เลขหนังสือนำส่ง", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemInforDelivered.Number,
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
                        child: Text("วันที่นำส่ง", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemInforDelivered.DeliveredDate+" "+itemInforDelivered.DeliveredTime,
                          style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("วันที่รับคืน", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemInforDelivered.ReturnDate,
                          style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("ผู้นำส่ง", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemInforDelivered.PersonDelivered, style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("หน่วยงาน", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemInforDelivered.Department, style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("เหตุผลในการนำส่ง", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemInforDelivered.Comment, style: textStyleData,),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          )
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: _onWithOut?Column(
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
                    'ILG60_B_05_00_05_00', style: textStylePageName,),
                )
              ],
            ),
          ),
          Expanded(
            child: _buildContent_saved(context),
          ),
        ],
      ):Column(
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
                    'ILG60_B_05_00_10_00', style: textStylePageName,),
                )
              ],
            ),
          ),
          Expanded(
            child: _onSaved ? _buildContent_saved(context) : _buildContent(
                context),
          ),
        ],
      ),
    );
  }
//************************end_tab_1*******************************


  //************************start_tab_2*****************************
  //รูปภาพ
  Future<File> _imageFile;
  List<File> _arrItemsImageFile = [];
  List<String> _arrItemsImageName = [];
  bool isImage = false;
  VoidCallback listener;

  //get file รูปภาพ
  Future getImage(ImageSource source, mContext) async {
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
  void _showDialogImagePicker() {
    showDialog(context: context,
        builder: (context) => _onTapImage(context)); // Call the Dialog.
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
                  getImage(ImageSource.camera, context);
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
                  getImage(ImageSource.gallery, context);
                },
              ),
            ],
          )
        ],
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
      padding: EdgeInsets.only(top: 18.0),
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
                width: size.width / 2.2,
                child: MaterialButton(
                  onPressed: () {
                    _onSaved ? null : _showDialogImagePicker();
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
                              Icons.file_upload, size: 22, color: uploadColor,),
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
  Widget _buildButtonSelectEvidence() {
    var size = MediaQuery
        .of(context)
        .size;
    Color labelColor = Color(0xff087de1);
    Color boxColor = Colors.grey[300];
    Color uploadColor = Color(0xff31517c);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: uploadColor);
    return Container(
      padding: EdgeInsets.only(left: 18.0, top: 18.0),
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
                width: size.width / 2.2,
                //padding: EdgeInsets.all(4.0),
                child: MaterialButton(
                  onPressed: () {
                    _onSaved ? null : (_onExport?navigateDeliveredBook(context):_navigateEvidence(context));
                  },
                  splashColor: Colors.grey,
                  child: Container(
                      padding: EdgeInsets.only(top: 18.0, bottom: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          /*Container(
                            //padding: EdgeInsets.all(4.0),
                            child: Icon(
                              null, size: 32, color: uploadColor,),
                          ),*/
                          Container(
                            //padding: EdgeInsets.all(4.0),
                            child: Text(
                              "เพิ่มของกลาง", style: textLabelStyle,),
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
                      child: Image.file(
                        _arrItemsImageFile[index], fit: BoxFit.cover,),
                    ),
                    title: Text(_arrItemsImageName[index],
                      style: textInputStyleTitle,),
                    trailing: new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: !_onSaved?Icon(Icons.delete_outline, size: 32.0,):Icon(null),
                        onPressed: () {
                          setState(() {
                            //print(index.toString());
                            _arrItemsImageFile.removeAt(index);
                            _arrItemsImageName.removeAt(index);
                            if (_arrItemsImageFile.length == 0) {
                              isImage = false;
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

  Widget _buildContent_tab_2() {
    TextStyle textStylePageName = TextStyle(color: Colors.grey[400]);
    TextStyle textStyleLink = TextStyle(color: Color(0xff4564c2));
    Widget _buildExpandableContent(int index) {
      var size = MediaQuery
          .of(context)
          .size;
      final double Width = (size.width * 80) / 100;
      TextStyle textStyleLabel = TextStyle(
          fontSize: 16, color: Color(0xff087de1));
      TextStyle textStyleData = TextStyle(fontSize: 18, color: Colors.black);
      EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
      EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
      Widget _buildExpanded(index) {
        itemEvidence[index].EvidenceDetailController.editDeliveredNumber.text="22";
        itemEvidence[index].EvidenceDetailController.editTotalNumber.text="22";
        itemEvidence[index].EvidenceDetailController.editDeliveredVolumn.text="500";
        itemEvidence[index].EvidenceDetailController.editTotalVolumn.text="500";
        itemEvidence[index].EvidenceDetailController.editTotalNumberUnit.text="ขวด";
        itemEvidence[index].EvidenceDetailController.editTotalVolumnUnit.text="ลิตร";
        return Stack(
          children: <Widget>[
            _onExport?Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "เลขทะเบียนบัญชี", style: textStyleLabel,),
                ),
                Container(
                  padding: paddingData,
                  child: Text(
                    'IN00107016200008', style: textStyleData,),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ชื่อของกลาง", style: textStyleLabel,),
                ),
                Container(
                  padding: paddingData,
                  child: Text(
                    itemEvidence[index].ProductGroup+"/"+itemEvidence[index].ProductType+"/"+itemEvidence[index].MainBrand, style: textStyleData,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: ((size.width * 75) / 100) / 3.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "จำนวนนำส่ง", style: textStyleLabel,),
                          ),
                      IgnorePointer(
                        ignoring: true,
                        child:Padding(
                            padding: paddingData,
                            child: TextField(
                              focusNode: itemEvidence[index]
                                  .EvidenceDetailController
                                  .myFocusNodeDeliveredNumber,
                              controller: itemEvidence[index]
                                  .EvidenceDetailController.editDeliveredNumber,
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization
                                  .words,
                              style: textStyleData,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                      ),
                        ],
                      ),
                    ),
                    Container(
                      width: ((size.width * 75) / 100) / 3.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("จำนวนชำรุด", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: TextField(
                              focusNode: itemEvidence[index]
                                  .EvidenceDetailController
                                  .myFocusNodeDefectiveNumber,
                              controller: itemEvidence[index]
                                  .EvidenceDetailController.editDefectiveNumber,
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
                      width: ((size.width * 75) / 100) / 4.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("จำนวนรับ", style: textStyleLabel,),
                          ),
                          new IgnorePointer(
                            ignoring: true,
                            child: Padding(
                              padding: paddingData,
                              child: TextField(
                                focusNode: itemEvidence[index]
                                    .EvidenceDetailController
                                    .myFocusNodeToalNumber,
                                controller: itemEvidence[index]
                                    .EvidenceDetailController.editTotalNumber,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization
                                    .words,
                                style: textStyleData,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: ((size.width * 75) / 100) / 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("หน่วย", style: textStyleLabel,),
                          ),
                          IgnorePointer(
                            ignoring: true,
                            child: Padding(
                              padding: paddingData,
                              child: TextField(
                                focusNode: itemEvidence[index]
                                    .EvidenceDetailController
                                    .myFocusNodeToalNumberUnit,
                                controller: itemEvidence[index]
                                    .EvidenceDetailController.editTotalNumberUnit,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization
                                    .words,
                                style: textStyleData,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: ((size.width * 75) / 100) / 3.2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "ปริมาณนำส่ง", style: textStyleLabel,),
                          ),
                      IgnorePointer(
                        ignoring: true,
                        child: Padding(
                            padding: paddingData,
                            child: TextField(
                              focusNode: itemEvidence[index]
                                  .EvidenceDetailController
                                  .myFocusNodeDeliveredVolumn,
                              controller: itemEvidence[index]
                                  .EvidenceDetailController.editDeliveredVolumn,
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization
                                  .words,
                              style: textStyleData,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                      ),
                        ],
                      ),
                    ),
                    Container(
                      width: ((size.width * 75) / 100) / 3.2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("ปริมาณชำรุด", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: TextField(
                              focusNode: itemEvidence[index]
                                  .EvidenceDetailController
                                  .myFocusNodeDefectiveVolumn,
                              controller: itemEvidence[index]
                                  .EvidenceDetailController.editDefectiveVolumn,
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
                      width: ((size.width * 75) / 100) / 4.2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("ปริมาณรับ", style: textStyleLabel,),
                          ),
                          new IgnorePointer(
                            ignoring: true,
                            child: Padding(
                              padding: paddingData,
                              child: TextField(
                                focusNode: itemEvidence[index]
                                    .EvidenceDetailController
                                    .myFocusNodeToaVolumn,
                                controller: itemEvidence[index]
                                    .EvidenceDetailController.editTotalVolumn,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization
                                    .words,
                                style: textStyleData,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: ((size.width * 75) / 100) / 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("หน่วย", style: textStyleLabel,),
                          ),
                          IgnorePointer(
                            ignoring: true,
                            child: Padding(
                              padding: paddingData,
                              child: TextField(
                                focusNode: itemEvidence[index]
                                    .EvidenceDetailController
                                    .myFocusNodeToaVolumnUnit,
                                controller: itemEvidence[index]
                                    .EvidenceDetailController.editTotalVolumnUnit,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization
                                    .words,
                                style: textStyleData,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "หมายเหตุ", style: textStyleLabel,),
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
                          focusNode: itemEvidence[index]
                              .EvidenceDetailController
                              .myFocusNodeEvidenceComment,
                          controller: itemEvidence[index]
                              .EvidenceDetailController.editEvidenceComment,
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
            ):
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "เลขทะเบียนบัญชี", style: textStyleLabel,),
                ),
                Container(
                  padding: paddingData,
                  child: Text(
                    'Auto Gen', style: textStyleData,),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ชื่อของกลาง", style: textStyleLabel,),
                ),
                Container(
                  padding: paddingData,
                  child: Text(
                    itemEvidence[index].ProductGroup + ' / ' +
                        itemEvidence[index].MainBrand, style: textStyleData,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: ((size.width * 75) / 100) / 3.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "จำนวนนำส่ง", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: TextField(
                              focusNode: itemEvidence[index]
                                  .EvidenceDetailController
                                  .myFocusNodeDeliveredNumber,
                              controller: itemEvidence[index]
                                  .EvidenceDetailController.editDeliveredNumber,
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
                      width: ((size.width * 75) / 100) / 3.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("จำนวนชำรุด", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: TextField(
                              focusNode: itemEvidence[index]
                                  .EvidenceDetailController
                                  .myFocusNodeDefectiveNumber,
                              controller: itemEvidence[index]
                                  .EvidenceDetailController.editDefectiveNumber,
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
                      width: ((size.width * 75) / 100) / 4.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("จำนวนรับ", style: textStyleLabel,),
                          ),
                          new IgnorePointer(
                            ignoring: true,
                            child: Padding(
                              padding: paddingData,
                              child: TextField(
                                focusNode: itemEvidence[index]
                                    .EvidenceDetailController
                                    .myFocusNodeToalNumber,
                                controller: itemEvidence[index]
                                    .EvidenceDetailController.editTotalNumber,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization
                                    .words,
                                style: textStyleData,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: ((size.width * 75) / 100) / 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("หน่วย", style: textStyleLabel,),
                          ),
                          Container(
                            //padding: paddingInputBox,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: itemEvidence[index]
                                    .EvidenceDetailController
                                    .dropdownValueProductUnit,
                                onChanged: (String newValue) {
                                  setState(() {
                                    itemEvidence[index].EvidenceDetailController
                                        .dropdownValueProductUnit =
                                        newValue;
                                  });
                                },
                                items: itemEvidence[index]
                                    .EvidenceDetailController
                                    .dropdownItemsProductUnit
                                    .map<DropdownMenuItem<String>>((
                                    String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                })
                                    .toList(),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: ((size.width * 75) / 100) / 3.2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "ปริมาณนำส่ง", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: TextField(
                              focusNode: itemEvidence[index]
                                  .EvidenceDetailController
                                  .myFocusNodeDeliveredVolumn,
                              controller: itemEvidence[index]
                                  .EvidenceDetailController.editDeliveredVolumn,
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
                      width: ((size.width * 75) / 100) / 3.2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("ปริมาณชำรุด", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: TextField(
                              focusNode: itemEvidence[index]
                                  .EvidenceDetailController
                                  .myFocusNodeDefectiveVolumn,
                              controller: itemEvidence[index]
                                  .EvidenceDetailController.editDefectiveVolumn,
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
                      width: ((size.width * 75) / 100) / 4.2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("ปริมาณรับ", style: textStyleLabel,),
                          ),
                          new IgnorePointer(
                            ignoring: true,
                            child: Padding(
                              padding: paddingData,
                              child: TextField(
                                focusNode: itemEvidence[index]
                                    .EvidenceDetailController
                                    .myFocusNodeToaVolumn,
                                controller: itemEvidence[index]
                                    .EvidenceDetailController.editTotalVolumn,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization
                                    .words,
                                style: textStyleData,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: ((size.width * 75) / 100) / 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("หน่วย", style: textStyleLabel,),
                          ),
                          Container(
                            //padding: paddingInputBox,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: itemEvidence[index]
                                    .EvidenceDetailController
                                    .dropdownValueVolumeUnit,
                                onChanged: (String newValue) {
                                  setState(() {
                                    itemEvidence[index].EvidenceDetailController
                                        .dropdownValueVolumeUnit =
                                        newValue;
                                  });
                                },
                                items: itemEvidence[index]
                                    .EvidenceDetailController
                                    .dropdownItemsVolumeUnit
                                    .map<DropdownMenuItem<String>>((
                                    String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                })
                                    .toList(),
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
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "หมายเหตุ", style: textStyleLabel,),
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
                          focusNode: itemEvidence[index]
                              .EvidenceDetailController
                              .myFocusNodeEvidenceComment,
                          controller: itemEvidence[index]
                              .EvidenceDetailController.editEvidenceComment,
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
            !widget.IsCreate?Padding(
              padding: EdgeInsets.only(top: 36.0),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(6.0),
                          child: InkWell(
                              onTap: () {
                                _onExport?navigateDeliveredBook(context):_navigateEvidence(context);
                              },
                              child: Text(
                                "แก้ไข", style: textLabelEditNonCheckStyle,)
                          )
                      ),
                      Container(
                          padding: EdgeInsets.all(6.0),
                          child: InkWell(
                              onTap: () {
                                _showDeleteEvidenceAlertDialog();
                              },
                              child: Text(
                                "ลบ", style: textLabelEditNonCheckStyle,)
                          )
                      ),
                    ],
                  )
              ),
            ):Container()
          ],
        );
      }
      Widget _buildCollapsed(int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingLabel,
              child: Text(
                "เลขทะเบียนบัญชี", style: textStyleLabel,),
            ),
            Container(
              padding: paddingData,
              child: Text(
                'Auto Gen', style: textStyleData,),
            ),
            Container(
              padding: paddingLabel,
              child: Text(
                "ชื่อของกลาง", style: textStyleLabel,),
            ),
            Container(
              padding: paddingData,
              child: Text(
                itemEvidence[index].ProductGroup + ' / ' +
                    itemEvidence[index].MainBrand, style: textStyleData,),
            ),
          ],
        );
      }
      return ExpandableNotifier(
        controller: itemEvidence[index].EvidenceDetailController.expController,
        child: Stack(
          children: <Widget>[
            Expandable(
                collapsed: _buildCollapsed(index),
                expanded: _buildExpanded(index)
            ),
            Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    Builder(
                        builder: (context) {
                          var exp = ExpandableController.of(context);
                          return IconButton(
                            icon: Icon(
                              exp.expanded ? Icons.keyboard_arrow_up : Icons
                                  .keyboard_arrow_down, size: 24.0,
                              color: Colors.grey,),
                            onPressed: () {
                              exp.toggle();
                            },
                          );
                        }
                    ),
                  ],
                )
            )
          ],
        ),
      );
    }

    Widget _buildContent(BuildContext context) {
      var size = MediaQuery
          .of(context)
          .size;
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Column(
            children: <Widget>[
              Container(
                width: size.width,
                padding: EdgeInsets.all(22.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: _onExport?Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "เลขที่รับ", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingData,
                      child: Text(
                        "Auto Generate", style: textStyleData,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "วันที่รับ", style: textStyleLabel,),
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
                              _currentGetDate, style: textStyleData,),
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
                              _currentGetTime, style: textStyleData,),
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
                      child: Row(
                        children: <Widget>[
                          Text(
                            "ผู้ตรวจรับ", style: textStyleLabel,),
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
                              focusNode: myFocusNodeCheckEvidencePersonGet,
                              controller: editCheckEvidencePersonGet,
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
                  ],
                )
                    :Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "เลขที่รับ", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingData,
                      child: Text(
                        "Auto Generate", style: textStyleData,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "วันที่รับ", style: textStyleLabel,),
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
                              _currentGetDate, style: textStyleData,),
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
                              _currentGetTime, style: textStyleData,),
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
                      child: Row(
                        children: <Widget>[
                          Text(
                            "ผู้ตรวจรับ", style: textStyleLabel,),
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
                              focusNode: myFocusNodeCheckEvidencePersonGet,
                              controller: editCheckEvidencePersonGet,
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
                            "คลังจัดเก็บ", style: textStyleLabel,),
                          Text("*", style: textStyleStar,),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width,
                      padding: paddingLabel,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: dropdownValueStock,
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueStock = newValue;
                            });
                          },
                          items: dropdownItemsStock
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
                    Container(
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ),
              itemEvidence.length > 0 ?
              Container(
                width: size.width,
                padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: itemEvidence.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        width: size.width,
                        padding: EdgeInsets.all(22.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey[300], width: 1.0),
                            )
                        ),
                        child: Stack(
                          children: <Widget>[
                            _buildExpandableContent(index),
                          ],
                        )
                    );
                  },
                ),
              ) : Container(),
              /*itemMain.CheckEvidenceType == 1 && widget.IsCreate?
              Container(
                padding: EdgeInsets.only(left: 22.0, bottom: 22.0),
                child: _buildButtonImgPicker(),
              )
                  :*/ Container(
                width: size.width,
                padding: EdgeInsets.only(top: 22.0, bottom: 22.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButtonImgPicker(),
                    _buildButtonSelectEvidence()
                  ],
                ),
              ),
              _buildDataImage(context),
            ],
          ),
        ),
      );
    }
    Widget _buildContent_saved(BuildContext context) {
      TextStyle textStyleSentence = TextStyle(color: Color(0xff087de1));
      EdgeInsets paddindSentence = EdgeInsets.only(
          top: 8.0, bottom: 8.0, left: 14.0, right: 14.0);
      var size = MediaQuery
          .of(context)
          .size;

      Widget _buildExpandableContent(int index) {
        var size = MediaQuery
            .of(context)
            .size;
        final double Width = (size.width * 80) / 100;
        TextStyle textStyleLabel = TextStyle(
            fontSize: 16, color: Color(0xff087de1));
        TextStyle textStyleData = TextStyle(fontSize: 18, color: Colors.black);
        EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
        EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
        Widget _buildExpanded(index) {
          return Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "เลขทะเบียนบัญชี", style: textStyleLabel,),
                  ),
                  Container(
                    padding: paddingData,
                    child: Text(
                      'Auto Gen', style: textStyleData,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "ชื่อของกลาง", style: textStyleLabel,),
                  ),
                  Container(
                    padding: paddingData,
                    child: Text(
                      itemEvidence[index].ProductGroup + ' / ' +
                          itemEvidence[index].MainBrand, style: textStyleData,),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ((size.width * 75) / 100) / 3.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "จำนวนนำส่ง", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingData,
                              child: Text('3', style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: ((size.width * 75) / 100) / 3.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("จำนวนชำรุด", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingData,
                              child: Text('2', style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: ((size.width * 75) / 100) / 4.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("จำนวนรับ", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingData,
                              child: Text('1', style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: ((size.width * 75) / 100) / 4.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("หน่วย", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingData,
                              child: Text('ขวด', style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ((size.width * 75) / 100) / 3.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "ปริมาณนำส่ง", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingData,
                              child: Text('5', style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: ((size.width * 75) / 100) / 3.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("ปริมาณชำรุด", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingData,
                              child: Text('2', style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: ((size.width * 75) / 100) / 4.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("ปริมาณรับ", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingData,
                              child: Text('3', style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: ((size.width * 75) / 100) / 4.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("หน่วย", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingData,
                              child: Text('ลิตร', style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "หมายเหตุ", style: textStyleLabel,),
                  ),
                  Container(
                    padding: paddingData,
                    child: Text('คอมเมนต์', style: textStyleData,),
                  ),
                ],
              ),
            ],
          );
        }
        Widget _buildCollapsed(int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  "เลขทะเบียนบัญชี", style: textStyleLabel,),
              ),
              Container(
                padding: paddingData,
                child: Text(
                  'Auto Gen', style: textStyleData,),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "ชื่อของกลาง", style: textStyleLabel,),
              ),
              Container(
                padding: paddingData,
                child: Text(
                  itemEvidence[index].ProductGroup + ' / ' +
                      itemEvidence[index].MainBrand, style: textStyleData,),
              ),
            ],
          );
        }
        return ExpandableNotifier(
          controller: itemEvidence[index].EvidenceDetailController.expController,
          child: Stack(
            children: <Widget>[
              Expandable(
                  collapsed: _buildCollapsed(index),
                  expanded: _buildExpanded(index)
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget>[
                      Builder(
                          builder: (context) {
                            var exp = ExpandableController.of(context);
                            return IconButton(
                              icon: Icon(
                                exp.expanded ? Icons.keyboard_arrow_up : Icons
                                    .keyboard_arrow_down, size: 24.0,
                                color: Colors.grey,),
                              onPressed: () {
                                exp.toggle();
                              },
                            );
                          }
                      ),
                    ],
                  )
              )
            ],
          ),
        );
      }


      return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: size.width,
                  padding: EdgeInsets.all(22.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: _onExport?Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text("เลขที่รับ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemInforChecked.Number,
                          style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("วันที่รับ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemInforChecked.ReturnDate+" "+itemInforChecked.ReturnTime,
                          style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("ผู้ตรวจรับ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemInforChecked.Person, style: textStyleData,),
                      ),
                    ],
                  ):Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text("เลขที่รับ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemInforChecked.Number,
                          style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("วันที่รับ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemInforChecked.ReturnDate+" "+itemInforChecked.ReturnTime,
                          style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("ผู้ตรวจรับ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemInforChecked.Person, style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("คลังจัดเก็บ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemInforChecked.Stock, style: textStyleData,),
                      ),
                    ],
                  ),
                ),
                itemEvidence.length>0 ?
                Container(
                  width: size.width,
                  padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: itemEvidence.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          width: size.width,
                          padding: EdgeInsets.all(22.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey[300], width: 1.0),
                              )
                          ),
                          child:Stack(
                            children: <Widget>[
                              _buildExpandableContent(index),
                            ],
                          )
                      );
                    },
                  ),
                ) : Container(),
                Container(
                  padding: EdgeInsets.only(left: 22.0,bottom: 22.0),
                  child: _buildButtonImgPicker(),
                ),
                _buildDataImage(context),
              ],
            ),
          )
      );
    }
    //data result when search data
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Container(
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
                        'ILG60_B_05_00_06_00', style: textStylePageName,),
                    )
                  ],
                ),
              ),
              Expanded(
                child: new ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: _onSaved ? _buildContent_saved(context) : _buildContent(
                      context),
                ),
              ),
            ],
          ),
        )
    );
  }


//************************start_tab_3*****************************
  Widget _buildContent_tab_3() {
    TextStyle textStylePageName = TextStyle(color: Colors.grey[400]);
    EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
    Widget _buildContent() {
      TextStyle textInputStyleTitle = TextStyle(
          fontSize: 16.0, color: Colors.black);
      return Container(
        padding: EdgeInsets.only(bottom: 22.0),
        //margin: EdgeInsets.all(4.0),
        child: ListView.builder(
            itemCount: itemsFormsTab.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                //padding: EdgeInsets.only(top: 2, bottom: 2),
                child: Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: ListTile(
                      leading: Padding(padding: paddingLabel,
                        child: Text((index + 1).toString() + '. ',
                          style: textInputStyleTitle,),),
                      title: Padding(padding: paddingLabel,
                        child: Text(itemsFormsTab[index].FormsName,
                          style: textInputStyleTitle,),),
                      trailing: Icon(
                        Icons.arrow_forward_ios, color: Colors.grey[300],size: 18.0,),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                TabScreenArrest8Dowload(
                                  Title: itemsFormsTab[index].FormsName,),
                            ));
                      }
                  ),
                ),
              );
            }
        ),
      );
    }
    //data result when search data
    return  Scaffold(
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
                    //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: new Text(
                      'ILG60_B_05_00_09_00', style: textStylePageName,),
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
    );
  }
//************************end_tab_3*******************************


  //ข้อมูลคดี
  //************************start_tab_infor*****************************
  buildCollapsed() {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 85) / 100;
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
          padding: paddingLabel,
          child: Text("เลขที่รับคำกล่าวโทษ", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            itemMain.Number+"/"+itemMain.Year,
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
          child: Text("เลขที่ใบงาน", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            itemMain.Informations.ArrestNumber,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("วันที่จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            itemMain.Informations.ArrestDate + " " +
                itemMain.Informations.ArrestTime,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้ต้องหา", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // new
            itemCount: itemMain.Informations.Suspects.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int j) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: paddingData,
                    child: Text((j + 1).toString() + '. ' +
                        itemMain.Informations.Suspects[j]
                            .SuspectName,
                      style: textStyleData,),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: new Text("เรียกดูประวัติผู้ต้องหา",
                          style: textStyleLink,),
                        onPressed: () {
                          Navigator.of(context)
                              .push(
                              new MaterialPageRoute(
                                  builder: (context) => CompareSuspectScreenFragment(ItemsSuspect: itemMain.Informations.Suspects[j],)));
                        },
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ฐานความผิดมาตรา", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            itemMain.Informations.MistakeNumber,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ฐานความผิดมาตรา", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            itemMain.Informations.MistakeDetail,
            style: textStyleData,),
        ),
      ],
    );
  }

  buildExpanded() {
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
          padding: paddingLabel,
          child: Text("เลขที่รับคำกล่าวโทษ", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            itemMain.Number+"/"+itemMain.Year,
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
          child: Text("เลขที่ใบงาน", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            itemMain.Informations.ArrestNumber,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("วันที่จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            itemMain.Informations.ArrestDate + " " +
                itemMain.Informations.ArrestTime,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้ต้องหา", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // new
            itemCount: itemMain.Informations.Suspects.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int j) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: paddingData,
                    child: Text((j + 1).toString() + '. ' +
                        itemMain.Informations.Suspects[j]
                            .SuspectName,
                      style: textStyleData,),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: new Text("เรียกดูประวัติผู้ต้องหา",
                          style: textStyleLink,),
                        onPressed: () {
                          Navigator.of(context)
                              .push(
                              new MaterialPageRoute(
                                  builder: (context) => CompareSuspectScreenFragment(ItemsSuspect: itemMain.Informations.Suspects[j],)));
                        },
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ฐานความผิดมาตรา", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            itemMain.Informations.MistakeNumber,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ฐานความผิดมาตรา", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            itemMain.Informations.MistakeDetail,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("วันที่รับคดี", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            itemMain.LawsuitDate+" "+itemMain.LawsuitTime,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("วันที่พิสูจน์ของกลาง", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            itemMain.Informations.ProveDate+" "+itemMain.Informations.ProveTime,
            style: textStyleData,),
        ),
        Container(
          padding: paddingData,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // new
            itemCount: itemMain.Informations.Evidenses.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int j) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("ของกลางลำดับ " + (j + 1).toString(),
                      style: textStyleLabel,),
                  ),
                  new Padding(
                    padding: paddingData,
                    child: Text(
                      itemMain.Informations.Evidenses[j].ProductGroup +
                          " / " +
                          itemMain.Informations.Evidenses[j].MainBrand
                      ,
                      style: textStyleData,),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("จำนวน", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                itemMain.Informations.Evidenses[j]
                                    .Capacity.toString(),
                                style: textStyleData,),
                            ),
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
                              child: Text("หน่วย", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                itemMain.Informations.Evidenses[j]
                                    .ProductUnit,
                                style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("ขนาด", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                itemMain.Informations.Evidenses[j]
                                    .Counts
                                    .toString(),
                                style: textStyleData,),
                            ),
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
                              child: Text("หน่วย", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                itemMain.Informations.Evidenses[j]
                                    .CountsUnit,
                                style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "ปริมาณสุทธิ", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                itemMain.Informations.Evidenses[j]
                                    .Volume
                                    .toString(),
                                style: textStyleData,),
                            ),
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
                              child: Text("หน่วย", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                itemMain.Informations.Evidenses[j]
                                    .VolumeUnit,
                                style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  j < itemMain.Informations.Evidenses.length - 1 ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Container(
                          width: Width,
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ) : Container()
                ],
              );
            },
          ),
        ),
      ],
    );
  }


  Widget _buildContent_tab_infor() {
    TextStyle textStylePageName = TextStyle(color: Colors.grey[400]);
    TextStyle textStyleLink = TextStyle(color: Color(0xff4564c2));
    Widget _buildContent(BuildContext context) {
      var size = MediaQuery
          .of(context)
          .size;
      return Container(
        padding: EdgeInsets.only(
            left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border(
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )
        ),
        child: Stack(children: <Widget>[
          ExpandableNotifier(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expandable(
                  collapsed: buildCollapsed(),
                  expanded: buildExpanded(),
                ),
                Row(
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
                              exp.expanded ? "ย่อ..." : "ดูเพิ่มเติม...",
                              style: textStyleLink,
                            )
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
        ),
      );
    }
    //data result when search data
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Container(
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
                        'ILG60_B_04_00_04_00', style: textStylePageName,),
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
        )
    );
  }
}
