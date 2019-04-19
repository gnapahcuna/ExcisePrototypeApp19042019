import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/detail/lawsuit_not_accept_screen_suspect.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_case_information.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_form_list.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_main.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_creen_arrest/tab_arrest_1/tab_screen_arrest_1_saved_constants.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';

const double _kPickerSheetHeight = 216.0;
class LawsuitNotAcceptCaseMainScreenFragment extends StatefulWidget {
  ItemsLawsuitCaseInformation itemsCaseInformation;
  LawsuitNotAcceptCaseMainScreenFragment({
    Key key,
    @required this.itemsCaseInformation,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<LawsuitNotAcceptCaseMainScreenFragment>  with TickerProviderStateMixin {
  TabController tabController;
  TabPageSelector _tabPageSelector;
  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = false;
  bool _onSave = false;
  bool _onFinish = false;

  List<Choice> choices = <Choice>[
    Choice(title: 'ข้อมูลรับคำกล่าวโทษ'),
    Choice(title: 'ข้อมูลคดี'),
  ];

  ItemsLawsuitMainNotAcceptCase itemMain;
  List<ItemsLawsuitForms> itemsFormsTab3=[];

  @override
  void initState() {
    super.initState();
    /*****************************controller main tab**************************/
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);


    /*****************************initData for tab1**************************/

  }

  /*****************************view tab1**************************/
  //node focus
  final FocusNode myFocusNodeReason = FocusNode();

  //textfield
  TextEditingController editReason = new TextEditingController();

  //date

  /**************************list model*******************************/

  /**********************Droupdown View *****************************/
  List<String> dropdownItemsTab3 = ['ผู้จับกุม', 'ผู้ร่วมจับกุม'];


  @override
  void dispose() {
    super.dispose();
    /*****************************dispose focus tab 1**************************/

  }

  /*****************************method for main tab**************************/
  void choiceAction(Constants constants) {
    print(constants.text);
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _onSaved = false;
        _onEdited = true;
        choices.removeAt(2);
      } else {
        _onDeleted = true;
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
                Navigator.pop(context,"Back");
                setState(() {
                  _onSaved = false;
                  _onEdited = false;
                  _onDeleted = false;
                  _onSave = false;
                  choices.removeAt(2);
                  clearTextfield();
                  Navigator.pop(context,widget.itemsCaseInformation);
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

                if(!_onEdited) {
                  Navigator.pop(mContext, "Back");
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

  void clearTextfield(){
    editReason.clear();
  }

  void onSaved()async{
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
      itemMain =new ItemsLawsuitMainNotAcceptCase("ไม่รับคำกล่าวโทษ", "นายเอกะฒน์ สายสมุทร", editReason.text);
      //is active false
      widget.itemsCaseInformation.IsActive=true;
      //add item tab 3
      itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์มบันทึกรับคำกล่าวโทษ"));
      itemsFormsTab3.add(new ItemsLawsuitForms("ทะเบียนประวัติผู้กระทำผิด"));
      itemsFormsTab3.add(new ItemsLawsuitForms("รายละเอียดการกระทำผิดผู้กระทำผิด"));
      choices.add(Choice(title: 'แบบฟอร์ม'));
      tabController =
          TabController(length: choices.length, vsync: this);
      _tabPageSelector =
      new TabPageSelector(controller: tabController);
      tabController.animateTo(choices.length-1);
    });
  }

  Future<bool> onLoadAction() async {
    await new Future.delayed(const Duration(seconds: 3));
    return true;
  }

  /*****************************method for main tab1**************************/
  @override
  Widget build(BuildContext context) {
    TextStyle tabStyle = TextStyle(fontSize: 16.0, color: Colors.black54);
    TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white);
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
                /*_onEdited ?
                setState(() {
                  _onSaved = false;
                  _onEdited = true;
                }) :*/
                _onSaved ? Navigator.pop(context,widget.itemsCaseInformation) :
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
              Container())
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
              Navigator.pop(context,widget.itemsCaseInformation);
            }
          } else {
            Navigator.pop(context,widget.itemsCaseInformation);
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
    TextStyle textStylePageName = TextStyle(color: Colors.grey[400]);
    EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text("ชื่อเจ้าพนักงาน", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  "นายเอกะฒน์ สายสมุทร", style: textStyleData,),
              ),
              Container(
                padding: paddingLabel,
                child: Text("เหตุผล", style: textStyleLabel,),
              ),
              Padding(
                  padding: paddingData,
                  child: Container(
                    padding: EdgeInsets.only(top: 8.0),
                    child: TextField(
                      maxLines: 10,
                      focusNode: myFocusNodeReason,
                      controller: editReason,
                      decoration: new InputDecoration(
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
                  )
              ),
            ],
          ),
        ],
        ),
      );
    }
    Widget _buildContent_saved(BuildContext context) {
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 12.0,bottom: 12.0),
                    child: Text(
                      itemMain.LawsuitName, style: textStyleData,),
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
                child: Text("ชื่อเจ้าพนักงาน", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  itemMain.PersonName, style: textStyleData,),
              ),
              Container(
                padding: paddingLabel,
                child: Text("เหตุผล", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  itemMain.Reason, style: textStyleData,),
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
        ]
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
                    'ILG60_B_02_00_05_00', style: textStylePageName,),
                )
              ],
            ),
          ),
          Expanded(
            child: new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: SingleChildScrollView(
                child: _onSaved?_buildContent_saved(context):_buildContent(context),
              ),
            ),
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
                                  builder: (context) => LawsuitNotAcceptSuspectScreenFragment(ItemsSuspect: widget.itemsCaseInformation.Suspects[j],)));
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
                                  builder: (context) => LawsuitNotAcceptSuspectScreenFragment(ItemsSuspect: widget.itemsCaseInformation.Suspects[j])));
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
                    child: Text("ของกลางลำดับ "+(j+1).toString(), style: textStyleLabel,),
                  ),
                  new Padding(
                    padding: paddingData,
                    child: Text(
                      widget.itemsCaseInformation.Evidenses[j].ProductGroup+" / "+
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
                              child: Text(widget.itemsCaseInformation.Evidenses[j].Capacity.toString(),
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
                              child: Text(widget.itemsCaseInformation.Evidenses[j].ProductUnit,
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
                              child: Text(widget.itemsCaseInformation.Evidenses[j].Counts.toString(),
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
                              child: Text(widget.itemsCaseInformation.Evidenses[j].CountsUnit,
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
                              child: Text("ปริมาณสุทธิ", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(widget.itemsCaseInformation.Evidenses[j].Volume.toString(),
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
                              child: Text(widget.itemsCaseInformation.Evidenses[j].VolumeUnit,
                                style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  j<widget.itemsCaseInformation.Evidenses.length-1?Row(
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
                  ):Container()
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
                        'ILG60_B_02_00_07_00', style: textStylePageName,),
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