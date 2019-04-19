import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/Model/choice.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/lawsuit_not_accept_case_screen_1.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_2.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_creen_arrest/tab_arrest_1/tab_screen_arrest_1_map.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_creen_arrest/tab_arrest_1/tab_screen_arrest_1_saved_constants.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_creen_arrest/tab_arrest_2/tab_screen_arrest_2_search.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_3.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_creen_arrest/tab_arrest_3/tab_screen_arrest_3_search.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_4.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_add.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_5.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_creen_arrest/tab_arrest_5/tab_screen_arrest_5_add.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_creen_arrest/tab_arrest_5/tab_screen_arrest_5_edit.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_6_section.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_6_suspect.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_search.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_section.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:location/location.dart' as Locations;
import 'package:flutter/services.dart';
import 'package:async_loader/async_loader.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_7.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_8.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:prototype_app_pang/picker/date_picker.dart';
import 'package:prototype_app_pang/picker/date_picker_arrest.dart';

const double _kPickerSheetHeight = 216.0;
class ArrestMainScreenFragment extends StatefulWidget {
  String ARREST_CODE;
  ArrestMainScreenFragment({
    Key key,
    @required this.ARREST_CODE,
  }) : super(key: key);
  @override
  _ArrestMainScreenFragmentState createState() => new _ArrestMainScreenFragmentState();
}
class _ArrestMainScreenFragmentState extends State<ArrestMainScreenFragment>  with TickerProviderStateMixin {
  TabController tabController;
  TabPageSelector _tabPageSelector;
  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = false;
  bool _onSave = false;
  bool _onFinish = false;


  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
  new GlobalKey<AsyncLoaderState>();

  List<Choice> choices = <Choice>[
    Choice(title: 'ข้อมูลการจับกุม'),
    Choice(title: 'ใบแจ้งความ'),
    Choice(title: 'ผู้จับกุม/ผู้ร่วมจับกุม'),
    Choice(title: 'ผู้ต้องหา'),
    Choice(title: 'ของกลาง'),
    Choice(title: 'ข้อกล่าวหา'),
    Choice(title: 'พฤติกรรมการจับ'),
  ];

  String _currentDateArrest, _currentDateCreate;
  DateTime _dtArrest,_dtMaxDate,_dtMinDate, _dtCreate;

  @override
  void initState() {
    super.initState();
    editArrestNumber.text = "Auto Gen";
    /*****************************controller main tab**************************/
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);


    /*****************************initData for tab1**************************/
    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " พ.ศ. " +
        (int.parse(splits[3]) + 543).toString();
    editArrestDate.text = date;
    editArrestDateCreate.text = date;
    _time = dateFormatTime.format(DateTime.now()).toString();
    editArrestTime.text = _time;
    print(dateFormatDate.format(DateTime.now()).toString());

