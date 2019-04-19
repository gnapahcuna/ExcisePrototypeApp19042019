import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/arrest_screen_1.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/arrest_tab.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/compare_tab.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/lawsuit_tab.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/prove_tab.dart';

class MainMenuFragment extends StatefulWidget {
  @override
  _MainMenuFragmentFragmentState createState() => new _MainMenuFragmentFragmentState();
}
class _MainMenuFragmentFragmentState extends State<MainMenuFragment> {
  int _selectedMenuIndex = 0;
  Color icon_color = Color(0xff549ee8);

  _getMenuItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildContent1(),
              _buildContent2(),
              _buildContent3(),
            ],
          ),
        );
      case 1:
        return new ArrestFragment();
      case 2:
        return new LawsuitFragment();
      case 3:
        return new ProveFragment();
      case 4:
        return new CompareFragment();
      default:
        return new Text("Error");
    }
  }

  _onClickMenu(index) {
    setState(() => _selectedMenuIndex = index);
  }

  Widget _buildContent1() {
    var size = MediaQuery
        .of(context)
        .size;
    print((size.width / 3).toString());
    return Container(
      //padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.all(12.0),
            child: new Text('งานปราบปราม',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
          ),
          new Container(
            //padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          width: size.width / 3,
                          child: Column(
                            children: <Widget>[
                              Card(
                                shape: new RoundedRectangleBorder(
                                    side: new BorderSide(
                                        color: Color(0xff549ee8), width: 1.5),
                                    borderRadius: BorderRadius.circular(4.0)
                                ),
                                elevation: 0.0,
                                child: Padding(padding: EdgeInsets.all(12.0),
                                  child: Image(image: AssetImage(
                                      "assets/icons/icon_drawer_tab1.png"),
                                    height: 55.0,
                                    width: 55.0,
                                    fit: BoxFit.fitWidth,
                                    color: icon_color,
                                  ),
                                ),
                              ),
                              Text(
                                'จับกุม',
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          _onClickMenu(1);
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          width: size.width / 3,
                          child: Column(
                            children: <Widget>[
                              Card(
                                shape: new RoundedRectangleBorder(
                                    side: new BorderSide(
                                        color: Color(0xff549ee8), width: 1.5),
                                    borderRadius: BorderRadius.circular(4.0)
                                ),
                                elevation: 0.0,
                                child: Padding(padding: EdgeInsets.all(12.0),
                                  child: Image(image: AssetImage(
                                      "assets/icons/icon_drawer_tab2.png"),
                                    height: 55.0,
                                    width: 55.0,
                                    fit: BoxFit.fitWidth,
                                    color: icon_color,
                                  ),
                                ),
                              ),
                              Text(
                                'รับคำกล่าวโทษ',
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          _onClickMenu(2);
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          width: size.width / 3,
                          child: Column(
                            children: <Widget>[
                              Card(
                                shape: new RoundedRectangleBorder(
                                    side: new BorderSide(
                                        color: Color(0xff549ee8), width: 1.5),
                                    borderRadius: BorderRadius.circular(4.0)
                                ),
                                elevation: 0.0,
                                child: Padding(padding: EdgeInsets.all(12.0),
                                  child: Image(image: AssetImage(
                                      "assets/icons/icon_drawer_tab3.png"),
                                    height: 55.0,
                                    width: 55.0,
                                    fit: BoxFit.fitWidth,
                                    color: icon_color,
                                  ),
                                ),
                              ),
                              Text(
                                'พิสูจน์ของกลาง',
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          _onClickMenu(3);
                        },
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: size.width / 3,
                            child: Column(
                              children: <Widget>[
                                Card(
                                  shape: new RoundedRectangleBorder(
                                      side: new BorderSide(
                                          color: Color(0xff549ee8), width: 1.5),
                                      borderRadius: BorderRadius.circular(4.0)
                                  ),
                                  elevation: 0.0,
                                  child: Padding(padding: EdgeInsets.all(12.0),
                                    child: Image(image: AssetImage(
                                        "assets/icons/icon_drawer_tab4.png"),
                                      height: 55.0,
                                      width: 55.0,
                                      fit: BoxFit.fitWidth,
                                      color: icon_color,
                                    ),
                                  ),
                                ),
                                Text(
                                  'ชำระค่าปรับ',
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      _onClickMenu(4);
                    },
                  ),
                  new Container(
                    height: 1.5,
                    color: const Color(0xffc8c8c8),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }

  Widget _buildContent2() {
    var size = MediaQuery
        .of(context)
        .size;
    return Container(
      //padding: EdgeInsets.only(left:12.0,right: 12.0,bottom: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.only(
                left: 12.0, right: 12.0, bottom: 12.0, top: 12.0),
            child: new Text('งานจัดการของกลาง',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
          ),
          new Container(
            //padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: size.width / 3,
                        child: Column(
                          children: <Widget>[
                            Card(
                              shape: new RoundedRectangleBorder(
                                  side: new BorderSide(
                                      color: Color(0xff549ee8), width: 1.5),
                                  borderRadius: BorderRadius.circular(4.0)
                              ),
                              elevation: 0.0,
                              child: Padding(padding: EdgeInsets.all(12.0),
                                child: Image(image: AssetImage(
                                    "assets/icons/icon_drawer_tab5.png"),
                                  height: 55.0,
                                  width: 55.0,
                                  fit: BoxFit.cover,
                                  color: icon_color,
                                ),
                              ),
                            ),
                            Text(
                              'จัดการของกลาง',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: size.width / 3,
                        child: Column(
                          children: <Widget>[
                            Card(
                              shape: new RoundedRectangleBorder(
                                  side: new BorderSide(
                                      color: Color(0xff549ee8), width: 1.5),
                                  borderRadius: BorderRadius.circular(4.0)
                              ),
                              elevation: 0.0,
                              child: Padding(padding: EdgeInsets.all(12.0),
                                child: Image(image: AssetImage(
                                    "assets/icons/icon_drawer_tab6.png"),
                                  height: 55.0,
                                  width: 55.0,
                                  fit: BoxFit.fitWidth,
                                  color: icon_color,
                                ),
                              ),
                            ),
                            Text(
                              'ทะเบียนบัญชีของกลาง',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: size.width / 3,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: new Container(
                      height: 1.5,
                      color: const Color(0xffc8c8c8),
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }

  Widget _buildContent3() {
    var size = MediaQuery
        .of(context)
        .size;
    return Container(
      //padding: EdgeInsets.only(left:12.0,right: 12.0,bottom: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.all(12.0),
            child: new Text('งานส่วนอื่นๆ',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
          ),
          new Container(
            //padding: EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: size.width / 3,
                        child: Column(
                          children: <Widget>[
                            Card(
                              shape: new RoundedRectangleBorder(
                                  side: new BorderSide(
                                      color: Color(0xff549ee8), width: 1.5),
                                  borderRadius: BorderRadius.circular(4.0)
                              ),
                              elevation: 0.0,
                              child: Padding(padding: EdgeInsets.all(12.0),
                                child: Image(image: AssetImage(
                                    "assets/icons/icon_drawer_tab7.png"),
                                  height: 55.0,
                                  width: 55.0,
                                  fit: BoxFit.fitWidth,
                                  color: icon_color,
                                ),
                              ),
                            ),
                            Text(
                              'เครือข่ายผู้ต้องหา',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: size.width / 3,
                        child: Column(
                          children: <Widget>[
                            Card(
                              shape: new RoundedRectangleBorder(
                                  side: new BorderSide(
                                      color: Color(0xff549ee8), width: 1.5),
                                  borderRadius: BorderRadius.circular(4.0)
                              ),
                              elevation: 0.0,
                              child: Padding(padding: EdgeInsets.all(12.0),
                                child: Image(image: AssetImage(
                                    "assets/icons/icon_drawer_tab8.png"),
                                  height: 55.0,
                                  width: 55.0,
                                  fit: BoxFit.cover,
                                  color: icon_color,
                                ),
                              ),
                            ),
                            Text(
                              'ติดตามสถานะ',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: size.width / 3,
                        child: Column(
                          children: <Widget>[
                            Card(
                              shape: new RoundedRectangleBorder(
                                  side: new BorderSide(
                                      color: Color(0xff549ee8), width: 1.5),
                                  borderRadius: BorderRadius.circular(4.0)
                              ),
                              elevation: 0.0,
                              child: Padding(padding: EdgeInsets.all(12.0),
                                child: Image(image: AssetImage(
                                    "assets/icons/icon_drawer_tab9.png"),
                                  height: 55.0,
                                  width: 55.0,
                                  fit: BoxFit.cover,
                                  color: icon_color,
                                ),
                              ),
                            ),
                            Text(
                              'รายงานสถิติ',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: size.width / 3,
                          child: Column(
                            children: <Widget>[
                              Card(
                                shape: new RoundedRectangleBorder(
                                    side: new BorderSide(
                                        color: Color(0xff549ee8), width: 1.5),
                                    borderRadius: BorderRadius.circular(4.0)
                                ),
                                elevation: 0.0,
                                child: Padding(padding: EdgeInsets.all(12.0),
                                  child: Image(image: AssetImage(
                                      "assets/icons/icon_drawer_tab10.png"),
                                    height: 55.0,
                                    width: 55.0,
                                    fit: BoxFit.fitWidth,
                                    color: icon_color,
                                  ),
                                ),
                              ),
                              Text(
                                'ห้องสนทนา',
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _getMenuItemWidget(_selectedMenuIndex),
    );
  }
}