import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class ArrestDynamicDialog extends StatefulWidget {
  ArrestDynamicDialog({this.Current,this.MaxDate,this.MinDate});
  final DateTime Current;
  final DateTime MaxDate;
  final DateTime MinDate;
  @override
  _DynamicDialogState createState() => _DynamicDialogState();
}
class _DynamicDialogState extends State<ArrestDynamicDialog> {
  DateTime Current,MaxDate,MinDate;
  //DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = 'asdasdasd';
  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;
  var dateFormatDate, dateFormatTime;


  @override
  void initState() {
    Current = widget.Current;
    MaxDate=widget.MaxDate;
    MinDate=widget.MinDate;

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');

    _currentDate2 =Current;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.black,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));

        setState(() {
          Navigator.pop(context,date);
        });

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
      height: (height*40)/100,
      width: width,
      selectedDateTime: _currentDate2,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      //markedDateIconMaxShown: 2,
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
      minSelectedDate: MinDate,
      maxSelectedDate: MaxDate,
//      inactiveDateColor: Colors.black12,
      onCalendarChanged: (DateTime date) {
        setState(() {
          _currentMonth = dateFormatDate.format(date);
        });
        //this.setState(() => _currentMonth = dateFormatDate.format(date));
      },
    );
    return AlertDialog(
      //title: Text(_title),
      content: Container(
        decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0)
            )),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            //padding: EdgeInsets.all(8.0),
            height: (height*50)/100,
            width: (width*100)/100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      left:8.0,right: 8.0,top: 4.0,bottom: 4.0
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
                                Icons.keyboard_arrow_down, size: 30.0,
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
                                  Icons.keyboard_arrow_up, size: 30.0,
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
                  child: _calendarCarouselNoHeader,
                ), //
              ],
            ),
          ),
        ),
      ),
    );
  }
}