    _currentDateArrest = date;
    _currentDateCreate = date;
    _dtArrest = DateTime.now();
    _dtMaxDate = DateTime.now();
    _dtCreate = DateTime.now();
    _dtMinDate = DateTime.now();
  }

  /*****************************view tab1**************************/
  //node focus
  final FocusNode myFocusNodeArrestNumber = FocusNode();
  final FocusNode myFocusNodeArrestDate = FocusNode();
  final FocusNode myFocusNodeArrestTime = FocusNode();
  final FocusNode myFocusNodeArrestLocation = FocusNode();
  final FocusNode myFocusNodeArrestDateCreate = FocusNode();
  final FocusNode myFocusNodeArrestPlace = FocusNode();

  //textfield
  TextEditingController editArrestNumber = new TextEditingController();
  TextEditingController editArrestDate = new TextEditingController();
  TextEditingController editArrestTime = new TextEditingController();
  TextEditingController editArrestLocation = new TextEditingController();
  TextEditingController editArrestDateCreate = new TextEditingController();
  TextEditingController editArrestPlace = new TextEditingController();

  //date
  var dateFormatDate, dateFormatTime;
  DateTime _currentDate = DateTime(2019, 2, 3);
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = '';
  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

  //location
  Locations.LocationData _startLocation;
  Locations.LocationData _currentLocation;
  StreamSubscription<Locations.LocationData> _locationSubscription;
  Locations.Location _location = new Locations.Location();
  bool _permission = false;
  String error;
  String placeAddress = "";

  //time
  DateTime time = DateTime.now();
  String _time;

  /**************************list model*******************************/
  List<ItemsList> _itemsDataTab2 = [];
  List<ItemsListArrest3> _itemsDataTab3 = [];
  List<ItemsListArrest4> _itemsDataTab4 = [];
  List<ItemsListArrest5> _itemsDataTab5 = [];
  List<ItemsListArrest7> _itemsDataTab7 = [];
  List<ItemsListArrest8> _itemsDataTab8 = [];

  /**********************Droupdown View *****************************/
  List<String> dropdownItemsTab3 = ['ผู้จับกุม', 'ผู้ร่วมจับกุม'];

  /************************view tab 6*******************************/
  bool IsSelected_tab6 = false;
  final FocusNode myFocusNodeSearchTab6 = FocusNode();
  List<ItemsListArrest6Section> _itemsInitTab6 = [];

  /*****************************view tab 7**************************/
  final FocusNode myFocusNodeArrestBehavior = FocusNode();
  final FocusNode myFocusNodeTestimony = FocusNode();
  final FocusNode myFocusNodeNotificationOfRights = FocusNode();

  TextEditingController editArrestBehavior = new TextEditingController();
  TextEditingController editTestimony = new TextEditingController();
  TextEditingController editNotificationOfRights = new TextEditingController();


  @override
  void dispose() {
    super.dispose();
    /*****************************dispose focus tab 1**************************/
    myFocusNodeArrestNumber.dispose();
    myFocusNodeArrestDate.dispose();
    myFocusNodeArrestTime.dispose();
    myFocusNodeArrestLocation.dispose();
    myFocusNodeArrestDateCreate.dispose();
    myFocusNodeArrestPlace.dispose();
    /*****************************dispose focus tab 6**************************/
    myFocusNodeSearchTab6.dispose();
    /*****************************dispose focus tab 7**************************/
    myFocusNodeArrestBehavior.dispose();
    myFocusNodeTestimony.dispose();
    myFocusNodeNotificationOfRights.dispose();
  }

  /*****************************method for main tab**************************/
  void choiceAction(Constants constants) {
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _onEdited = true;
        _onSaved = false;
        choices.removeAt(7);
      } else {
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
                  clearTextField();
                  choices.removeAt(7);
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

  /*****************************method for main tab1**************************/
  void clearTextField() {
    editArrestNumber.clear();
    editArrestDate.clear();
    editArrestTime.clear();
    editArrestLocation.clear();
    editArrestDateCreate.clear();
    editArrestPlace.clear();
  }

  void getPlaceAddress(latitude, longitude) async {
    final coordinates = new Coordinates(latitude, longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);

    var place = addresses.first;
    placeAddress = place.addressLine;
    editArrestPlace.text = placeAddress;
  }

  initPlatformState() async {
    Locations.LocationData location;
    try {
      _permission = await _location.hasPermission();
      location = await _location.getLocation();
      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
        'Permission denied - please ask the user to enable it from the app settings';
      }

      location = null;
    }
    setState(() {
      print("error :" + error);
      _startLocation = location;
      //getPlaceAddress(location.latitude,location.longitude);
    });
  }

  Future<DateTime> _selectDate(context) async {
    return await showDatePicker(
      context: context,
      firstDate: DateTime(2018),
      initialDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
  }

  _navigateMap(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenArrest1Map()),
    );
    editArrestLocation.text = result;
    //_itemsData = result;
  }

  //test async
  getMessage() async {
    return new Future.delayed(Duration(seconds: 3), () {
      print('finish');
    });
  }

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
      _onSaved = true;
      _onFinish = true;
      choices.add(Choice(title: 'แบบฟอร์ม'));
      tabController = TabController(length: choices.length, vsync: this);
      _tabPageSelector = new TabPageSelector(controller: tabController);
      //tabController.animateTo((choices.length-1));

      String Behavior = editArrestBehavior.text;
      String Testimony = editTestimony.text;
      String NotificationOfRights = editNotificationOfRights.text;
      _itemsDataTab7.add(
          ItemsListArrest7(Behavior, Testimony, NotificationOfRights));

      _itemsDataTab8.add(ItemsListArrest8("แบบฟอร์มบันทึกการจับ 2/39"));
      _itemsDataTab8.add(
          ItemsListArrest8("รายละเอียดการกระทำผิดของผู้กระทำผิด"));
      //tabController.animateTo((choices.length-1));

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
                Navigator.pop(mContext);
              },
              child: new Text(
                  'ยกเลิก', style: ButtonCancelStyle)),
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(mContext);
                Navigator.pop(mContext);
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

  Future<bool> onLoadAction() async {
    await new Future.delayed(const Duration(seconds: 3));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    /**********************async loading******************************/
    var _asyncLoader = new AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await getMessage(),
      renderLoad: () => new CircularProgressIndicator(),
      renderError: ([error]) =>
      new Text('Sorry, there was an error loading your joke'),
      renderSuccess: ({data}) => new Text(data),
    );


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
                _onEdited ?
                setState(() {
                  _onSave = false;
                  _onEdited = false;
                }) :
                _onSaved ? Navigator.pop(context) :
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
          child: Center(child: Text("งานจับกุม", style: appBarStyle),
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
              ))
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
              Navigator.pop(context);
            }
          } else {
            Navigator.pop(context);
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
                    isScrollable: true,
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
                    /* _onSaved ? (_onEdited
                        ? TabScreenArrest1Edit()
                        : TabScreenArrest1Saved()) : TabScreenArrest1(onSaved: _onSaved,onEdited: _onEdited,onDeleted: _onDeleted,),
                    TabScreenArrest2(onSaved: _onSaved,onEdited: _onEdited,onDeleted: _onDeleted,),
                    TabScreenArrest3(onSaved: _onSaved,onEdited: _onEdited,onDeleted: _onDeleted,),
                    TabScreenArrest4(onSaved: _onSaved,onEdited: _onEdited,onDeleted: _onDeleted,),
                    TabScreenArrest5(onSaved: _onSaved,onEdited: _onEdited,onDeleted: _onDeleted,),
                    TabScreenArrest6(onSaved: _onSaved,onEdited: _onEdited,onDeleted: _onDeleted,),
                    TabScreenArrest7(onSaved: _onSaved,onEdited: _onEdited,onDeleted: _onDeleted,),*/


                    _buildContent_tab_1(),
                    _buildContent_tab_2(),
                    _buildContent_tab_3(),
                    _buildContent_tab_4(),
                    _buildContent_tab_5(),
                    _buildContent_tab_6(),
                    _buildContent_tab_7(),
                    _buildContent_tab_8(),
                  ] :
                  <Widget>[
                    _buildContent_tab_1(),
                    _buildContent_tab_2(),
                    _buildContent_tab_3(),
                    _buildContent_tab_4(),
                    _buildContent_tab_5(),
                    _buildContent_tab_6(),
                    _buildContent_tab_7(),
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
  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: _kPickerSheetHeight,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  Widget _buildContent_tab_1() {
    Widget _buildContent(BuildContext context) {
      var size = MediaQuery
          .of(context)
          .size;
      final double Width = (size.width * 85) / 100;
      Color labelColor = Color(0xff087de1);

      TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black);
      TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor);
      EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 0.0);
      EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

      Widget _buildLine = Container(
        padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
        width: Width,
        height: 1.0,
        color: Colors.grey[300],
      );
      final focus = FocusNode();

      return Container(
        padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              overflow: Overflow.visible,
              children: <Widget>[
                Card(
                  elevation: 0.0,
                  color: Colors.transparent,
                  child: Container(
                    width: Width,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "เลขที่ใบจับกุม", style: textLabelStyle,),
                          ),
                          new IgnorePointer(
                            ignoring: true,
                            child: Padding(
                              padding: paddingInputBox,
                              child: TextField(
                                focusNode: myFocusNodeArrestNumber,
                                controller: editArrestNumber,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                style: textInputStyle,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                /*onFieldSubmitted: (v){
                              FocusScope.of(context).requestFocus(focus);
                            },*/
                              ),
                            ),
                          ),
                          //_buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Text("วันที่จับกุม", style: textLabelStyle,),
                          ),
                          Container(
                            padding: paddingInputBox,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new ListTile(
                                  title: Text(
                                    _currentDateArrest, style: textInputStyle,),
                                  trailing: Icon(
                                      FontAwesomeIcons.calendarAlt, size: 28.0),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ArrestDynamicDialog(
                                              Current: _dtArrest,
                                              MaxDate: _dtMaxDate,
                                              MinDate: null);
                                        }).then((s) {
                                      String date = "";
                                      List splits = dateFormatDate.format(
                                          s).toString().split(" ");
                                      date = splits[0] + " " + splits[1] +
                                          " พ.ศ. " +
                                          (int.parse(splits[3]) + 543)
                                              .toString();
                                      setState(() {
                                        _dtArrest = s;
                                        _currentDateArrest = date;
                                      });
                                    });
                                  },
                                ),
                                _buildLine,
                              ],
                            ),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text("เวลาจับกุม", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeArrestTime,
                              controller: editArrestTime,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: textInputStyle,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              onTap: () {
                                showCupertinoModalPopup<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _buildBottomPicker(
                                      CupertinoDatePicker(
                                        use24hFormat: true,
                                        mode: CupertinoDatePickerMode.time,
                                        initialDateTime: time,
                                        onDateTimeChanged: (
                                            DateTime newDateTime) {
                                          setState(() {
                                            time = newDateTime;
                                            _time = dateFormatTime.format(time)
                                                .toString();
                                            editArrestTime.text = _time;
                                          });
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "สถานที่เกิดเหตุ", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              onTap: () {
                                _navigateMap(context);
                              },
                              focusNode: focus,
                              controller: editArrestLocation,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: textInputStyle,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                      FontAwesomeIcons.mapMarkerAlt)
                              ),
                            ),
                          ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Text("วันที่เขียน", style: textLabelStyle,),
                          ),
                          Container(
                            padding: paddingInputBox,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new ListTile(
                                  title: Text(
                                    _currentDateCreate, style: textInputStyle,),
                                  trailing: Icon(
                                      FontAwesomeIcons.calendarAlt, size: 28.0),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ArrestDynamicDialog(
                                              Current: _dtCreate,
                                            MaxDate: _dtMaxDate,
                                            MinDate: _dtArrest,
                                          );
                                        }).then((s) {
                                      String date = "";
                                      List splits = dateFormatDate.format(
                                          s).toString().split(" ");
                                      date = splits[0] + " " + splits[1] +
                                          " พ.ศ. " +
                                          (int.parse(splits[3]) + 543)
                                              .toString();
                                      setState(() {
                                        _dtCreate = s;
                                        _currentDateCreate = date;
                                      });
                                    });
                                  },
                                ),
                                _buildLine,
                              ],
                            ),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text("เขียนที่", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeArrestPlace,
                              controller: editArrestPlace,
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
                  ),
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
      final double Width = (size.width * 80) / 100;
      Color labelColor = Color(0xff087de1);

      TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black);
      TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor);
      EdgeInsets paddingInputBox = EdgeInsets.only(top: 8.0, bottom: 8.0);
      EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

      //Data
      /*String arrestNumber="TN90403056100045";
      String arrestDate="09 ตุลาคม 2561";
      String arrestTime="เวลา 13.00 น.";
      String arrestLocation="1444/124 ถนน นครไชยศรี แขวง ถนนนครไชยศรี";
      String arrestCreateDate="09 ตุลาคม 2561";
      String arrestCreateTime="เวลา 13.00 น.";
      String arrestPlace="1444/124 ถนน นครไชยศรี แขวง ถนนนครไชยศรี";*/

      String arrestNumber = editArrestNumber.text;
      String arrestDate = editArrestDate.text;
      String arrestTime = editArrestTime.text;
      String arrestLocation = editArrestLocation.text;
      String arrestCreateDate = editArrestDateCreate.text;
      String arrestCreateTime = editArrestTime.text;
      String arrestPlace = editArrestPlace.text;

      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )
        ),
        width: size.width,
        padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 0.0,
              color: Colors.transparent,
              child: Container(
                width: Width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text("เลขที่ใบจับกุม", style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(arrestNumber, style: textInputStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text("วันที่จับกุม", style: textLabelStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(arrestDate + " " + arrestTime,
                          style: textInputStyle,),
                      ),

                      Container(
                        padding: paddingLabel,
                        child: Text("สถานที่เกิดเหตุ", style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(arrestLocation, style: textInputStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("วันที่เขียน", style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(arrestCreateDate + " " + arrestCreateTime,
                          style: textInputStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("เขียนที่", style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(arrestPlace, style: textInputStyle,),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Center(
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
                  child: new Text('ILG60_B_01_00_03_00',
                    style: TextStyle(color: Colors.grey[400]),),
                )
              ],
            ),
          ),
          Expanded(
            child: new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: SingleChildScrollView(
                child: _onSaved ? _buildContent_saved(context) : _buildContent(
                    context),
              ),
            ),
          ),
        ],
      ),
    );
  }

//************************end_tab_1*******************************

//************************start_tab_2*****************************
  _navigateSearchTab2(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenArrest2Search()),
    );
    List<ItemsList> items = result;
    _itemsDataTab2 = result;
  }

  Widget _buildContent_tab_2() {
    //data result when search data
    Widget _buildDataResults() {
      Color labelColor = Color(0xff087de1);
      TextStyle textDataStyle = TextStyle(fontSize: 16.0, color: Colors.black);
      TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor);
      TextStyle textLabelDeleteStyle = TextStyle(
          fontSize: 16.0, color: Colors.red[200]);
      TextStyle textDataStyleSub = TextStyle(
          fontSize: 14.0, color: Colors.black);
      EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
      EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0, bottom: 8.0);
      var size = MediaQuery
          .of(context)
          .size;
      return Container(
        padding: EdgeInsets.only(bottom: 12.0),
        child: ListView.builder(
          itemCount: _itemsDataTab2.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 0.0, bottom: 8.0),
                child: Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text("เลขที่ใบจับกุม", style: textLabelStyle,),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: paddingInputBox,
                              child: Text(
                                _itemsDataTab2[index].NOTICE_CODE,
                                style: textDataStyle,),
                            ),
                          ),
                          Center(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _itemsDataTab2.removeAt(index);
                                  });
                                },
                                child: Container(
                                    child: Text(
                                      "ลบ", style: textLabelDeleteStyle,)
                                ),
                              )
                          ),
                        ],
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "ผู้รับแจ้งความ " +
                              _itemsDataTab2[index].STAFF_TITLE_SHORT_NAME_TH+
                              _itemsDataTab2[index].STAFF_FIRST_NAME+" "+
                              _itemsDataTab2[index].STAFF_LAST_NAME,
                          style: textDataStyleSub,),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                        child: new Text('ILG60_B_01_00_04_00',
                          style: TextStyle(color: Colors.grey[400]),),
                      ),
                    ],
                  ),
                  Container(
                    //width: itemWidth,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: new Card(
                        elevation: 0.0,
                        color: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: new GestureDetector(
                          onTap: () {
                            _navigateSearchTab2(context);
                          },
                          child: new ListTile(
                            leading: new Icon(Icons.search),
                            title: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text('ค้นหาใบแจ้งความ', style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey[500]),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ],
                )
            ),
            Expanded(
              child: new ConstrainedBox(
                constraints: const BoxConstraints.expand(),
                child: _buildDataResults(),
              ),
            ),
          ],
        ),
      ),
    );
  }

