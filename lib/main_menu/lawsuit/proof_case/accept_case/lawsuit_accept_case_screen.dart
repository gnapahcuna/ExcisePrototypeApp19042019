import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_sentence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_main.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/detail/lawsuit_accept_screen_sentence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/detail/lawsuit_not_accept_screen_suspect.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_case_information.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_evidence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_form_list.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_proof.dart';
import 'package:flutter/services.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_creen_arrest/tab_arrest_1/tab_screen_arrest_1_saved_constants.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:prototype_app_pang/picker/date_picker.dart';

const double _kPickerSheetHeight = 216.0;
class LawsuitAcceptCaseMainScreenNonProofFragment extends StatefulWidget {
  ItemsLawsuitCaseInformation itemsCaseInformation;
  ItemsLawsuitMainAcceptCase itemsLawsuitMainAcceptCase;
  bool IsPreview;
  bool IsEdit;
  List<ItemsLawsuitMainAcceptCase> itemsPreview;
  LawsuitAcceptCaseMainScreenNonProofFragment({
    Key key,
    @required this.itemsLawsuitMainAcceptCase,
    @required this.itemsCaseInformation,
    @required this.IsPreview,
    @required this.IsEdit,
    @required this.itemsPreview,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<LawsuitAcceptCaseMainScreenNonProofFragment>  with TickerProviderStateMixin {
  TabController tabController;
  TabPageSelector _tabPageSelector;
  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = false;
  bool _onSave = false;
  bool _onFinish = false;

  //เลือกของกลางทั้งหมด
  bool isCheckAll = false;

  List<Choice> choices = <Choice>[
    Choice(title: 'ข้อมูลรับคำกล่าวโทษ'),
    Choice(title: 'ข้อมูลคดี'),
  ];

  ItemsLawsuitMainAcceptCase itemMain;
  List<ItemsLawsuitForms> itemsFormsTab3 = [];

  String _currentDateLawsuit, _currentTimeLawsuit, _currentDateProof,
      _currentTimeProof;
  var dateFormatDate, dateFormatTime;
  DateTime _initDate = DateTime.now();

  DateTime _dtDateLawsuit,_dtDateProof;

  @override
  void initState() {
    super.initState();
    //กรณีพิสูจน์
    if (widget.itemsCaseInformation.IsProof) {
      choices.insert(1, Choice(title: "นำส่งเพื่อพิสูจน์"));
      if(widget.itemsCaseInformation.Proof!=null) {
        _setInitDataProof();
      }
    }

    /*****************************controller main tab**************************/
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);

    var formatter = new DateFormat('yyyy');
    String year = formatter.format(DateTime.now());
    editLawsuitYear.text = (int.parse(year) + 543).toString();

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " +
        (int.parse(splits[3]) + 543).toString();
    _currentDateLawsuit = date;
    _currentTimeLawsuit = dateFormatTime.format(DateTime.now()).toString();
    _currentDateProof = date;
    _currentTimeProof = dateFormatTime.format(DateTime.now()).toString();

    _dtDateLawsuit=DateTime.now();
    _dtDateProof=DateTime.now();


    if (widget.IsPreview) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      _onEdited = widget.IsEdit;
      itemMain = widget.itemsLawsuitMainAcceptCase;
      _setInitDataLawsuit();
      _setDataSaved();
    }
    if (widget.IsEdit) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      //_onEdited = widget.IsEdit;
      itemMain = widget.itemsLawsuitMainAcceptCase;
      _setInitDataLawsuit();
    }

  }

  /*****************************view tab1**************************/
  //node focus
  //lawsuit
  final FocusNode myFocusNodeLawsuitNumber = FocusNode();
  final FocusNode myFocusNodeLawsuitYear = FocusNode();
  final FocusNode myFocusNodeLawsuitPlace = FocusNode();
  final FocusNode myFocusNodeLawsuitPersonName = FocusNode();
  final FocusNode myFocusNodeLawsuitTestimony = FocusNode();

