import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_form_list.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:prototype_app_pang/main_menu/prove/model/delivered_for_storage.dart';
import 'package:prototype_app_pang/main_menu/prove/model/evidence.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_check_evidence.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_evidence.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_main.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_manage_evidence_screen.dart';
import 'package:prototype_app_pang/picker/date_picker.dart';
import 'package:prototype_app_pang/model/choice.dart';

class ProveMainScreenFragment extends StatefulWidget {
  ItemsProveMain itemsProveMain;
  bool IsEdit;
  bool IsPreview;
  ProveMainScreenFragment({
    Key key,
    @required this.itemsProveMain,
    @required this.IsEdit,
    @required this.IsPreview,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<ProveMainScreenFragment>  with TickerProviderStateMixin {
  TabController tabController;
  TabPageSelector _tabPageSelector;
  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = false;
  bool _onSave = false;
  bool _onFinish = false;

  //พิสูจน์นอกสถานที่ทำการ
  bool IsOutside = true;
  //พิสูจน์ของกลาง
  bool IsProve = false;
  //นำส่งของกลางเพื่อจัดเก็บ
  bool IsDeliveredStorage=true;

  List<Choice> choices = <Choice>[
    Choice(title: 'ข้อมูลคดี'),
    Choice(title: 'ตรวจรับของกลาง'),
    Choice(title: 'พิสูจน์ของกลาง'),
    Choice(title: 'นำส่งเพื่อจัดเก็บ'),
  ];

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete),
  ];

  //item หลักทั้งหมด
  ItemsProveMain itemMain;
  //item forms
  List<ItemsLawsuitForms> itemsFormsTab3=[];

  //วันที่อละเวลาปัจจุบัน
  String _currentProveDate,_currentDeriveredDate,_currentProveEvidenceDate,_currentDeliverDate,
      _currentProveTime,_currentDeriveredTime,_currentProveEvidenceTime,_currentDeliverTime;
  var dateFormatDate, dateFormatTime;
  //_dt
  DateTime _dtCheckEvidence = DateTime.now();
  DateTime _dtProve= DateTime.now();
  DateTime _dtDerivered= DateTime.now();
  DateTime _dtDeliverDate= DateTime.now();
  //node focus ตรวจรับของกลาง
  final FocusNode myFocusNodeCheckEvidenceNumber = FocusNode();
  final FocusNode myFocusNodeCheckEvidenceYear = FocusNode();
  final FocusNode myFocusNodeCheckEvidencePlace = FocusNode();
  final FocusNode myFocusNodeCheckEvidencePersonName = FocusNode();
  //node focus พิสูจน์ของกลาง
  final FocusNode myFocusNodeProveCommand = FocusNode();
  final FocusNode myFocusNodeProvePerson = FocusNode();
  final FocusNode myFocusNodeProveLabNumber = FocusNode();
  final FocusNode myFocusNodeProveLabYear = FocusNode();
  final FocusNode myFocusNodeProvePetitionNumber = FocusNode();
  final FocusNode myFocusNodeProveReportNumber = FocusNode();
  //node focus นำส่งเพื่อจัดเก็บ
  final FocusNode myFocusNodeDeriveredNumber = FocusNode();
  final FocusNode myFocusNodeDeriveredYear = FocusNode();
  final FocusNode myFocusNodeDeriveredPersonName = FocusNode();
  final FocusNode myFocusNodeDeriveredDepartment = FocusNode();
  final FocusNode myFocusNodeDeriveredStockName= FocusNode();
  final FocusNode myFocusNodeDeriveredTransport= FocusNode();
  //textfield ตรวจรับของกลาง
  TextEditingController editCheckEvidenceNumber= new TextEditingController();
  TextEditingController editCheckEvidenceYear = new TextEditingController();
  TextEditingController editCheckEvidencePlace= new TextEditingController();
  TextEditingController editCheckEvidencePersonName = new TextEditingController();
  //textfield พิสูจน์ของกลาง
  TextEditingController editProveCommand= new TextEditingController();
  TextEditingController editProvePerson= new TextEditingController();
  TextEditingController editProveLabNumber = new TextEditingController();
  TextEditingController editProveLabYear= new TextEditingController();
  TextEditingController editProvePetitionNumber = new TextEditingController();
  TextEditingController editProveReportNumber = new TextEditingController();
  //textfield นำส่งเพื่อจัดเก็บ
  TextEditingController editDeriveredNumber= new TextEditingController();
  TextEditingController editDeriveredYear = new TextEditingController();
  TextEditingController editDeriveredPersonName= new TextEditingController();
  TextEditingController editDeriveredDepartment = new TextEditingController();
  TextEditingController editDeriveredStockName= new TextEditingController();
  TextEditingController editDeriveredTransport = new TextEditingController();

  @override
  void initState() {
    super.initState();
    /*****************************controller main tab**************************/
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " +
        (int.parse(splits[3]) + 543).toString();
    //วันและเวลาตรวจสอบของกลาง
    _currentProveDate = date;
    _currentProveTime = dateFormatTime.format(DateTime.now()).toString();
    //วันและเวลาวันที่พิสูจน์
    _currentProveEvidenceDate = date;
    _currentProveEvidenceTime = dateFormatTime.format(DateTime.now()).toString();
    //วันและเวลาวันที่นำส่ง(Lab)
    _currentDeliverDate = date;
    _currentDeliverTime = dateFormatTime.format(DateTime.now()).toString();
    //วันและเวลานำส่งเพื่อจัดเก็บ
    _currentDeriveredDate = date;
    _currentDeriveredTime = dateFormatTime.format(DateTime.now()).toString();

    itemMain=widget.itemsProveMain;
    if (widget.IsPreview) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      _onEdited = widget.IsEdit;
      _setInitDataProve();
      _setDataSaved();
    }
    if (widget.IsEdit) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      //_onEdited = widget.IsEdit;
      _setInitDataProve();
      tabController.animateTo(1);
    }
  }
  void _setInitDataProve() {
    //tab 2
    editCheckEvidenceNumber.text = itemMain.CheckEvidence.Number;
    editCheckEvidenceYear.text = itemMain.CheckEvidence.Year;
    editCheckEvidencePlace.text = itemMain.CheckEvidence.Place;
    editCheckEvidencePersonName.text = itemMain.CheckEvidence.Person;
    _currentProveDate=itemMain.CheckEvidence.Date;
    _currentProveTime=itemMain.CheckEvidence.Time;
    IsOutside=itemMain.CheckEvidence.IsOutside;
    //tab 3
    editProvePerson.text = itemMain.ProveEvidence.Person;
    editProveCommand.text = itemMain.ProveEvidence.Command;
    _currentProveEvidenceDate = itemMain.ProveEvidence.Date;
    _currentProveEvidenceTime = itemMain.ProveEvidence.Time;
    IsProve = itemMain.ProveEvidence.IsScientific;
    if(itemMain.ProveEvidence.IsScientific) {
      editProveLabNumber.text = itemMain.ProveEvidence.LabNumber;
      editProveLabYear.text = itemMain.ProveEvidence.LabYear;
      editProvePetitionNumber.text = itemMain.ProveEvidence.PetitionNumber;
      editProveReportNumber.text = itemMain.ProveEvidence.ReportNumber;
    }
    //tab4
    editDeriveredNumber.text = itemMain.Delivered.Number;
    editDeriveredYear.text = itemMain.Delivered.Year;
    editDeriveredPersonName.text = itemMain.Delivered.Person;
    editDeriveredDepartment.text = itemMain.Delivered.Department;
    editDeriveredStockName.text = itemMain.Delivered.StockName;
    editDeriveredTransport.text = itemMain.Delivered.TranMethod;
    _currentDeriveredDate=itemMain.Delivered.Date;
    _currentDeriveredTime=itemMain.Delivered.Time;
    IsDeliveredStorage=itemMain.Delivered.IsDelivered;
  }

  void _setDataSaved() {
    //เพิ่ม item forms
    itemsFormsTab3.add(new ItemsLawsuitForms("บันทึกตรวจรับของกลาง"));
    itemsFormsTab3.add(new ItemsLawsuitForms("บัญชีของกลาง ส.ส 2/4"));
    itemsFormsTab3.add(new ItemsLawsuitForms("บันทึกการตรวจพิสูจน์นอกสถานที่"));
    itemsFormsTab3.add(new ItemsLawsuitForms("บันทึกการนำส่งของกลาง (ขก. 1)"));
    //เพิ่ม tab แบบฟอร์ม
    choices.add(Choice(title: 'แบบฟอร์ม'));
    tabController =
        TabController(length: choices.length, vsync: this);
    _tabPageSelector =
    new TabPageSelector(controller: tabController);
  }


  @override
  void dispose() {
    super.dispose();
    //dismiss textfield for tab 2
    editCheckEvidenceNumber.dispose();
    editCheckEvidenceYear.dispose();
    editCheckEvidencePlace.dispose();
    editCheckEvidencePersonName.dispose();
    //dismiss textfield for tab 3
    editProvePerson.dispose();
    editProveCommand.dispose();
    editProveLabNumber.dispose();
    editProveLabYear.dispose();
    editProvePetitionNumber.dispose();
    editProveReportNumber.dispose();
    //dismiss textfield for tab 4
    editDeriveredNumber.dispose();
    editDeriveredYear.dispose();
    editDeriveredPersonName.dispose();
    editDeriveredDepartment.dispose();
    editDeriveredStockName.dispose();
    editDeriveredTransport.dispose();
  }

  /*****************************method for main tab**************************/
  //เมื่อกด popup แสดงการแก้ไขหรือลบ
  void choiceAction(Constants constants) {
    print(constants.text);
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _onSaved = false;
        _onEdited = true;
        choices.removeAt(choices.length - 1);
      } else {
        _onDeleted = true;
        _showDeleteAlertDialog();
      }
    });
  }
  //คำสั่งที่เลือกอย่างไดอย่างหนึ่งใน delete dialog
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
                  clearTextfield();
                  choices.removeAt(choices.length - 1);

                  Navigator.pop(context, itemMain);
                });
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }
  //แสดง dialog ลบรายการ
  void _showDeleteAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelDeleteDialog();
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

      //เมื่อทำการบันทึกรายการแล้ว
      itemMain.IsActive=true;
      //เพิ่มข้อมูลส่วนตรวจสอบของกลาง
      itemMain.CheckEvidence = new ItemsProveCheckEvidence(
          editCheckEvidenceNumber.text,
          editCheckEvidenceYear.text,
          _currentProveDate,
          _currentProveTime,
          editCheckEvidencePlace.text,
          editCheckEvidencePersonName.text,
        IsOutside
      );
      //เพิ่มข้อมูลส่วนพิสูจน์ของกลาง
      itemMain.ProveEvidence = new ItemsProveEvidence(
          _currentProveEvidenceDate,
          _currentProveEvidenceTime,
          editProveCommand.text,
          editProvePerson.text,
          IsProve,
          editProveLabNumber.text,
          editProveLabYear.text,
          editProvePetitionNumber.text,
          editProveReportNumber.text,
          itemMain.Informations.Evidenses
      );
      //เพิ่มข้อมูลส่วนนำส่งเพื่อจัดเก็บ
      itemMain.Delivered = new DeliveredForStorage(
          IsDeliveredStorage,
          editDeriveredNumber.text,
          editDeriveredYear.text,
          _currentDeriveredDate,
          _currentDeriveredTime,
          editDeriveredPersonName.text,
          editDeriveredDepartment.text,
          editDeriveredStockName.text,
          editDeriveredTransport.text
      );

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
          width: width / 3,
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
          child: Center(child: Text("พิสูจน์ของกลาง", style: appBarStyle),
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
              (itemMain.IsActive ? new ButtonTheme(
                  minWidth: 44.0,
                  padding: new EdgeInsets.all(0.0),
                  child: FlatButton(
                    onPressed: () {
                      //เมื่อชำระค่าปรับ
                    },
                    child: Row(
                      children: <Widget>[
                        Text('ชำระค่าปรับ', style: appBarStylePay),
                        Icon(Icons.arrow_forward_ios, color: Colors.white,)
                      ],
                    ),
                  )
              ) : Container())
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
                    isScrollable: choices.length != 2 ? true : false,
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
                  children: _onFinish ? <Widget>[
                    _buildContent_tab_1(),
                    _buildContent_tab_2(),
                    _buildContent_tab_3(),
                    _buildContent_tab_4(),
                    _buildContent_tab_5(),
                  ] :
                  <Widget>[
                    _buildContent_tab_1(),
                    _buildContent_tab_2(),
                    _buildContent_tab_3(),
                    _buildContent_tab_4(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //************************start_tab_1*****************************
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
          child: Text("ผู้จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            itemMain.Informations.ArrestPersonName,
            style: textStyleData,),
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
          child: Text("ฐานความผิด", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            itemMain.Informations.MistakeDetail,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("วันที่รับคดีคำกล่าวโทษ", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            itemMain.LawsuitDate+" "+itemMain.LawsuitTime,
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
          child: Text("ผู้จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            itemMain.Informations.ArrestPersonName,
            style: textStyleData,),
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
          child: Text("ฐานความผิด", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            itemMain.Informations.MistakeDetail,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("วันที่รับคดีคำกล่าวโทษ", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            itemMain.LawsuitDate+" "+itemMain.LawsuitTime,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ชื่อผู้รับคดี", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            itemMain.LawsuitPersonName,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("เลขหนังสือนำส่งพิสูจน์", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            itemMain.BookNumber,
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


  Widget _buildContent_tab_1() {
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
                        'ILG60_B_03_00_03_00', style: textStylePageName,),
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

//************************end_tab_2*******************************
  Widget _buildContent_tab_2() {
    //style content
    TextStyle textStyleLabel = TextStyle(
        fontSize: 16, color: Color(0xff087de1));
    TextStyle textStyleData = TextStyle(fontSize: 18, color: Colors.black);
    TextStyle textStylePageName = TextStyle(color: Colors.grey[400]);
    TextStyle textStyleStar = TextStyle(color: Colors.red);
    EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);


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
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
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
                                    IsOutside = !IsOutside;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(4.0),
                                    color: IsOutside ? Color(0xff3b69f3) : Colors
                                        .white,
                                    border: Border.all(
                                        width: 1.5,
                                        color: Colors.black38
                                    ),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: IsOutside
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
                                "พิสูจน์นอกสถานที่ทำการ", style: textStyleLabel,),
                            ),
                          ],
                        ),
                      ),
                      IsOutside?Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Text("ทะเบียนตรวจพิสูจน์", style: textStyleLabel,),
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        //padding: paddingData,
                                        child: TextField(
                                          focusNode: myFocusNodeCheckEvidenceNumber,
                                          controller: editCheckEvidenceNumber,
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        //padding: paddingData,
                                        child: TextField(
                                          focusNode: myFocusNodeCheckEvidenceYear,
                                          controller: editCheckEvidenceYear,
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
                                Text(
                                  "วันที่ตรวจรับ*", style: textStyleLabel,),
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
                                    _currentProveDate, style: textStyleData,),
                                  trailing: Icon(
                                      FontAwesomeIcons.calendarAlt, size: 28.0),
                                  onTap: () {
                                    /*_selectDate(context).then((value) {
                                  setState(() {
                                    //_initDate = value.toLocal();
                                    _currentDateLawsuit =
                                        dateFormatDate.format(value.toLocal())
                                            .toString();
                                  });
                                });*/
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DynamicDialog(
                                              Current: _dtCheckEvidence);
                                        }).then((s) {
                                      String date = "";
                                      List splits = dateFormatDate.format(
                                          s).toString().split(" ");
                                      date = splits[0] + " " + splits[1] +
                                          " " +
                                          (int.parse(splits[3]) + 543)
                                              .toString();
                                      setState(() {
                                        _dtCheckEvidence=s;
                                        _currentProveDate=date;
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
                                Text("เวลา", style: textStyleLabel,),
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
                                    _currentProveTime, style: textStyleData,),
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
                                  "เขียนที่", style: textStyleLabel,),
                                Text("*", style: textStyleStar,),
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
                                    focusNode: myFocusNodeCheckEvidencePlace,
                                    controller: editCheckEvidencePlace,
                                    keyboardType: TextInputType.text,
                                    textCapitalization: TextCapitalization.words,
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
                                  "ผู้รับมอบของกลาง", style: textStyleLabel,),
                                Text("*", style: textStyleStar,),
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
                                    focusNode: myFocusNodeCheckEvidencePersonName,
                                    controller: editCheckEvidencePersonName,
                                    textCapitalization: TextCapitalization.words,
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
                      ):Container()
                    ],
                  ),
                ),
              ],
            ),
          )
      );
    }
    Widget _buildContent_saved(BuildContext context) {
      return Container(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(
                  left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border(
                    //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )
              ),
              child: Stack(
                children: <Widget>[
                  itemMain.CheckEvidence.IsOutside ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "ทะเบียนตรวจพิสูจน์", style: textStyleLabel,),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: paddingData,
                            child: Text(
                              itemMain.CheckEvidence.Number + '/' +
                                  itemMain.CheckEvidence.Year,
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
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "วันที่ตรวจรับ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemMain.CheckEvidence.Date + ' ' +
                              itemMain.CheckEvidence.Time,
                          style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("เขียนที่", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemMain.CheckEvidence.Place, style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "ผู้รับมอบของกลาง", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemMain.CheckEvidence.Person, style: textStyleData,),
                      ),
                    ],
                  ) :
                  Container(
                    padding: paddingLabel,
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              right: 18.0, top: 8, bottom: 8.0),
                          child: InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(4.0),
                                color: Colors.grey[300],
                                border: Border.all(
                                    width: 1.5,
                                    color: Colors.black38
                                ),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    height: 16.0,
                                    width: 16.0,
                                  )
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "พิสูจน์นอกสถานที่ทำการ", style: textStyleLabel,),
                        ),
                      ],
                    ),
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                    'ILG60_B_03_00_04_00', style: textStylePageName,),
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
//************************end_tab_2*******************************

  //************************start_tab_3*******************************
  _navigate(BuildContext context,ItemsEvidence itemsProve) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProveManageEvidenceScreenFragment(
          ItemsEvidences: itemsProve,
        IsScientific: IsProve,
      )),
    );
    if(result.toString()!="Back") {
      itemMain.Informations.Evidenses = result;
    }
  }
  //มูลค่าภาษีรวม
  double taxTotal=0;
  Widget _calTaxTotal(double tax,int index,int len){
    TextStyle textStyleLabel = TextStyle(
        fontSize: 16, color: Color(0xff087de1));
    TextStyle textStyleData = TextStyle(fontSize: 18, color: Colors.black);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
    taxTotal += tax;
    return index==len-1?Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text(
            "มูลค่าภาษีรวม", style: textStyleLabel,),
        ),
        ListTile(
          trailing: Text(
            taxTotal.toString() + " บาท",
            style: textStyleData,),
        ),
      ],
    ):Container();
  }
  Widget _buildContent_tab_3() {
    //style content
    TextStyle textStyleLabel = TextStyle(
        fontSize: 16, color: Color(0xff087de1));
    TextStyle textStyleData = TextStyle(fontSize: 18, color: Colors.black);
    TextStyle textStylePageName = TextStyle(color: Colors.grey[400]);
    TextStyle textStyleStar = TextStyle(color: Colors.red);
    EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

    Widget _buildContent(BuildContext context) {
      taxTotal=0;
      var size = MediaQuery
          .of(context)
          .size;
      return SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(18.0),
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
                                    IsProve = !IsProve;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(4.0),
                                    color: IsProve ? Color(0xff3b69f3) : Colors
                                        .white,
                                    border: Border.all(
                                        width: 1.5,
                                        color: Colors.black38
                                    ),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: IsProve
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
                                "ส่งพิสูจน์ทางเคมีและวิทยาศาสตร์",
                                style: textStyleLabel,),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Row(
                          children: <Widget>[
                            Text(
                              "วันที่พิสูจน์", style: textStyleLabel,),
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
                                _currentProveEvidenceDate,
                                style: textStyleData,),
                              trailing: Icon(
                                  FontAwesomeIcons.calendarAlt, size: 28.0),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DynamicDialog(
                                          Current: _dtProve);
                                    }).then((s) {
                                  String date = "";
                                  List splits = dateFormatDate.format(
                                      s).toString().split(" ");
                                  date = splits[0] + " " + splits[1] +
                                      " " +
                                      (int.parse(splits[3]) + 543)
                                          .toString();
                                  setState(() {
                                    _dtProve = s;
                                    _currentProveEvidenceDate = date;
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
                                _currentProveTime, style: textStyleData,),
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
                          "คำสั่ง", style: textStyleLabel,),
                      ),
                      Container(
                        padding: paddingData,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              //padding: paddingData,
                              child: TextField(
                                focusNode: myFocusNodeProveCommand,
                                controller: editProveCommand,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
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
                              "ผู้พิสูจน์ของกลาง", style: textStyleLabel,),
                            Text("*", style: textStyleStar,),
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
                                focusNode: myFocusNodeProvePerson,
                                controller: editProvePerson,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
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
                      IsProve ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "เลขที่หนังสือนำส่ง Lab", style: textStyleLabel,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: ((size.width * 75) / 100) / 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      new Container(
                                        //padding: paddingData,
                                        child: TextField(
                                          focusNode: myFocusNodeProveLabNumber,
                                          controller: editProveLabNumber,
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      new Container(
                                        //padding: paddingData,
                                        child: TextField(
                                          focusNode: myFocusNodeProveLabYear,
                                          controller: editProveLabYear,
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
                            child: Text(
                              "วันที่นำส่ง", style: textStyleLabel,),
                          ),
                          Container(
                            padding: paddingData,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new ListTile(
                                  title: Text(
                                    _currentDeliverDate, style: textStyleData,),
                                  trailing: Icon(
                                      FontAwesomeIcons.calendarAlt, size: 28.0),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DynamicDialog(
                                              Current: _dtDeliverDate);
                                        }).then((s) {
                                      String date = "";
                                      List splits = dateFormatDate.format(
                                          s).toString().split(" ");
                                      date = splits[0] + " " + splits[1] +
                                          " " +
                                          (int.parse(splits[3]) + 543)
                                              .toString();
                                      setState(() {
                                        _dtDeliverDate = s;
                                        _currentDeliverDate = date;
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
                            child: Text(
                              "เวลา", style: textStyleLabel,),
                          ),
                          Container(
                            padding: paddingData,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new ListTile(
                                  title: Text(
                                    _currentDeliverTime, style: textStyleData,),
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
                              "เลขที่คำร้อง", style: textStyleLabel,),
                          ),
                          Container(
                            padding: paddingData,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  //padding: paddingData,
                                  child: TextField(
                                    focusNode: myFocusNodeProvePetitionNumber,
                                    controller: editProvePetitionNumber,
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
                              "เลขที่รายงานผล", style: textStyleLabel,),
                          ),
                          Container(
                            padding: paddingData,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  //padding: paddingData,
                                  child: TextField(
                                    focusNode: myFocusNodeProveReportNumber,
                                    controller: editProveReportNumber,
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
                      ) : Container()
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: size.width,
                    padding: EdgeInsets.all(18.0),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "มูลค่าภาษีพิสูจน์", style: textStyleLabel,),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      (j + 1).toString() + ". " +
                                          itemMain.Informations.Evidenses[j]
                                              .ProductGroup + " / " +
                                          itemMain.Informations.Evidenses[j]
                                              .MainBrand,
                                      style: textStyleLabel,),
                                    trailing: Icon(Icons.arrow_forward_ios,size: 18.0,),
                                    onTap: () {
                                      _navigate(context,itemMain.Informations.Evidenses[j]);
                                    },
                                  ),
                                  ListTile(
                                    trailing: Text(
                                      (itemMain.Informations.Evidenses[j].Descriptions==null?0:
                                      itemMain.Informations.Evidenses[j].Descriptions.TaxProveValue).toString() + " บาท",
                                      style: textStyleData,),
                                  ),
                                  Padding(
                                    padding: paddingData,
                                    child: Container(
                                      height: 1.0,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                  _calTaxTotal(itemMain.Informations.Evidenses[j].Descriptions==null?0:
                                  itemMain.Informations.Evidenses[j].Descriptions.TaxProveValue,
                                      j,itemMain.Informations.Evidenses.length)
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      return Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(
                      left: 18.0, right: 18.0, top: 18.0, bottom: 18.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
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
                            child: Text("วันที่พิสูจน์", style: textStyleLabel,),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: paddingData,
                                child: Text(
                                  itemMain.ProveEvidence.Date + ' ' +
                                      itemMain.ProveEvidence.Time,
                                  style: textStyleData,),
                              ),
                            ],
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "คำสั่ง", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              itemMain.ProveEvidence.Command,
                              style: textStyleData,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text("ผู้พิสูจน์ของกลาง", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              itemMain.ProveEvidence.Person, style: textStyleData,),
                          ),
                          itemMain.ProveEvidence.IsScientific?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "เลขที่หนังสือนำส่ง Lab", style: textStyleLabel,),
                              ),
                              Padding(
                                padding: paddingData,
                                child: Text(
                                  itemMain.ProveEvidence.LabNumber+" / "+itemMain.ProveEvidence.LabYear, style: textStyleData,),
                              ),
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "วันที่นำส่ง", style: textStyleLabel,),
                              ),
                              Padding(
                                padding: paddingData,
                                child: Text(
                                  itemMain.ProveEvidence.Date+" "+itemMain.ProveEvidence.Time, style: textStyleData,),
                              ),
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "เลขที่คำร้องขอ", style: textStyleLabel,),
                              ),
                              Padding(
                                padding: paddingData,
                                child: Text(
                                  itemMain.ProveEvidence.PetitionNumber, style: textStyleData,),
                              ),
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "เลขที่รายงานผล", style: textStyleLabel,),
                              ),
                              Padding(
                                padding: paddingData,
                                child: Text(
                                  itemMain.ProveEvidence.ReportNumber, style: textStyleData,),
                              ),
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
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Container(
                  padding: EdgeInsets.all(18.0),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "มูลค่าภาษีพิสูจน์", style: textStyleLabel,),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    (j + 1).toString() + ". " +
                                        itemMain.Informations.Evidenses[j]
                                            .ProductGroup + " / " +
                                        itemMain.Informations.Evidenses[j]
                                            .MainBrand,
                                    style: textStyleLabel,),
                                  trailing: Icon(Icons.arrow_forward_ios,size: 18.0,),
                                  onTap: () {
                                    _navigate(context,itemMain.Informations.Evidenses[j]);
                                  },
                                ),
                                ListTile(
                                  trailing: Text(
                                    (itemMain.Informations.Evidenses[j].Descriptions==null?0:
                                    itemMain.Informations.Evidenses[j].Descriptions.TaxProveValue).toString() + " บาท",
                                    style: textStyleData,),
                                ),
                                Padding(
                                  padding: paddingData,
                                  child: Container(
                                    height: 1.0,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                _calTaxTotal(itemMain.Informations.Evidenses[j].Descriptions==null?0:
                                itemMain.Informations.Evidenses[j].Descriptions.TaxProveValue,
                                    j,itemMain.Informations.Evidenses.length)
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
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
                    'ILG60_B_03_00_05_00', style: textStylePageName,),
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
//************************end_tab_3*******************************

//************************start_tab_4*******************************
  Widget _buildContent_tab_4() {
    //style content
    TextStyle textStyleLabel = TextStyle(
        fontSize: 16, color: Color(0xff087de1));
    TextStyle textStyleData = TextStyle(fontSize: 18, color: Colors.black);
    TextStyle textStylePageName = TextStyle(color: Colors.grey[400]);
    TextStyle textStyleStar = TextStyle(color: Colors.red);
    EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

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
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
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
                                    IsDeliveredStorage = !IsDeliveredStorage;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(4.0),
                                    color: IsDeliveredStorage ? Color(0xff3b69f3) : Colors
                                        .white,
                                    border: Border.all(
                                        width: 1.5,
                                        color: Colors.black38
                                    ),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: IsDeliveredStorage
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
                                "นำส่งของกลางเพื่อจัดเก็บ", style: textStyleLabel,),
                            ),
                          ],
                        ),
                      ),
                    IsDeliveredStorage?Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child:  Text("เลขที่หนังสือนำส่ง", style: textStyleLabel,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Padding(
                                  padding: paddingData,
                                  child: new Text("กค.",
                                    style: textStyleData,
                                  ),
                                ),
                                Container(
                                  width: ((size.width * 75) / 100) / 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        //padding: paddingData,
                                        child: TextField(
                                          focusNode: myFocusNodeDeriveredNumber,
                                          controller: editDeriveredNumber,
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        //padding: paddingData,
                                        child: TextField(
                                          focusNode: myFocusNodeDeriveredYear,
                                          controller: editDeriveredYear,
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
                            child: Text(
                              "วันที่ออกหนังสือ", style: textStyleLabel,),
                          ),
                          Container(
                            padding: paddingData,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new ListTile(
                                  title: Text(
                                    _currentDeriveredDate, style: textStyleData,),
                                  trailing: Icon(
                                      FontAwesomeIcons.calendarAlt, size: 28.0),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DynamicDialog(
                                              Current: _dtDerivered);
                                        }).then((s) {
                                      String date = "";
                                      List splits = dateFormatDate.format(
                                          s).toString().split(" ");
                                      date = splits[0] + " " + splits[1] +
                                          " " +
                                          (int.parse(splits[3]) + 543)
                                              .toString();
                                      setState(() {
                                        _dtDerivered=s;
                                        _currentDeriveredDate=date;
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
                            child: Text("เวลา", style: textStyleLabel,),
                          ),
                          Container(
                            padding: paddingData,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new ListTile(
                                  title: Text(
                                    _currentDeriveredTime, style: textStyleData,),
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
                              "ผู้นำส่งของกลางไปจัดเก็บ", style: textStyleLabel,),
                          ),
                          Container(
                            padding: paddingData,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  //padding: paddingData,
                                  child: TextField(
                                    focusNode: myFocusNodeDeriveredPersonName,
                                    controller: editDeriveredPersonName,
                                    keyboardType: TextInputType.text,
                                    textCapitalization: TextCapitalization.words,
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
                              "หน่วยงานต้นทาง", style: textStyleLabel,),
                          ),
                          Container(
                            padding: paddingData,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  //padding: paddingData,
                                  child: TextField(
                                    focusNode: myFocusNodeDeriveredDepartment,
                                    controller: editDeriveredDepartment,
                                    textCapitalization: TextCapitalization.words,
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
                              "คลังจัดเก็บ", style: textStyleLabel,),
                          ),
                          Container(
                            padding: paddingData,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  //padding: paddingData,
                                  child: TextField(
                                    focusNode: myFocusNodeDeriveredStockName,
                                    controller: editDeriveredStockName,
                                    textCapitalization: TextCapitalization.words,
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
                              "วิธีการขนส่ง", style: textStyleLabel,),
                          ),
                          Container(
                            padding: paddingData,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  //padding: paddingData,
                                  child: TextField(
                                    focusNode: myFocusNodeDeriveredTransport,
                                    controller: editDeriveredTransport,
                                    textCapitalization: TextCapitalization.words,
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
                      ):Container()
                    ],
                  ),
                ),
              ],
            ),
          )
      );
    }
    Widget _buildContent_saved(BuildContext context) {
      return Container(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(
                  left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border(
                    //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )
              ),
              child: Stack(
                children: <Widget>[
                  itemMain.Delivered.IsDelivered ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "เลขที่หนังสือนำส่ง", style: textStyleLabel,),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: paddingData,
                            child: Text(
                              itemMain.Delivered.Number + '/' +
                                  itemMain.Delivered.Year,
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
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "วันที่ออกหนังสือ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemMain.Delivered.Date + ' ' +
                              itemMain.Delivered.Time,
                          style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "ผู้นำส่งของกลางไปจัดเก็บ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemMain.Delivered.Person, style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "หน่วยงานต้นทาง", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemMain.Delivered.Department, style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "คลังจัดเก็บ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemMain.Delivered.StockName, style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "วิธีการขนส่ง", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemMain.Delivered.TranMethod, style: textStyleData,),
                      ),
                    ],
                  ) : Container(
                    padding: paddingLabel,
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              right: 18.0, top: 8, bottom: 8.0),
                          child: InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(4.0),
                                color: Colors.grey[300],
                                border: Border.all(
                                    width: 1.5,
                                    color: Colors.black38
                                ),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    height: 16.0,
                                    width: 16.0,
                                  )
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "นำส่งของกลางเพื่อจัดเก็บ", style: textStyleLabel,),
                        ),
                      ],
                    ),
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                    'ILG60_B_03_00_09_00', style: textStylePageName,),
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
//************************end_tab_4*******************************

//************************start_tab_5*****************************
  Widget _buildContent_tab_5() {
    TextStyle textStylePageName = TextStyle(color: Colors.grey[400]);
    TextStyle textStyleLink = TextStyle(color: Color(0xff4564c2));
    Widget _buildContent() {
      TextStyle textInputStyleTitle = TextStyle(
          fontSize: 16.0, color: Colors.black);
      return Container(
        padding: EdgeInsets.only(bottom: 22.0),
        //margin: EdgeInsets.all(4.0),
        child: ListView.builder(
            itemCount: itemsFormsTab3.length,
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
                      title: Text((index + 1).toString() + '. ' +
                          itemsFormsTab3[index].FormsName,
                        style: textInputStyleTitle,),
                      trailing: Icon(
                        Icons.arrow_forward_ios, color: Colors.grey[300],),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TabScreenArrest8Dowload(Title: itemsFormsTab3[index].FormsName,),
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
                      'ILG60_B_03_00_10_00', style: textStylePageName,),
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
//************************end_tab_5*******************************
}
