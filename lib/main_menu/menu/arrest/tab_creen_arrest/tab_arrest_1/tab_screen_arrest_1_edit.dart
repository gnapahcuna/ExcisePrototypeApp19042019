import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:location/location.dart' as Locations;
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_creen_arrest/tab_arrest_1/tab_screen_arrest_1_map.dart';

class TabScreenArrest1Edit extends StatefulWidget {
  @override
  _TabScreenArrest1EditState createState() => new _TabScreenArrest1EditState();
}
class _TabScreenArrest1EditState extends State<TabScreenArrest1Edit>  {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeArrestNumber = FocusNode();
  final FocusNode myFocusNodeArrestDate = FocusNode();
  final FocusNode myFocusNodeArrestTime = FocusNode();
  final FocusNode myFocusNodeArrestLocation = FocusNode();
  final FocusNode myFocusNodeArrestDateCreate = FocusNode();
  final FocusNode myFocusNodeArrestPlace = FocusNode();

  TextEditingController editArrestNumber = new TextEditingController();
  TextEditingController editArrestDate= new TextEditingController();
  TextEditingController editArrestTime = new TextEditingController();
  TextEditingController editArrestLocation = new TextEditingController();
  TextEditingController editArrestDateCreate = new TextEditingController();
  TextEditingController editArrestPlace = new TextEditingController();

  var dateFormatDate,dateFormatTime;
  DateTime _currentDate = DateTime(2019, 2, 3);
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = '';
  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