  //poof
  final FocusNode myFocusNodeProofNumber = FocusNode();
  final FocusNode myFocusNodeProofYear = FocusNode();

  //textfield
  //lawsuit
  TextEditingController editLawsuitNumber = new TextEditingController();
  TextEditingController editLawsuitYear = new TextEditingController();
  TextEditingController editLawsuitPlace = new TextEditingController();
  TextEditingController editLawsuitPersonName = new TextEditingController();
  TextEditingController editTestimony = new TextEditingController();

  //poof
  TextEditingController editProofNumber = new TextEditingController();
  TextEditingController editProofYear = new TextEditingController();

  //date
  /**************************list model*******************************/

  /**********************Droupdown View *****************************/
  List<String> dropdownItemsTab3 = ['ผู้จับกุม', 'ผู้ร่วมจับกุม'];

  void _setInitDataLawsuit() {
    editLawsuitNumber.text = widget.itemsLawsuitMainAcceptCase.LawsuitNumber;
    editLawsuitYear.text = widget.itemsLawsuitMainAcceptCase.LawsuitYear;
    _currentDateLawsuit = widget.itemsLawsuitMainAcceptCase.LawsuitDate;
    _currentTimeLawsuit = widget.itemsLawsuitMainAcceptCase.LawsuitTime;
    editLawsuitPlace.text = widget.itemsLawsuitMainAcceptCase.LawsuitPlace;
    editLawsuitPersonName.text =
        widget.itemsLawsuitMainAcceptCase.LawsuitPersonName;
    editTestimony.text = widget.itemsLawsuitMainAcceptCase.LawsuitTestimony;
  }

  void _setInitDataProof() {
    editProofNumber.text = widget.itemsLawsuitMainAcceptCase.Informations.Proof.ProofNumber;
    editProofYear.text = widget.itemsLawsuitMainAcceptCase.Informations.Proof.ProofNumber1;
    _currentDateProof = widget.itemsLawsuitMainAcceptCase.Informations.Proof.ProofDate;
    _currentTimeProof = widget.itemsLawsuitMainAcceptCase.Informations.Proof.ProofDate;
  }

  void _setDataSaved() {
    //is active false
    widget.itemsCaseInformation.IsActive =
    true;

    //add item tab 3
    itemsFormsTab3.add(new ItemsLawsuitForms(
        "เเบบฟอร์มบันทึกรับคำกล่าวโทษ"));
    itemsFormsTab3.add(new ItemsLawsuitForms(
        "เเบบฟอร์มคำให้การของผู้กล่าวโทษ"));
    itemsFormsTab3.add(new ItemsLawsuitForms(
        "คำร้องขอให้เปรียบเทียบคดี คด.1 นายเสนาะ อุตโม"));
    itemsFormsTab3.add(new ItemsLawsuitForms(
        "คำร้องขอให้เปรียบเทียบคดี คด.1 นางวิไล เมืองใจ"));
    itemsFormsTab3.add(
        new ItemsLawsuitForms("ทะเบียนประวัติผู้กระทำผิด"));
    itemsFormsTab3.add(new ItemsLawsuitForms(
        "รายละเอียดการกระทำผิดผู้กระทำผิด"));

    choices.add(Choice(title: 'แบบฟอร์ม'));
    tabController =
        TabController(length: choices.length, vsync: this);
    _tabPageSelector =
    new TabPageSelector(controller: tabController);
  }

  @override
  void dispose() {
    super.dispose();
    editLawsuitNumber.dispose();
    editLawsuitYear.dispose();
    editLawsuitPlace.dispose();
    editLawsuitPersonName.dispose();
    editTestimony.dispose();

    //proof
    editProofNumber.dispose();
    editProofYear.dispose();
  }