//************************end_tab_2*******************************

//************************start_tab_3*****************************
  _navigateSearchTab3(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenArrest3Search()),
    );
    List<ItemsListArrest3> items = result;
    _itemsDataTab3 = result;
    items.forEach((item) {
      print(item.Name);
    });
  }

  Widget _buildContent_tab_3() {
    Widget _buildDataResults() {
      Color labelColor = Color(0xff087de1);
      TextStyle textDataStyle = TextStyle(fontSize: 16.0, color: Colors.black);
      TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor);
      TextStyle textLabelDeleteStyle = TextStyle(
          fontSize: 18.0, color: Colors.red[100]);
      TextStyle textDataStyleSub = TextStyle(
          fontSize: 14.0, color: Colors.black54);
      EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
      EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
      var size = MediaQuery
          .of(context)
          .size;
      return Container(
        padding: EdgeInsets.only(bottom: 12.0),
        child: ListView.builder(
          itemCount: _itemsDataTab3.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 0.0, bottom: 8.0),
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
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: paddingInputBox,
                                    child: Text(
                                      _itemsDataTab3[index].Name,
                                      style: textDataStyle,),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                "ตำแหน่ง : " + _itemsDataTab3[index].Position,
                                style: textDataStyleSub,),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: paddingInputBox,
                                    child: Text(
                                      "สังกัด : " + _itemsDataTab3[index].Under,
                                      style: textDataStyleSub,),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Center(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _itemsDataTab3.removeAt(index);
                                        });
                                      },
                                      child: Container(
                                          child: Text(
                                            "ลบ", style: textLabelDeleteStyle,)
                                      ),
                                    )
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _itemsDataTab3.removeAt(index);
                                      });
                                    },
                                    child: Container(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: _itemsDataTab3[index]
                                              .ArrestType,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              _itemsDataTab3[index].ArrestType =
                                                  newValue;
                                            });
                                          },
                                          items: dropdownItemsTab3
                                              .map<DropdownMenuItem<String>>((
                                              String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value, style: textDataStyle,),
                                            );
                                          })
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                ),
              ),
            );
          },
        ),
      );
    }
    return Scaffold(
        backgroundColor: Colors.grey[200],
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
                          child: new Text('ILG60_B_01_00_05_00',
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
                  child: _buildDataResults(),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: new Padding(padding: EdgeInsets.all(18.0),
          child: FloatingActionButton(
            backgroundColor: Color(0xff087de1),
            onPressed: () {
              _navigateSearchTab3(context);
            },
            mini: false,
            child: new Icon(Icons.add),
          ),)
    );
  }

