import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/Model/choice.dart';
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

class CompareMainScreenFragment extends StatefulWidget {
  ItemsCompareMain itemsCompareMain;
  bool IsEdit;
  bool IsPreview;
  CompareMainScreenFragment({
    Key key,
    @required this.itemsCompareMain,
    @required this.IsEdit,
    @required this.IsPreview,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<CompareMainScreenFragment>  with TickerProviderStateMixin {
  TabController tabController;
  TabPageSelector _tabPageSelector;
  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = false;
  bool _onSave = false;
  bool _onFinish = false;

  List<Choice> choices = <Choice>[
    Choice(title: 'ชำระค่าปรับ'),
    Choice(title: 'ข้อมูลคดี'),
  ];

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete),
  ];

  //item หลักทั้งหมด
  ItemsCompareMain itemMain;
  //item forms
  List<ItemsCompareForms> itemsFormsTab=[];

  //วันที่อละเวลาปัจจุบัน
  String _currentProveDate,
      _currentProveTime;
  var dateFormatDate, dateFormatTime;
  //_dt
  DateTime _dtCheckEvidence = DateTime.now();
  //node focus ตรวจรับของกลาง
  final FocusNode myFocusNodeCheckEvidenceNumber = FocusNode();
  final FocusNode myFocusNodeCheckEvidenceYear = FocusNode();
  final FocusNode myFocusNodeCheckEvidencePlace = FocusNode();
  final FocusNode myFocusNodeCheckEvidencePersonName = FocusNode();
  //textfield ตรวจรับของกลาง
  TextEditingController editCheckEvidenceNumber= new TextEditingController();
  TextEditingController editCheckEvidenceYear = new TextEditingController();
  TextEditingController editCheckEvidencePlace= new TextEditingController();
  TextEditingController editCheckEvidencePersonName = new TextEditingController();

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

    itemMain=widget.itemsCompareMain;
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
    }
  }
  void _setInitDataProve() {
    //tab 2
   /* editCheckEvidenceNumber.text = itemMain.CheckEvidence.Number;
    editCheckEvidenceYear.text = itemMain.CheckEvidence.Year;
    editCheckEvidencePlace.text = itemMain.CheckEvidence.Place;
    editCheckEvidencePersonName.text = itemMain.CheckEvidence.Person;
    _currentProveDate=itemMain.CheckEvidence.Date;
    _currentProveTime=itemMain.CheckEvidence.Time;*/
  }

  void _setDataSaved() {
    choices[0].title="ข้อมูลชำระค่าปรับ";
    _onFinish=true;

    if(choices.length==2) {
      //เพิ่ม tab แบบฟอร์ม
      choices.add(Choice(title: 'แบบฟอร์ม'));
      //เพิ่ม item forms
      itemsFormsTab.add(new ItemsCompareForms("บันทึกตรวจรับของกลาง","นายสมชาย ไขแสง"));
    }
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

      //

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
          //physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              centerTitle: true,
              title: new Text("เปรียบเทียบและชำระค่าปรับ",
                style: appBarStyle,
              ),
              elevation: 0.0,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    if(_onSaved) {
                      Navigator.pop(context, "Back");
                    }else{
                      _showCancelAlertDialog(context);
                    }
                  }),
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
                  children: _onFinish ? <Widget>[
                    _buildContent_tab_1(),
                    _buildContent_tab_2(),
                    _buildContent_tab_3(),
                  ] :
                  <Widget>[
                    _buildContent_tab_1(),
                    _buildContent_tab_2(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //************************end_tab_1*******************************
  _navigate(BuildContext context,ItemsCompareCaseInformation itemsInfor,ItemsCompareSuspect itemSuspect,ItemsCompareSuspectDetail itemSuspectDetail,index) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CompareDetailScreenFragment(
          ItemInformations: itemsInfor,
          ItemSuspect: itemSuspect,
          ItemSuspectDetail: itemSuspectDetail,
          /*IsEdit: false,
          IsPreview: false,*/
        )),
      );
      if(result.toString()!="Back") {
        itemMain.Informations.Suspects[index] = result;
        if(itemMain.Informations.IsCompare){
          _setDataSaved();
        }
      }
  }

  Widget _buildContent_tab_1() {
    //style content
    var size = MediaQuery
        .of(context)
        .size;
    TextStyle textStyleLabel = TextStyle(
        fontSize: 16, color: Color(0xff087de1));
    TextStyle textStyleData = TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.w500);
    TextStyle textStylePageName = TextStyle(color: Colors.grey[400]);
    TextStyle textStyleBill = TextStyle(color: Colors.black);
    TextStyle textStyleButtonAccept = TextStyle(fontSize: 16,color: Colors.white);
    EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

    TextStyle textStyleTitleLabel = TextStyle(fontSize: 16,color: Colors.grey[400]);
    TextStyle textStyleTitleData = TextStyle(fontSize: 18,color: Colors.black);


    Widget _buildContent(BuildContext context) {
      return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Column(
              children: <Widget>[
                itemMain.Informations.IsCompare ? Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Container(
                      padding: EdgeInsets.all(22.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          border: Border(
                            bottom: BorderSide(
                                color: Colors.grey[300], width: 1.0),
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 4.0),
                            child: Container(
                              width: size.width,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: paddingLabel,
                                      child: Text(
                                        "คดีเปรียบเทียบที่",
                                        style: textStyleTitleLabel,),
                                    ),
                                    Padding(
                                      padding: paddingData,
                                      child: Text(
                                        'น. ' +
                                            itemMain.Informations
                                                .CompareNumber +
                                            "/" +
                                            itemMain.Informations.CompareYear,
                                        style: textStyleTitleData,),
                                    ),
                                  ]
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                ) : Container(),
                Container(
                  width: size.width,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: itemMain.Informations.Suspects.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          itemMain.Informations.Suspects[index].IsActive
                              ? _navigate(
                              context,
                              itemMain.Informations,
                              itemMain.Informations
                                  .Suspects[index],
                              itemMain.Informations
                                  .Suspects[index].SuspectDetails,
                            index
                          )
                              : null;
                        },
                        child: Container(
                          //padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(18.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.rectangle,
                                      border: Border(
                                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                                        bottom: BorderSide(
                                            color: Colors.grey[300],
                                            width: 1.0),
                                      )
                                  ),
                                  child: Stack(children: <Widget>[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: <Widget>[

                                        Container(
                                          padding: paddingLabel,
                                          child: Text(
                                            "ผู้ต้องหาลำดับที่ " +
                                                (index + 1).toString(),
                                            style: textStyleLabel,),
                                        ),
                                        Padding(
                                          padding: paddingData,
                                          child: Text(
                                            itemMain.Informations
                                                .Suspects[index]
                                                .SuspectName,
                                            style: textStyleData,),
                                        ),
                                        Container(
                                          padding: paddingLabel,
                                          child: Text(
                                            "ยอดชำระ", style: textStyleLabel,),
                                        ),
                                        Padding(
                                          padding: paddingData,
                                          child: Text(
                                            itemMain.Informations
                                                .Suspects[index]
                                                .FineValue
                                                .toString(),
                                            style: textStyleData,),
                                        ),
                                      ],
                                    ),
                                    itemMain.Informations.Suspects[index]
                                        .IsActive
                                        ? Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 22.0, bottom: 22.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            children: <Widget>[
                                              Icon(Icons.arrow_forward_ios,
                                                size: 18,)
                                            ],
                                          ),
                                        ),
                                        itemMain.Informations.Suspects[index]
                                            .SuspectDetails.IsRelease ?
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 22.0, bottom: 22.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            children: <Widget>[
                                              Padding(
                                                padding: paddingData,
                                                child: Text("ปล่อยตัวชั่วคราว",
                                                  style: textStyleData,),
                                              ),
                                            ],
                                          ),
                                        ) :
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 22.0, bottom: 22.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            children: <Widget>[
                                              Padding(
                                                padding: paddingData,
                                                child: Text("เลขใบเสร็จ : " +
                                                    itemMain.Informations
                                                        .Suspects[index]
                                                        .SuspectDetails
                                                        .BillNumber + "/"
                                                    + itemMain.Informations
                                                        .Suspects[index]
                                                        .SuspectDetails
                                                        .BillBookNo,
                                                  style: textStyleBill,),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                        : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        itemMain.Informations.Suspects[index]
                                            .IsActive ?
                                        Icon(Icons.arrow_forward_ios, size: 18,)
                                            : Container(
                                          padding: EdgeInsets.only(bottom: 8.0),
                                          child: new Card(
                                              color: Color(0xff087de1),
                                              shape: new RoundedRectangleBorder(
                                                  side: new BorderSide(
                                                      color: Color(0xff087de1),
                                                      width: 1.5),
                                                  borderRadius: BorderRadius
                                                      .circular(12.0)
                                              ),
                                              elevation: 0.0,
                                              child: Container(
                                                  width: 130.0,
                                                  //height: 40,
                                                  child: Center(
                                                    child: MaterialButton(
                                                      onPressed: () {
                                                        _navigate(
                                                            context,
                                                            itemMain
                                                                .Informations,
                                                            itemMain
                                                                .Informations
                                                                .Suspects[index],
                                                            itemMain.Informations
                                                                .Suspects[index].SuspectDetails,index);
                                                      },
                                                      splashColor: Color(
                                                          0xff087de1),
                                                      //highlightColor: Colors.blue,
                                                      child: Center(
                                                        child: Text(
                                                          "เปรียบเทียบ",
                                                          style: textStyleButtonAccept,),),
                                                    ),
                                                  )
                                              )
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  ),
                                ),
                              ],
                            )
                        ),
                      );
                    },
                  ),
                ),
                itemMain.Informations.IsCompare ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          CompareRewardScreenFragment(
                            itemsInformations: itemMain.Informations,
                          )),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 4.0),
                    width: size.width,
                    child: Container(
                        padding: EdgeInsets.all(22.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey[300], width: 1.0),
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "เงินสินบน-รางวัล",
                                style: textStyleLabel,),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 18.0,)
                          ],
                        )
                    ),
                  ),
                ) : Container()
              ],
            ),
          )
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
                    'ILG60_B_04_00_03_00', style: textStylePageName,),
                )
              ],
            ),
          ),
          Expanded(
            child: _buildContent(
                context),
          ),
        ],
      ),
    );
  }
//************************end_tab_1*******************************


  //************************start_tab_2*****************************
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


  Widget _buildContent_tab_2() {
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
                      subtitle: Padding(padding: paddingData,
                        child: Text(itemsFormsTab[index].SuspectName,
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
                      'ILG60_B_04_00_08_00', style: textStylePageName,),
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
}