  /*****************************method for main tab**************************/
  void choiceAction(Constants constants) {
    print(constants.text);
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _onSaved = false;
        _onEdited = true;
        choices.removeAt(choices.length-1);
      } else {
        _onDeleted=true;
        _showDeleteAlertDialog();
      }
    });
  }

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
                  choices.removeAt(choices.length-1);

                  Navigator.pop(context, itemMain);
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

  void clearTextfield() {
    editLawsuitNumber.clear();
    editLawsuitYear.clear();
    editLawsuitPlace.clear();
    editLawsuitPersonName.clear();
    editTestimony.clear();

    editProofYear.clear();
    editProofNumber.clear();

    widget.itemsCaseInformation.Evidenses.forEach((item){
      item.IsCkecked=false;
    });
  }

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

                if(!_onEdited) {
                  Navigator.pop(mContext,"Back");
                }else{
                  setState(() {
                    _onSaved=true;
                    _onEdited=false;
                  });
                }
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }

  void _showCancelAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelAlertDialog(context);
      },
    );
  }

  /*****************************method for main tab1**************************/
  Future<DateTime> _selectDate(context) async {
    return await showDatePicker(
      context: context,
      firstDate: _initDate,
      initialDate: DateTime.now(),
      lastDate: DateTime(2025),
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

      print("widget.IsPreview" + widget.IsPreview.toString());

      //add data in main model
      itemMain = new ItemsLawsuitMainAcceptCase(
        editLawsuitNumber.text,
        editLawsuitYear.text,
        _currentDateLawsuit,
        _currentTimeLawsuit,
        editLawsuitPersonName.text,
        widget.itemsCaseInformation,
        editLawsuitPlace.text,
        editTestimony.text,
        "เปรียบเทียบ",
        false,
      );


      //ตรวจสอบการเลือกของกลาง
      List<ItemsLawsuitEvidence> items=[];
      widget.itemsCaseInformation.Evidenses.forEach((item){
        if(item.IsCkecked){
          items.add(item);
        }
      });
      //add data in proof model
      widget.itemsCaseInformation.Proof = new ItemsLawsuitProof(
          editProofNumber.text,
          editProofYear.text,
          _currentDateProof,
          _currentTimeProof,
          items
      );

      _setDataSaved();
      //selected tab3
      tabController.animateTo((choices.length - 1));
    });
  }

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
                _onSaved ? Navigator.pop(context, widget.itemsCaseInformation) :
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
          child: Center(child: Text("รับคำกล่าวโทษ", style: appBarStyle),
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
              widget.itemsCaseInformation.IsProof ? ButtonTheme(
                  minWidth: 44.0,
                  padding: new EdgeInsets.all(0.0),
                  child: FlatButton(
                    onPressed: (){
                      //เมื่อพิสูจน์
                    },
                    child: Row(
                      children: <Widget>[
                        Text('พิสูจน์', style: appBarStylePay),
                        Icon(Icons.arrow_forward_ios, color: Colors.white,)
                      ],
                    ),
                  )) : (itemMain.IsCompare ? new ButtonTheme(
                  minWidth: 44.0,
                  padding: new EdgeInsets.all(0.0),
                  child: FlatButton(
                    onPressed: (){
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
              Navigator.pop(context, widget.itemsCaseInformation);
            }
          } else {
            Navigator.pop(context, widget.itemsCaseInformation);
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
                  children: widget.itemsCaseInformation.IsProof ? (_onFinish ? <
                      Widget>[
                    //กรณีพิสูจน์
                    _buildContent_tab_1(),
                    _buildContent_tab_proof(),
                    _buildContent_tab_2(),
                    _buildContent_tab_3(),
                  ] :
                  <Widget>[
                    _buildContent_tab_1(),
                    _buildContent_tab_proof(),
                    _buildContent_tab_2(),
                  ])
                      : _onFinish ? <Widget>[
                    //กรณีไม่พิสูจน์
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

  //************************start_tab_1*****************************
  Widget _buildContent_tab_1() {
    //style content
    TextStyle textStyleLabel = TextStyle(
        fontSize: 16, color: Color(0xff087de1));
    TextStyle textStyleData = TextStyle(fontSize: 18, color: Colors.black);
    TextStyle textStyleSubData = TextStyle(fontSize: 18, color: Colors.black38);
    TextStyle textStylePageName = TextStyle(color: Colors.grey[400]);
    TextStyle textStyleStar = TextStyle(color: Colors.red);
    EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
    TextStyle textStyleSub = TextStyle(fontSize: 16, color: Colors.black);

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
                            Text("เลขที่รับคำกล่าวโทษ", style: textStyleLabel,),
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
                                      focusNode: myFocusNodeLawsuitNumber,
                                      controller: editLawsuitNumber,
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
                                      focusNode: myFocusNodeLawsuitYear,
                                      controller: editLawsuitYear,
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
                              "วันที่รับคดีคำกล่าวโทษ", style: textStyleLabel,),
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
                                _currentDateLawsuit, style: textStyleData,),
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
                                          Current: _dtDateLawsuit);
                                    }).then((s) {
                                  String date = "";
                                  List splits = dateFormatDate.format(
                                      s).toString().split(" ");
                                  date = splits[0] + " " + splits[1] +
                                      " " +
                                      (int.parse(splits[3]) + 543)
                                          .toString();
                                  setState(() {
                                    _dtDateLawsuit=s;
                                    _currentDateLawsuit=date;
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
                                _currentTimeLawsuit, style: textStyleData,),
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
                        child: Text("สถานที่ทำการ", style: textStyleLabel,),
                      ),
                      Container(
                        padding: paddingData,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              //padding: paddingData,
                              child: TextField(
                                focusNode: myFocusNodeLawsuitPlace,
                                controller: editLawsuitPlace,
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
                        child: Text("ชื่อผู้รับคดี", style: textStyleLabel,),
                      ),
                      Container(
                        padding: paddingData,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              //padding: paddingData,
                              child: TextField(
                                focusNode: myFocusNodeLawsuitPersonName,
                                controller: editLawsuitPersonName,
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
                              "คำให้การของผู้กล่าวโทษ", style: textStyleLabel,),
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
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                focusNode: myFocusNodeLawsuitTestimony,
                                controller: editTestimony,
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
                Container(
                  width: size.width,
                  padding: EdgeInsets.only(top: 8.0, bottom: 32.0),
                  child: Container(
                      padding: EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          border: Border(
                            top: BorderSide(
                                color: Colors.grey[300], width: 1.0),
                            bottom: BorderSide(
                                color: Colors.grey[300], width: 1.0),
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("ผู้ต้องหา", style: textStyleLabel,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                // new
                                itemCount: widget.itemsCaseInformation
                                    .Suspects
                                    .length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int j) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding: paddingData,
                                        child: Text((j + 1).toString() + ". " +
                                            widget.itemsCaseInformation
                                                .Suspects[j].SuspectName,
                                          style: textStyleData,),
                                      ),
                                      Container(
                                        padding: paddingData,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                  right: 8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  //
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xff3b69f3),
                                                    border: Border.all(
                                                        color: Colors.black12),
                                                  ),
                                                  child: Padding(
                                                      padding: const EdgeInsets
                                                          .all(4.0),
                                                      child: Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                        size: 18,
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: paddingData,
                                              child: Text("เปรียบเทียบ",
                                                style: textStyleSubData,),
                                            ),
                                          ],
                                        ),
                                      ),
                                      widget.itemsCaseInformation
                                          .Suspects
                                          .length>1 && j != widget.itemsCaseInformation
                                          .Suspects
                                          .length-1?
                                      Container(
                                        padding: paddingData,
                                        height: 1.0,
                                        color: Colors.grey[300],
                                      ):Container(),
                                    ],
                                  );
                                }
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ],
            ),
          )
      );
    }

    _navigateLawsuitAcceptCaseSentence(BuildContext context,
        ItemsLawsuitSentence itemSentence, index) async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            LawsuitAcceptSentenceScreenFragment(
              ItemSentence: itemSentence,
            )),
      );
      if (result.toString() != "Back") {
        itemMain.Informations.Suspects[index].Sentences = result;
      }
    }

    Widget _buildContent_saved(BuildContext context) {
      TextStyle textStyleSentence = TextStyle(color: Color(0xff087de1));
      EdgeInsets paddindSentence = EdgeInsets.only(
          top: 8.0, bottom: 8.0, left: 14.0, right: 14.0);
      var size = MediaQuery
          .of(context)
          .size;
      return Container(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(
                  left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
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
                        child: Text("สถานที่ทำการ", style: textStyleLabel,),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: paddingData,
                            child: Text(
                              itemMain.LawsuitNumber + '/' +
                                  itemMain.LawsuitYear,
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
                          "วันที่รับคดีคำกล่าวโทษ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemMain.LawsuitDate + ' ' + itemMain.LawsuitTime,
                          style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("ชื่อผู้รับคดี", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemMain.LawsuitPersonName, style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "ลักษณะคดีรายผู้ต้องหา", style: textStyleLabel,),
                      ),
                      Container(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            // new
                            itemCount: itemMain.Informations.Suspects.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              EdgeInsets paddingSuspect = EdgeInsets.only(
                                  left: 8.0, top: 4, bottom: 4);
                              return Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: paddingSuspect,
                                    child: Text((index + 1).toString() + '. ' +
                                        itemMain.Informations.Suspects[index]
                                            .SuspectName,
                                      style: textStyleData,),
                                  ),
                                  itemMain.IsCompare ? Padding(
                                    padding: paddingSuspect,
                                    child: Text('(' +
                                        itemMain.LawsuitCompare + ')',
                                      style: textStyleSub,),
                                  )
                                      : Container(
                                    child: new InkWell(
                                      child: Card(
                                        shape: new RoundedRectangleBorder(
                                            side: new BorderSide(
                                                color: Color(0xff087de1),
                                                width: 1.5),
                                            borderRadius: BorderRadius.circular(
                                                10.0)
                                        ),
                                        elevation: 0.0,
                                        child: Padding(padding: paddindSentence,
                                            child: Text('คำพิพากษาศาล',
                                              style: textStyleSentence,)
                                        ),
                                      ),
                                      onTap: () {
                                        _navigateLawsuitAcceptCaseSentence(
                                            context, itemMain.Informations
                                            .Suspects[index].Sentences, index);
                                      },
                                    ),
                                  )
                                ],
                              );
                            }
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("สถานที่ทำการ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemMain.LawsuitPlace, style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "คำให้การของผู้กล่าวโทษ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemMain.LawsuitTestimony, style: textStyleData,),
                      ),
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
                    'ILG60_B_02_00_03_00', style: textStylePageName,),
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
  buildCollapsed() {
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
          child: Text("เลขที่ใบงาน", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            widget.itemsCaseInformation.ArrestNumber,
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
          child: Text("วันที่จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            widget.itemsCaseInformation.ArrestDate + " " +
                widget.itemsCaseInformation.ArrestTime,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            widget.itemsCaseInformation.ArrestPersonName,
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
            itemCount: widget.itemsCaseInformation.Suspects.length,
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
                        widget.itemsCaseInformation.Suspects[j]
                            .SuspectName,
                      style: textStyleData,),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: new Text("ดูประวัติผู้ต้องหา",
                          style: textStyleLink,),
                        onPressed: () {
                          Navigator.of(context)
                              .push(
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      LawsuitNotAcceptSuspectScreenFragment(
                                        ItemsSuspect: widget
                                            .itemsCaseInformation.Suspects[j],)));
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
            widget.itemsCaseInformation.MistakeNumber,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ฐานความผิด", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            widget.itemsCaseInformation.MistakeDetail,
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
          child: Text("เลขที่ใบงาน", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            widget.itemsCaseInformation.ArrestNumber,
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
          child: Text("วันที่จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            widget.itemsCaseInformation.ArrestDate + " " +
                widget.itemsCaseInformation.ArrestTime,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            widget.itemsCaseInformation.ArrestPersonName,
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
            itemCount: widget.itemsCaseInformation.Suspects.length,
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
                        widget.itemsCaseInformation.Suspects[j]
                            .SuspectName,
                      style: textStyleData,),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: new Text("ดูประวัติผู้ต้องหา",
                          style: textStyleLink,),
                        onPressed: () {
                          Navigator.of(context)
                              .push(
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      LawsuitNotAcceptSuspectScreenFragment(
                                        ItemsSuspect: widget
                                            .itemsCaseInformation.Suspects[j],)));
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
            widget.itemsCaseInformation.MistakeNumber,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ฐานความผิด", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            widget.itemsCaseInformation.MistakeDetail,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("สถานที่จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            widget.itemsCaseInformation.ArrestPlace,
            style: textStyleData,),
        ),
        Padding(
          padding: paddingData,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // new
            itemCount: widget.itemsCaseInformation.Evidenses.length,
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
                      widget.itemsCaseInformation.Evidenses[j].ProductGroup +
                          " / " +
                          widget.itemsCaseInformation.Evidenses[j].MainBrand
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
                                widget.itemsCaseInformation.Evidenses[j]
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
                                widget.itemsCaseInformation.Evidenses[j]
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
                                widget.itemsCaseInformation.Evidenses[j].Counts
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
                                widget.itemsCaseInformation.Evidenses[j]
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
                                widget.itemsCaseInformation.Evidenses[j].Volume
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
                                widget.itemsCaseInformation.Evidenses[j]
                                    .VolumeUnit,
                                style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  j < widget.itemsCaseInformation.Evidenses.length - 1 ? Row(
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
                        'ILG60_B_02_00_04_00', style: textStylePageName,),
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

//************************start_tab_3*****************************
  Widget _buildContent_tab_3() {
    TextStyle textStylePageName = TextStyle(color: Colors.grey[400]);
    TextStyle textStyleLink = TextStyle(color: Color(0xff4564c2));
    Widget _buildContent() {
      TextStyle textInputStyleTitle = TextStyle(
          fontSize: 16.0, color: Colors.black);
      return Container(
        padding: EdgeInsets.only(bottom: 4.0),
        child: Container(
          padding: EdgeInsets.only(bottom: 0.0),
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
                          bottom: BorderSide(
                              color: Colors.grey[300], width: 1.0),
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
        ),
      );
    }
    //data result when search data
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
                      'ILG60_B_02_00_07_00', style: textStylePageName,),
                  )
                ],
              ),
            ),
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