  Locations.LocationData _startLocation;
  Locations.LocationData _currentLocation;
  StreamSubscription<Locations.LocationData> _locationSubscription;
  Locations.Location _location = new Locations.Location();
  bool _permission = false;
  String error;
  String placeAddress="";
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0]+" "+splits[1]+" พ.ศ. "+(int.parse(splits[3])+543).toString();
    editArrestDate.text=date;
    editArrestDateCreate.text=date;
    editArrestTime.text=dateFormatTime.format(DateTime.now()).toString();

    editArrestNumber.text="TN90403056100045";
    editArrestLocation.text="1444/124 ถนน นครไชยศรี แขวง ถนนนครไชยศรี";
    editArrestPlace.text="1444/124 ถนน นครไชยศรี แขวง ถนนนครไชยศรี";
    /*String arrestNumber="";
    String arrestDate="09 ตุลาคม 2561";
    String arrestTime="เวลา 13.00 น.";
    String arrestLocation="1444/124 ถนน นครไชยศรี แขวง ถนนนครไชยศรี";
    String arrestCreateDate="09 ตุลาคม 2561";
    String arrestCreateTime="เวลา 13.00 น.";
    String arrestPlace="1444/124 ถนน นครไชยศรี แขวง ถนนนครไชยศรี";*/

  }
  CupertinoAlertDialog _createCupertinoAcceptAlertDialog(mContext){
    TextStyle TitleStyle = TextStyle(fontSize: 16.0,);
    TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold,);
    TextStyle ButtonCancelStyle = TextStyle(fontSize: 18.0,color: Colors.red, fontWeight: FontWeight.bold,);
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text("ยืนยันการบันทึกข้อมูลทั้งหมด.",
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
  void _showAcceptAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoAcceptAlertDialog(context);
      },
    );
  }

  Future<void> _neverSatisfied() async {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    _calendarCarousel = CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate = date);
        events.forEach((event) => print(event.title));
      },
      weekendTextStyle: TextStyle(
        color: Colors.black,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: true,
      // markedDatesMap: _markedDateMap,
      height: 200.0,
      selectedDateTime: _currentDate2,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 2,
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      todayBorderColor: Colors.blue,
      markedDateMoreShowTotal:
      false,
    );

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Center(
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0)
                )),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                height: (height * 55) / 100,
                width: (width * 85) / 100,
                child: Scaffold(
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 4.0, bottom: 4.0
                        ),
                        child: new Row(
                          children: <Widget>[
                            Expanded(
                                child: Text(
                                  dateFormatDate.format(_currentDate2),
                                  style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: GestureDetector(
                                child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.transparent,
                                      border: Border.all(color: Colors.black26),
                                    ),
                                    child: Icon(
                                      Icons.keyboard_arrow_down, size: 36.0,
                                      color: Colors.black54,)
                                ),
                                onTap: () {
                                  setState(() {
                                    _currentDate2 =
                                        _currentDate2.subtract(
                                            Duration(days: 30));
                                    _currentMonth =
                                        dateFormatDate.format(_currentDate2);
                                  });
                                },
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: GestureDetector(
                                child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.transparent,
                                      border: Border.all(color: Colors.black26),
                                    ),
                                    child: Icon(
                                        Icons.keyboard_arrow_up, size: 36.0,
                                        color: Colors.black54)
                                ),
                                onTap: () {
                                  setState(() {
                                    _currentDate2 =
                                        _currentDate2.add(Duration(days: 30));
                                    _currentMonth =
                                        dateFormatDate.format(_currentDate2);
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        child: CalendarCarousel<Event>(
                          todayBorderColor: Colors.black,
                          onDayPressed: (DateTime date, List<Event> events) {
                            this.setState(() => _currentDate2 = date);
                            events.forEach((event) => print(event.title));
                            Navigator.pop(context);
                          },
                          weekdayTextStyle: TextStyle(color: Colors.black),
                          weekendTextStyle: TextStyle(
                            color: Colors.black,
                          ),
                          locale: 'th',
                          thisMonthDayBorderColor: Colors.grey,
                          weekFormat: false,
                          //markedDatesMap: _markedDateMap,
                          daysHaveCircularBorder: false,
                          height: (height * 45) / 100,
                          selectedDateTime: _currentDate2,
                          customGridViewPhysics: NeverScrollableScrollPhysics(),
                          markedDateShowIcon: true,
                          markedDateIconMaxShown: 2,
                          markedDateMoreShowTotal:
                          false,
                          // null for not showing hidden events indicator
                          showHeader: false,
                          markedDateIconBuilder: (event) {
                            return event.icon;
                          },
                          selectedDayButtonColor: Colors.blue,
                          selectedDayBorderColor: Colors.blue,
                          todayTextStyle: TextStyle(
                            color: Colors.blue,
                          ),
                          todayButtonColor: Colors.white,
                          selectedDayTextStyle: TextStyle(
                            color: Colors.white,
                          ),
                          minSelectedDate: _currentDate,
                          maxSelectedDate: _currentDate.add(Duration(days: 60)),
                          onCalendarChanged: (DateTime date) {
                            setState(() {
                              _currentMonth = dateFormatDate.format(date);
                              print(_currentDate2);
                              editArrestDateCreate.text=dateFormatDate.format(_currentDate2);
                              //Navigator.pop(context)
                            });
                            //this.setState(() => _currentMonth = dateFormatDate.format(date));
                          },
                        ),
                      ), //
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNodeArrestNumber.dispose();
    myFocusNodeArrestDate.dispose();
    myFocusNodeArrestTime.dispose();
    myFocusNodeArrestLocation.dispose();
    myFocusNodeArrestDateCreate.dispose();
    myFocusNodeArrestPlace.dispose();
  }

  Widget _buildContent(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 80) / 100;
    Color labelColor = Color(0xff087de1);

    TextStyle textInputStyle = TextStyle(fontSize: 18.0, color: Colors.black);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor);
    EdgeInsets paddingInputBox =  EdgeInsets.only(top: 4.0, bottom: 0.0);
    EdgeInsets paddingLabel =  EdgeInsets.only(top: 12.0);

    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );

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
                          child: Text("เลขที่ใบจับกุม",style: textLabelStyle,),
                        ),
                        Padding(
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
                          ),
                        ),
                        _buildLine,
                        Container(
                          padding: paddingLabel,
                          child: Text("สถานที่เกิดเหตุ",style: textLabelStyle,),
                        ),
                        Padding(
                          padding: paddingInputBox,
                          child: TextField(
                            onTap: (){
                              Navigator.of(context)
                                  .push(
                                  new MaterialPageRoute(
                                      builder: (context) => TabScreenArrest1Map()));
                            },
                            focusNode: myFocusNodeArrestLocation,
                            controller: editArrestLocation,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            style: textInputStyle,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                                suffixIcon: Icon(FontAwesomeIcons.mapMarkerAlt)
                            ),
                          ),
                        ),
                        _buildLine,
                        Container(
                          padding: paddingLabel,
                          child: Text("เขียนที่",style: textLabelStyle,),
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
                        Container(
                          padding: paddingLabel,
                          child: Text("วันที่เขียน",style: textLabelStyle,),
                        ),
                        Padding(
                          padding: paddingInputBox,
                          child: TextField(
                            onTap: (){
                              _neverSatisfied();
                            },
                            focusNode: myFocusNodeArrestDateCreate,
                            controller: editArrestDateCreate,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            style: textInputStyle,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: Icon(FontAwesomeIcons.calendarAlt)
                            ),
                          ),
                        ),
                        _buildLine,
                        Container(
                          padding: paddingLabel,
                          child: Text("วันที่จับกุม",style: textLabelStyle,),
                        ),
                        Padding(
                          padding: paddingInputBox,
                          child: TextField(
                            focusNode: myFocusNodeArrestDate,
                            controller: editArrestDate,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            style: textInputStyle,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                                suffixIcon: Icon(FontAwesomeIcons.calendarAlt)
                            ),
                          ),
                        ),
                        _buildLine,
                        Container(
                          padding: paddingLabel,
                          child: Text("เวลาจับกุม",style: textLabelStyle,),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                    child: new Text('ILG60_B_01_00_03_00',style: TextStyle(color: Colors.grey[400]),),
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
      ),
    );
  }
}