import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

class TabScreenArrest1Map extends StatefulWidget {
  @override
  _TabScreenArrest1MapState createState() => new _TabScreenArrest1MapState();
}
class _TabScreenArrest1MapState extends State<TabScreenArrest1Map> {
  TabController tabController;
  bool _value1 = false;
  bool _value2 = false;

  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController mapController;
  bool isLoading = false;
  String errorMessage;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LocationData _startLocation;
  LocationData _currentLocation;
  StreamSubscription<LocationData> _locationSubscription;
  Location _locationService  = new Location();
  bool _permission = false;
  String error;
  bool currentWidget = true;
  String placeName="";
  String placeAddress="";


  //textfield
  final FocusNode myFocusNodeArrestProvince = FocusNode();
  final FocusNode myFocusNodeArrestDistinct = FocusNode();
  final FocusNode myFocusNodeArrestSubDistinct = FocusNode();
  final FocusNode myFocusNodeArrestRoad = FocusNode();
  final FocusNode myFocusNodeArrestAlley = FocusNode();
  final FocusNode myFocusNodeArrestHouseNumber = FocusNode();

  TextEditingController editArrestProvince = new TextEditingController();
  TextEditingController editArrestDistinct = new TextEditingController();
  TextEditingController editArrestSubDistinct = new TextEditingController();
  TextEditingController editArrestRoad = new TextEditingController();
  TextEditingController editArrestAlley = new TextEditingController();
  TextEditingController editArrestHouseNumber = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _value1 = true;
    initPlatformState();
    /*_locationSubscription =
        _location.onLocationChanged().listen((Locations.LocationData result) {
          setState(() {
            _currentLocation = result;
            getPlaceAddress(result.latitude, result.longitude);
          });
        });
    print('_currentLocation : ' + _startLocation.toString());*/
  }


  @override
  void dispose() {
    super.dispose();
    myFocusNodeArrestProvince.dispose();
    myFocusNodeArrestDistinct.dispose();
    myFocusNodeArrestSubDistinct.dispose();
    myFocusNodeArrestRoad.dispose();
    myFocusNodeArrestAlley.dispose();
    myFocusNodeArrestHouseNumber.dispose();
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  void _setMarker(placeName) {
    final String markerIdVal = placeName;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      //icon: BitmapDescriptor.fromAsset('assets/icons/marker.png',),
      position: LatLng(
          _startLocation.latitude, _startLocation.longitude
      ),
      infoWindow: InfoWindow(title: markerIdVal, /*snippet: '*'*/),
    );

    setState(() {
      markers = <MarkerId, Marker>{};
      markers[markerId] = marker;
    });
  }

  void getPlaceAddress(latitude, longitude) async {
    final coordinates = new Coordinates(latitude, longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);

    var place = addresses.first;
    placeName = place.featureName;
    placeAddress = place.addressLine;
    _setMarker(place.addressLine);
  }

  /*initPlatformState() async {
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
  }*/
  initPlatformState() async {
    await _locationService.changeSettings(accuracy: LocationAccuracy.HIGH, interval: 1000);

    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();
          print("Location: ${location.latitude}");
          _locationSubscription = _locationService.onLocationChanged().listen((LocationData result) {
            if(mounted){
              setState(() {
                _currentLocation = result;
                getPlaceAddress(result.latitude, result.longitude);
              });
            }
          });
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if(serviceStatusResult){
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }

    setState(() {
      _startLocation = location;
    });

  }


  Widget _buildContentGoogleMap(width, height) {
    //Place Style
    TextStyle textStylePlaceName = TextStyle(
        fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold);
    TextStyle textStylePlaceAddress = TextStyle(
        fontSize: 16.0, color: Colors.black);

    if(_startLocation!=null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: width,
            height: height / 1.7,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition:
              CameraPosition(
                target: LatLng(
                    _startLocation.latitude, _startLocation.longitude),
                bearing: 0.0,
                tilt: 30.0,
                zoom: 17.0,
              ),
              markers: Set<Marker>.of(markers.values),
            ),
          ),
          Container(
            width: width,
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: Text(placeName, style: textStylePlaceName,),
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: Text(placeAddress, style: textStylePlaceAddress,),
          )
        ],
      );
    }else{
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    //App Bar Style
    TextStyle textStyleAppbar = TextStyle(fontSize: 18.0, color: Colors.white);
    //Block Choice Style
    Color backColorChoiceOne = Colors.white;
    Color backColorChoiceTwo = Colors.grey[200];
    TextStyle textStyleSelect = TextStyle(fontSize: 16.0, color: Colors.black);
    TextStyle textStyleUnselect = TextStyle(
        fontSize: 16.0, color: Colors.black54);
    //Size Screen
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    //TextField Style
    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 18.0, color: Colors.black);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor);
    EdgeInsets paddingInputBox =  EdgeInsets.only(top: 4.0, bottom: 0.0);
    EdgeInsets paddingLabel =  EdgeInsets.only(top: 12.0);


    /*List<Widget> widgets;
    if (_currentLocation == null) {
      widgets = new List();
    } else {
    }*/

    final _buildChoice = new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  if (!_value1) {
                    _value1 = !_value1;
                    _value2 = !_value2;
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _value1 ? Colors.blue : Colors.white,
                  border: Border.all(color: Colors.black12),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: _value1
                        ? Icon(
                      Icons.check,
                      size: 30.0,
                      color: Colors.white,
                    )
                        : Container(
                      height: 30.0,
                      width: 30.0,
                      color: Colors.transparent,
                    )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text('Google Map',
                style: _value1 ? textStyleSelect : textStyleUnselect,),
            )
          ],
        ),
        Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  if (!_value2) {
                    _value2 = !_value2;
                    _value1 = !_value1;
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _value2 ? Colors.blue : Colors.white,
                  border: Border.all(color: Colors.black12),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: _value2
                        ? Icon(
                      Icons.check,
                      size: 30.0,
                      color: Colors.white,
                    )
                        : Container(
                      height: 30.0,
                      width: 30.0,
                      color: Colors.transparent,
                    )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text('ระบุเอง',
                style: _value2 ? textStyleSelect : textStyleUnselect,),
            )
          ],
        )
      ],
    );
    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: width,
      height: 1.0,
      color: Colors.grey[300],
    );

    final _buildContentCustom = new Center(
      child: Container(
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
                    width: (width*80/100),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "จังหวัด", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeArrestProvince,
                              controller: editArrestProvince,
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
                            child: Text(
                              "อำเภอ/เขต", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeArrestDistinct,
                              controller: editArrestDistinct,
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
                            child: Text("ตำบล/แขวง", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeArrestSubDistinct,
                              controller: editArrestSubDistinct,
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
                            child: Text("ถนน", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeArrestRoad,
                              controller: editArrestRoad,
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
                            child: Text("ซอย", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeArrestAlley,
                              controller: editArrestAlley,
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
                            child: Text("บ้านเลขที่", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeArrestHouseNumber,
                              controller: editArrestHouseNumber,
                              keyboardType: TextInputType.number,
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
      ),
    );
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: Text('สถานที่เกิดเหตุ', style: textStyleAppbar,),
        centerTitle: true,
        actions: <Widget>[
          new FlatButton(
              onPressed: () {
                String houseNumber = editArrestHouseNumber.text;
                String province=editArrestProvince.text;
                String distict=editArrestDistinct.text;
                String subDistinct=editArrestSubDistinct.text;
                String road=editArrestRoad.text;
                String alley=editArrestAlley.text;
                String getAdrress;
                if(_value1){
                  getAdrress=placeAddress;
                }else{
                  getAdrress=houseNumber+" "+alley+" "+road+" "+subDistinct+" "+distict+" "+province;
                }
                Navigator.pop(context,getAdrress);
              },
              child: Text('บันทึก', style: textStyleAppbar)),
        ],
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12.0),
            color: _value1?backColorChoiceOne:backColorChoiceTwo,
            child: _buildChoice,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: _value1
                  ? _buildContentGoogleMap(width, height)
                  : _buildContentCustom,

            ),
          )
        ],
      ),
    );
  }
}