//************************end_tab_3*******************************

//************************start_tab_4*******************************
  _navigateScreenAddTab4(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenArrest4Add()),
    );
    _itemsDataTab4 = result;
  }

  Widget _buildContent_tab_4() {
    Widget _buildDataResults() {
      Color labelColor = Colors.grey[500];
      TextStyle textLabelDeleteStyle = TextStyle(
          fontSize: 16.0, color: Colors.red[200]);
      EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
      EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
      TextStyle textInputStyleTitle = TextStyle(
          fontSize: 16.0, color: Colors.black);
      TextStyle textInputStyleSub = TextStyle(
          fontSize: 14.0, color: labelColor);
      return Container(
        padding: EdgeInsets.only(bottom: 12.0),
        child: ListView.builder(
          itemCount: _itemsDataTab4.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 0.0, bottom: 8.0),
                child: Container(
                  padding: EdgeInsets.all(22.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: paddingLabel,
                              child: Text(
                                _itemsDataTab4[index].NameTitle + ' ' +
                                    _itemsDataTab4[index].NameSus,
                                style: textInputStyleTitle,),
                            ),
                          ),
                          Center(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _itemsDataTab4.removeAt(index);
                                  });
                                },
                                child: Container(
                                    child: Text(
                                      "ลบ", style: textLabelDeleteStyle,)
                                ),
                              )
                          ),
                        ],
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(
                          "จำนวนครั้งการกระทำผิด " +
                              _itemsDataTab4[index].OffenseCount.toString() +
                              " ครั้ง",
                          style: textInputStyleSub,),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                child: _buildDataResults(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: new Padding(padding: EdgeInsets.all(18.0),
        child: FloatingActionButton(
          backgroundColor: Color(0xff087de1),
          onPressed: () {
            _navigateScreenAddTab4(context);
          },
          mini: false,
          child: new Icon(Icons.add),
        ),
      ),
    );
  }

  //************************end_tab_4*****************************

  //************************start_tab_5*****************************
  _navigateScreenAddTab5(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenArrest5Add()),
    );
    _itemsDataTab5 = result;
  }

  _navigateScreenEditTab5(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          TabScreenArrest5Edit(ItemsData: _itemsDataTab5,)),
    );
    setState(() {
      _itemsDataTab5 = result;
    });
  }

  Widget _buildContent_tab_5() {
    Widget _buildDataResults() {
      TextStyle textInputStyleTitle = TextStyle(
          fontSize: 16.0, color: Colors.black);
      EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
      var size = MediaQuery
          .of(context)
          .size;
      Color labelColor = Color(0xff087de1);
      TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black);
      TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor);
      EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
      TextStyle textLabelEditNonCheckStyle = TextStyle(
          fontSize: 16.0, color: Colors.red[100]);

      return ListView.builder(
        itemCount: _itemsDataTab5.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Container(
                padding: EdgeInsets.all(22.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
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
                          child: Text("ชื่อของกลาง", style: textLabelStyle,),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: paddingInputBox,
                                child: Text(
                                  (index + 1).toString() + ". " +
                                      _itemsDataTab5[index].ProductGroup + '/' +
                                      _itemsDataTab5[index].ProductCategory +
                                      '/' +
                                      _itemsDataTab5[index].ProductType + '/' +
                                      _itemsDataTab5[index].MainBrand,
                                  style: textInputStyleTitle,),
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
                                      "จำนวน", style: textLabelStyle,),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      _itemsDataTab5[index].Counts.toString(),
                                      style: textInputStyle,),
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
                                    child: Text(
                                      "หน่วย", style: textLabelStyle,),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      _itemsDataTab5[index].CountsUnit,
                                      style: textInputStyle,),
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
                                      "ปริมาณสุทธิ", style: textLabelStyle,),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      _itemsDataTab5[index].Volume.toString(),
                                      style: textInputStyle,),
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
                                    child: Text(
                                      "หน่วย", style: textLabelStyle,),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      _itemsDataTab5[index].VolumeUnit,
                                      style: textInputStyle,),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(
                                    bottom: 12.0, top: 12.0),
                                child: InkWell(
                                  onTap: () {
                                    _navigateScreenEditTab5(context);
                                  },
                                  child: Container(
                                      child: Text("แก้ไข",
                                        style: textLabelEditNonCheckStyle,)
                                  ),
                                )
                            ),
                            Container(
                                padding: EdgeInsets.only(
                                    bottom: 12.0, top: 12.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _itemsDataTab5.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                      child: Text("ลบ",
                                        style: textLabelEditNonCheckStyle,)
                                  ),
                                )
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                )
            ),
          );
        },
      );
    }
    return Scaffold(
        backgroundColor: Colors.grey[200],
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
                          child: new Text('ILG60_B_01_00_07_00',
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
                  child: _buildDataResults(),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: new Padding(padding: EdgeInsets.all(18.0),
          child: FloatingActionButton(
            backgroundColor: Color(0xff087de1),
            onPressed: () {
              _navigateScreenAddTab5(context);
            },
            mini: false,
            child: new Icon(Icons.add),
          ),)
    );
  }

  //************************start_tab_6*****************************
  _navigateSearchSelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenArrest6Search()),
    );
    if (result.toString() != "back") {
      setState(() {
        IsSelected_tab6 = true;
        print(IsSelected_tab6);
        _itemsInitTab6 = result;
      });
    }
  }

  Widget _buildContent_tab_6() {
    Widget _buildContent() {
      TextStyle textLabelEditNonCheckStyle = TextStyle(
          fontSize: 16.0, color: Colors.red[100]);
      Color labelColor = Colors.grey[500];
      Color labelPreview = Color(0xff2e76bc);
      TextStyle textInputStyleTitle = TextStyle(
          fontSize: 16.0, color: Colors.black);
      TextStyle textInputStyleSub = TextStyle(
          fontSize: 14.0, color: labelColor);
      EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
      EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
      return new Container(
        padding: EdgeInsets.only(bottom: 12.0),
        child: ListView.builder(
          itemCount: _itemsInitTab6.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                //
              },
              child: Padding(
                padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                child: Container(
                  padding: EdgeInsets.all(22.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: paddingLabel,
                                  child: Text('ฐานความผิด'+_itemsInitTab6[index].SECTION_NAME,
                                    style: textInputStyleTitle,),
                                ),
                              ),
                              IsSelected_tab6 ? Column(
                                children: <Widget>[
                                  Center(
                                      child: InkWell(
                                        onTap: () {
                                          /*_navigateEditSelection(context,
                                              _itemsInitTab6[index].SectionName,
                                              _itemsInitTab6[index]
                                                  .SectionDetail,
                                              _itemsInitTab6[index]
                                                  .ItemSuspect);*/
                                        },
                                        child: Container(
                                            child: Text("แก้ไข",
                                              style: textLabelEditNonCheckStyle,)
                                        ),
                                      )
                                  ),
                                ],
                              ) : Container()
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              !IsSelected_tab6
                                  ? Icon(Icons.arrow_forward_ios,
                                color: Colors.grey[300], size: 18,)
                                  : Container(),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: paddingInputBox,
                                  child: Text(
                                    _itemsInitTab6[index].GUILTBASE_NAME,
                                    style: textInputStyleSub,),
                                ),
                              ),
                              IsSelected_tab6 ? Center(
                                  child: InkWell(
                                    onTap: () {
                                      /*setState(() {
                                        _itemsInitTab6.removeAt(index);
                                      });
                                      setState(() {
                                        IsSelected_tab6 = false;
                                        _itemsInitTab6 = _itemsInitTab6Init;
                                      });*/
                                      //_navigateEdit(context);
                                    },
                                    child: Container(
                                        child: Text("ลบ",
                                          style: textLabelEditNonCheckStyle,)
                                    ),
                                  )
                              ) : Container(),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
    TextStyle textStyleTitle = TextStyle(
        fontSize: 16.0, color: Colors.black);
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                        child: new Text('ILG60_B_01_00_08_00',
                          style: TextStyle(color: Colors.grey[400]),),
                      ),
                    ],
                  ),
                  Container(
                    //width: itemWidth,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: new Card(
                        elevation: 0.0,
                        color: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: new GestureDetector(
                          onTap: () {
                            _navigateSearchSelection(context);
                          },
                          child: new ListTile(
                            leading: new Icon(Icons.search),
                            title: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text('ค้นหาใบแจ้งความ', style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey[500]),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ],
                )
            ),
            Container(
              padding: EdgeInsets.only(left: 22.0, right: 22.0, bottom: 12.0),
              child: Text(
                'ข้อกล่าวหาที่ใช้งานมากที่สุด', style: textStyleTitle,),
            ),
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints.expand(),
                child: _buildContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //************************end_tab_6*****************************

  //************************start_tab_7*****************************
  Widget _buildContent_tab_7() {
    Widget _buildContent() {
      TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black);
      EdgeInsets paddindTextTitle = EdgeInsets.only(bottom: 18.0);
      return Container(
        padding: EdgeInsets.only(bottom: 22.0),
        margin: EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(bottom: 24.0),
              child: new Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
                elevation: 1.0,
                child: Container(
                    margin: EdgeInsets.all(24.0),
                    // hack textfield height
                    //padding: EdgeInsets.only(bottom: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: paddindTextTitle,
                          child: Text(
                            "พฤติกรรมการจับกุม", style: textInputStyle,),
                        ),
                        TextField(
                          maxLines: 10,
                          focusNode: myFocusNodeArrestBehavior,
                          controller: editArrestBehavior,
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
                      ],
                    )
                ),
              ),
            ),
            new Container(
              padding: EdgeInsets.only(bottom: 24.0),
              child: new Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
                elevation: 1.0,
                child: Container(
                    margin: EdgeInsets.all(24.0),
                    // hack textfield height
                    //padding: EdgeInsets.only(bottom: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: paddindTextTitle,
                          child: Text(
                            "คำให้การของผู้ต้องหา", style: textInputStyle,),
                        ),
                        TextField(
                          focusNode: myFocusNodeTestimony,
                          controller: editTestimony,
                          maxLines: 10,
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
                      ],
                    )
                ),
              ),
            ),
            new Container(
              padding: EdgeInsets.only(bottom: 24.0),
              child: new Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
                elevation: 1.0,
                child: Container(
                    margin: EdgeInsets.all(24.0),
                    // hack textfield height
                    //padding: EdgeInsets.only(bottom: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: paddindTextTitle,
                          child: Text("การแจ้งสิทธิ", style: textInputStyle,),
                        ),
                        TextField(
                          focusNode: myFocusNodeNotificationOfRights,
                          controller: editNotificationOfRights,
                          maxLines: 10,
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
                      ],
                    )
                ),
              ),
            ),
          ],
        ),
      );
    }

    /*********************************when save data************************************/
    Widget _buildContentResult() {
      TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black);
      EdgeInsets paddindTextTitle = EdgeInsets.only(bottom: 0.0);
      var size = MediaQuery
          .of(context)
          .size;
      return Container(
        padding: EdgeInsets.only(bottom: 22.0),
        margin: EdgeInsets.all(4.0),
        child: ListView.builder(
            itemCount: _itemsDataTab7.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.only(bottom: 24.0),
                    child: new Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      ),
                      elevation: 1.0,
                      child: Container(
                          margin: EdgeInsets.all(22.0),
                          width: (size.width * 80) / 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: paddindTextTitle,
                                child: Text(
                                  "พฤติกรรมการจับกุม", style: textInputStyle,),
                              ),
                              Container(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  _itemsDataTab7[index].Behavior,
                                  style: textInputStyle,),
                              ),
                              Padding(
                                padding: paddindTextTitle,
                                child: Text(
                                  "คำให้การของผู้ต้องหา",
                                  style: textInputStyle,),
                              ),
                              Container(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  _itemsDataTab7[index].Testimony,
                                  style: textInputStyle,),
                              ),
                              Padding(
                                padding: paddindTextTitle,
                                child: Text(
                                  "การแจ้งสิทธิ", style: textInputStyle,),
                              ),
                              Container(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  _itemsDataTab7[index].NotificationOfRights,
                                  style: textInputStyle,),
                              )
                            ],
                          )
                      ),
                    ),
                  ),
                ],
              );
            }
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                        child: new Text('ILG60_B_01_00_09_00',
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
                  child: _onSaved ? _buildContentResult() : _buildContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //************************end_tab_7*****************************


//************************start_tab_8*****************************

  Widget _buildContent_tab_8() {
    Widget _buildContent() {
      TextStyle textInputStyleTitle = TextStyle(
          fontSize: 16.0, color: Colors.black);
      return Container(
        padding: EdgeInsets.only(bottom: 22.0),
        margin: EdgeInsets.all(4.0),
        child: ListView.builder(
            itemCount: _itemsDataTab8.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(top: 2, bottom: 2),
                child: Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: ListTile(
                      title: Text((index + 1).toString() + '. ' +
                          _itemsDataTab8[index].FormsName,
                        style: textInputStyleTitle,),
                      trailing: Icon(
                        Icons.arrow_forward_ios, color: Colors.grey[300],),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              TabScreenArrest8Dowload(
                                Title: _itemsDataTab8[index].FormsName,)),
                        );
                      }
                  ),
                ),
              );
            }
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                        child: new Text('ILG60_B_01_00_09_00',
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
                  child: _buildContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//************************end_tab_8*****************************
}