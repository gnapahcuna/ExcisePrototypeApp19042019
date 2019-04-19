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

class TabScreenArrest1Saved extends StatefulWidget {
  /*String ArrestNumber,ArrestDate,ArrestLocation,ArrestCreateDate,ArrestPlace;
  TabScreenArrest1Saved({
    Key key,
    @required this.ArrestNumber,
    @required this.ArrestDate,
    @required this.ArrestLocation,
    @required this.ArrestCreateDate,
    @required this.ArrestPlace,
  }) : super(key: key);*/

  @override
  _TabScreenArrest1SavedState createState() => new _TabScreenArrest1SavedState();
}
class _TabScreenArrest1SavedState extends State<TabScreenArrest1Saved>  {

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
    print(dateFormatDate.format(DateTime.now()).toString());

  }
  void getPlaceAddress(latitude, longitude) async {
    final coordinates = new Coordinates(latitude, longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);

    var place = addresses.first;
    placeAddress = place.addressLine;
    editArrestPlace.text=placeAddress;
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

    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor);
    EdgeInsets paddingInputBox =  EdgeInsets.only(top: 8.0, bottom: 8.0);
    EdgeInsets paddingLabel =  EdgeInsets.only(top: 12.0);

    //Data
    String arrestNumber="TN90403056100045";
    String arrestDate="09 ตุลาคม 2561";
    String arrestTime="เวลา 13.00 น.";
    String arrestLocation="1444/124 ถนน นครไชยศรี แขวง ถนนนครไชยศรี";
    String arrestCreateDate="09 ตุลาคม 2561";
    String arrestCreateTime="เวลา 13.00 น.";
    String arrestPlace="1444/124 ถนน นครไชยศรี แขวง ถนนนครไชยศรี";

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
                      child: Text("เลขที่ใบจับกุม",style: textLabelStyle,),
                    ),
                    Padding(
                      padding: paddingInputBox,
                      child: Text(arrestNumber,style: textInputStyle,),
                    ),
                    Padding(
                      padding: paddingInputBox,
                      child: Text("วันที่จับกุม",style: textLabelStyle,),
                    ),
                    /*Row(
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Text(arrestDate+" "+arrestTime,style: textInputStyle,),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(arrestTime,style: textInputStyle,),
                        ),
                      ],
                    ),*/
                    Container(
                      padding: paddingLabel,
                      child: Text(arrestDate+" "+arrestTime,style: textInputStyle,),
                    ),

                    Container(
                      padding: paddingLabel,
                      child: Text("สถานที่เกิดเหตุ",style: textLabelStyle,),
                    ),
                    Padding(
                      padding: paddingInputBox,
                      child: Text(arrestLocation,style: textInputStyle,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text("วันที่เขียน",style: textLabelStyle,),
                    ),
                    Padding(
                      padding: paddingInputBox,
                      child: Text(arrestCreateDate+" "+arrestCreateTime,style: textInputStyle,),
                    ),
                    /*Row(
                      children: <Widget>[
                        Padding(
                          padding: paddingInputBox,
                          child: Text(arrestCreateDate+" "+arrestCreateTime,style: textInputStyle,),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(arrestCreateTime,style: textInputStyle,),
                        ),
                      ],
                    ),*/
                    Container(
                      padding: paddingLabel,
                      child: Text("เขียนที่",style: textLabelStyle,),
                    ),
                    Padding(
                      padding: paddingInputBox,
                      child: Text(arrestPlace,style: textInputStyle,),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SingleChildScrollView(
              child: _buildContent(context),
            ),
          ],
        ),
      ),
    );
  }
}