//************************end_tab_3*******************************

//************************start_tab_proof*****************************
  Widget _buildContent_tab_proof() {
    //style content
    TextStyle textStyleLabel = TextStyle(
        fontSize: 16, color: Color(0xff087de1));
    TextStyle textStyleData = TextStyle(fontSize: 18, color: Colors.black);
    TextStyle textStyleSubData = TextStyle(fontSize: 18, color: Colors.black38);
    TextStyle textStylePageName = TextStyle(color: Colors.grey[400]);
    TextStyle textStyleStar = TextStyle(color: Colors.red);
    EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyleCheckAll = TextStyle(
        fontSize: 16.0, color: labelColor);

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
                            Text("เลขที่หนังสือนำส่ง", style: textStyleLabel,),
                            Text("*", style: textStyleStar,),
                          ],
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: ((size.width * 75) / 100) / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    //padding: paddingData,
                                    child: TextField(
                                      focusNode: myFocusNodeProofNumber,
                                      controller: editProofNumber,
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
                                      focusNode: myFocusNodeProofYear,
                                      controller: editProofYear,
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
                              "วันที่ออกหนังสือ", style: textStyleLabel,),
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
                                _currentDateProof, style: textStyleData,),
                              trailing: Icon(
                                  FontAwesomeIcons.calendarAlt, size: 28.0),
                              onTap: () {
                                /*_selectDate(context).then((value) {
                                  setState(() {
                                    //_initDate = value.toLocal();
                                    _currentDateProof =
                                        dateFormatDate.format(value.toLocal())
                                            .toString();
                                  });
                                });*/
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DynamicDialog(
                                          Current: _dtDateProof);
                                    }).then((s) {
                                  String date = "";
                                  List splits = dateFormatDate.format(
                                      s).toString().split(" ");
                                  date = splits[0] + " " + splits[1] +
                                      " " +
                                      (int.parse(splits[3]) + 543)
                                          .toString();
                                  setState(() {
                                    _dtDateProof=s;
                                    _currentDateProof=date;
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
                                _currentTimeProof, style: textStyleData,),
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
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left:22.0,right: 22.0,top: 12.0,bottom: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Text("เลือกของกลางทั้งหมด",
                          style: textInputStyleCheckAll,),
                        padding: EdgeInsets.all(8.0),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isCheckAll =
                            !isCheckAll;
                            if (isCheckAll) {
                              widget
                                  .itemsCaseInformation.Evidenses.forEach((
                                  item) {
                                item.IsCkecked = true;
                              });
                            } else {
                              widget
                                  .itemsCaseInformation.Evidenses.forEach((
                                  item) {
                                item.IsCkecked = false;
                              });
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: isCheckAll
                                ? Color(0xff3b69f3)
                                : Colors.grey[200],
                            border: isCheckAll
                                ? Border.all(color: Color(0xff3b69f3), width: 2)
                                : Border.all(color: Colors.grey[400], width: 2),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: isCheckAll
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
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget
                            .itemsCaseInformation.Evidenses.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                top: 0.2, bottom: 0.2),
                            child: Container(
                              padding: EdgeInsets.all(22.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  border: Border(
                                    top: BorderSide(
                                        color: Colors.grey[300],
                                        width: 1.0),
                                    bottom: BorderSide(
                                        color: Colors.grey[300],
                                        width: 1.0),
                                  )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .start,
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          padding: paddingLabel,
                                          child: Text(
                                            widget
                                                .itemsCaseInformation
                                                .Evidenses[index]
                                                .ProductCategory +
                                                widget
                                                    .itemsCaseInformation
                                                    .Evidenses[index]
                                                    .ProductType + ' > ' +
                                                widget
                                                    .itemsCaseInformation
                                                    .Evidenses[index]
                                                    .MainBrand +
                                                widget
                                                    .itemsCaseInformation
                                                    .Evidenses[index]
                                                    .ProductModel +
                                                ' > ' +
                                                widget
                                                    .itemsCaseInformation
                                                    .Evidenses[index]
                                                    .SubProductType +
                                                ' ' +
                                                widget
                                                    .itemsCaseInformation
                                                    .Evidenses[index]
                                                    .SubSetProductType +
                                                ' > ' +
                                                widget
                                                    .itemsCaseInformation
                                                    .Evidenses[index]
                                                    .Capacity.toString() +
                                                ' ' +
                                                widget
                                                    .itemsCaseInformation
                                                    .Evidenses[index]
                                                    .ProductUnit,
                                            style: textStyleData,),
                                        ),
                                      ),
                                      Center(
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                widget
                                                    .itemsCaseInformation
                                                    .Evidenses[index]
                                                    .IsCkecked =
                                                !widget
                                                    .itemsCaseInformation
                                                    .Evidenses[index]
                                                    .IsCkecked;

                                                int count = 0;
                                                widget.itemsCaseInformation.Evidenses.forEach((ev){
                                                  if(ev.IsCkecked){
                                                    count++;
                                                  }
                                                });
                                                count==widget.itemsCaseInformation.Evidenses.length?isCheckAll=true:isCheckAll=false;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(
                                                  2.0),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color: widget
                                                    .itemsCaseInformation
                                                    .Evidenses[index]
                                                    .IsCkecked
                                                    ? Color(0xff3b69f3)
                                                    : Colors.white,
                                                border: widget
                                                    .itemsCaseInformation
                                                    .Evidenses[index]
                                                    .IsCkecked
                                                    ? Border.all(
                                                    color: Color(
                                                        0xff3b69f3),
                                                    width: 2)
                                                    : Border.all(
                                                    color: Colors
                                                        .grey[400],
                                                    width: 2),
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets
                                                      .all(0.0),
                                                  child: widget
                                                      .itemsCaseInformation
                                                      .Evidenses[index]
                                                      .IsCkecked
                                                      ? Icon(
                                                    Icons.check,
                                                    size: 18.0,
                                                    color: Colors.white,
                                                  )
                                                      : Container(
                                                    height: 18.0,
                                                    width: 18.0,
                                                    color: Colors
                                                        .transparent,
                                                  )
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
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
      return Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
                            child: Text("เลขที่หนังสือนำส่ง", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              widget.itemsCaseInformation.Proof.ProofNumber + '/' + widget.itemsCaseInformation.Proof.ProofNumber1,
                              style: textStyleData,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "วันที่ออกหนังสือ", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              widget.itemsCaseInformation.Proof.ProofDate + ' ' + widget.itemsCaseInformation.Proof.ProofTime,
                              style: textStyleData,),
                          ),
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
              Container(
                padding: paddingLabel,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget
                      .itemsCaseInformation.Proof.Evidences.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 0.1, bottom: 0.1),
                      child: Container(
                        padding: EdgeInsets.all(22.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border(
                              top: BorderSide(
                                  color: Colors.grey[300],
                                  width: 1.0),
                              bottom: BorderSide(
                                  color: Colors.grey[300],
                                  width: 1.0),
                            )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .start,
                          crossAxisAlignment: CrossAxisAlignment
                              .start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: paddingLabel,
                                    child: Text((index+1).toString()+'. '+
                                        widget
                                            .itemsCaseInformation
                                            .Proof
                                            .Evidences[index]
                                            .ProductCategory +
                                        widget
                                            .itemsCaseInformation
                                            .Proof
                                            .Evidences[index]
                                            .ProductType + ' > ' +
                                        widget
                                            .itemsCaseInformation
                                            .Proof
                                            .Evidences[index]
                                            .MainBrand +
                                        widget
                                            .itemsCaseInformation
                                            .Evidenses[index]
                                            .ProductModel +
                                        ' > ' +
                                        widget
                                            .itemsCaseInformation
                                            .Proof
                                            .Evidences[index]
                                            .SubProductType +
                                        ' ' +
                                        widget
                                            .itemsCaseInformation
                                            .Proof
                                            .Evidences[index]
                                            .SubSetProductType +
                                        ' > ' +
                                        widget
                                            .itemsCaseInformation
                                            .Proof
                                            .Evidences[index]
                                            .Capacity.toString() +
                                        ' ' +
                                        widget
                                            .itemsCaseInformation
                                            .Proof
                                            .Evidences[index]
                                            .ProductUnit,
                                      style: textStyleData,),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        ),
      );
    }

    //data result when search data
    return Scaffold(
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
                      'ILG60_B_02_00_11_00', style: textStylePageName,),
                  )
                ],
              ),
            ),
            Expanded(
              child: _onSaved&&widget.itemsCaseInformation.Proof!=null?_buildContent_saved(context):_buildContent(context),
            ),
          ],
        ),
      ),
    );
  }
//************************end_tab_poof*******************************
}
