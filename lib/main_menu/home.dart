import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:prototype_app_pang/color/text.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_search_screen.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/lawsuit_screen_1_search.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/arrest_screen_1_search.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/tab_creen_arrest/tab_arrest_2/tab_screen_arrest_2_search.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_search_screen.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/arrest_tab.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/check_evidence_tab.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/compare_tab.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/main_tab.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/lawsuit_tab.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/prove_tab.dart';
import 'package:prototype_app_pang/text/text.dart';
import 'package:flutter/services.dart';

class DrawerItem {
  String title;
  AssetImage icon;
  DrawerItem(this.title, this.icon);
}
class HomeScreen extends StatefulWidget {
  /*@override
  _HomeScreenState createState() => new _HomeScreenState();*/
  SetText _text = new SetText();
  final drawerItems = [
    new DrawerItem("ระบบผู้กระทำผิดกฏหมายสรรพสามิต", null),
    new DrawerItem("จับกุม", AssetImage("assets/icons/icon_drawer_tab1.png")),
    new DrawerItem("รับคำกล่าวโทษ", AssetImage("assets/icons/icon_drawer_tab2.png")),
    new DrawerItem("พิสูจน์ของกลาง", AssetImage("assets/icons/icon_drawer_tab3.png")),
    new DrawerItem("ชำระค่าปรับ", AssetImage("assets/icons/icon_drawer_tab4.png")),
    new DrawerItem("จัดการของกลาง", AssetImage("assets/icons/icon_drawer_tab5.png")),
    new DrawerItem("ทะเบียนบัญชีของกลาง", AssetImage("assets/icons/icon_drawer_tab6.png")),
    new DrawerItem("เครือข่ายผู้ต้องหา", AssetImage("assets/icons/icon_drawer_tab7.png")),
    new DrawerItem("ติดตามสถานะคดี", AssetImage("assets/icons/icon_drawer_tab8.png")),
    new DrawerItem("รายงานสถิติ", AssetImage("assets/icons/icon_drawer_tab9.png")),
    new DrawerItem("ห้องสนทนา", AssetImage("assets/icons/icon_drawer_tab10.png")),

    new DrawerItem("ตรวจรับของกลาง", AssetImage("assets/icons/icon_drawer_tab5_1.png")),
    new DrawerItem("ทำลายของกลาง", AssetImage("assets/icons/icon_drawer_tab5_2.png")),
    new DrawerItem("ขายทอดตลาด", AssetImage("assets/icons/icon_drawer_tab5_3.png")),
    new DrawerItem("โอนย้ายของกลาง", AssetImage("assets/icons/icon_drawer_tab5_4.png")),
    new DrawerItem("ทะเบียนบัญชีของกลาง", AssetImage("assets/icons/icon_drawer_tab6.png")),
    new DrawerItem("จัดเก็บเข้าพิพิธภัณฑ์", AssetImage("assets/icons/icon_drawer_tab5_6.png")),
    new DrawerItem("อนุมัติของกลาง", AssetImage("assets/icons/icon_drawer_tab5_7.png")),
    new DrawerItem("นำของกลางออกจากคลัง", AssetImage("assets/icons/icon_drawer_tab5_8.png")),
    new DrawerItem("คืนของกลาง", AssetImage("assets/icons/icon_drawer_tab5_9.png")),
    //new DrawerItem("Fragment 3", Icons.info)
  ];

  /*final drawerSubItems = [
    null,
    new DrawerItem("ตรวจรับของกลาง", AssetImage("assets/icons/icon_drawer_tab5_1.png")),
    new DrawerItem("ทำลายของกลาง", AssetImage("assets/icons/icon_drawer_tab5_2.png")),
    new DrawerItem("ขายทอดตลาด", AssetImage("assets/icons/icon_drawer_tab5_3.png")),
    new DrawerItem("โอนย้ายของกลาง", AssetImage("assets/icons/icon_drawer_tab5_4.png")),
    new DrawerItem("ทะเบียนบัญชีของกลาง", AssetImage("assets/icons/icon_drawer_tab6.png")),
    new DrawerItem("จัดเก็บเข้าพิพิธภัณฑ์", AssetImage("assets/icons/icon_drawer_tab5_6.png")),
    new DrawerItem("อนุมัติของกลาง", AssetImage("assets/icons/icon_drawer_tab5_7.png")),
    new DrawerItem("นำของกลางออกจากคลัง", AssetImage("assets/icons/icon_drawer_tab5_8.png")),
    new DrawerItem("คืนของกลาง", AssetImage("assets/icons/icon_drawer_tab5_9.png")),
    //new DrawerItem("Fragment 3", Icons.info)
  ];*/

  @override
  State<StatefulWidget> createState() {
    return new _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen>  {
  int _selectedDrawerIndex = 0;
  TextColors _colors=new TextColors();
  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new MainMenuFragment();
      case 1:
        return new ArrestFragment();
      case 2:
        return new LawsuitFragment();
      case 3:
        return new ProveFragment();
      case 4:
        return new CompareFragment();
      case 11:
        return new CheckEvidenceFragment();
      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  void initState() {
    super.initState();
  }

  buildCollapsed() {
    Color icon_color = Color(0xff549ee8);
    Widget content1,content2;
    for (var i = 0; i < 11; i++) {
      if (i > 0) {
        var d = widget.drawerItems[i];
        if (i == 5) {
          content1 = new Container(
            padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
            //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: Container(
              decoration: i == _selectedDrawerIndex
                  ? new BoxDecoration (
                color: _colors.drawer_selected,
              )
                  : null,
              alignment: Alignment.center,
              child: new ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 1.5),
                leading: Image(image: d.icon,
                  height: 35.0,
                  width: 35.0,
                  fit: BoxFit.cover,
                  color: i == _selectedDrawerIndex
                      ? Colors.white
                      : icon_color,
                ),
                title: new Text(d.title, style: TextStyle(
                    color: i == _selectedDrawerIndex
                        ? Colors.white
                        : null),),
                //selected: i == _selectedDrawerIndex,
                //onTap: () => _onSelectItem(i),
              ),
            ),
          );
        }else if(i==6) {
         content2 = new Column(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                child: Container(
                  decoration: i == _selectedDrawerIndex
                      ? new BoxDecoration (
                    color: _colors.drawer_selected,
                  )
                      : null,
                  alignment: Alignment.center,
                  child: new ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 1.5),
                    leading: Image(image: d.icon,
                      height: 35.0,
                      width: 35.0,
                      fit: BoxFit.cover,
                      color: i == _selectedDrawerIndex
                          ? Colors.white
                          : icon_color,
                    ),
                    title: new Text(d.title, style: TextStyle(
                        color: i == _selectedDrawerIndex
                            ? Colors.white
                            : null),),
                    selected: i == _selectedDrawerIndex,
                    onTap: () => _onSelectItem(i),
                  ),
                ),
              ),
            ],
          );
        }
      }
    }
    return Column(
      children: <Widget>[
        new Column(
            children: <Widget>[
              content1,
              content2,
            ],
        )
      ],
    );
  }

  buildExpanded() {
    Color icon_color = Color(0xff549ee8);
    var drawerOptions = <Widget>[];
    for (var i = 11; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new Column(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                child: Container(
                  decoration: i == _selectedDrawerIndex
                      ? new BoxDecoration (
                    color: _colors.drawer_selected,
                  )
                      : null,
                  alignment: Alignment.center,
                  child: new ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 1.5),
                    leading: Image(image: d.icon,
                      height: 35.0,
                      width: 35.0,
                      fit: BoxFit.cover,
                      color: i == _selectedDrawerIndex
                          ? Colors.white
                          : icon_color,
                    ),
                    title: new Text(d.title, style: TextStyle(
                        color: i == _selectedDrawerIndex
                            ? Colors.white
                            : null),),
                    selected: i == _selectedDrawerIndex,
                    onTap: () => _onSelectItem(i),
                  ),
                ),
              ),
            ],
          )
      );
    }
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            new Column(children: drawerOptions)
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color icon_color = Color(0xff549ee8);

    var drawerSubOptions = <Widget>[];
    for (var i = 11; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerSubOptions.add(
          new Column(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                child: Container(
                  decoration: i == _selectedDrawerIndex
                      ? new BoxDecoration (
                    color: _colors.drawer_selected,
                  )
                      : null,
                  alignment: Alignment.center,
                  child: new ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 1.5),
                    leading: Image(image: d.icon,
                      height: 35.0,
                      width: 35.0,
                      fit: BoxFit.cover,
                      color: i == _selectedDrawerIndex
                          ? Colors.white
                          : icon_color,
                    ),
                    title: new Text(d.title, style: TextStyle(
                        color: i == _selectedDrawerIndex
                            ? Colors.white
                            : null),),
                    selected: i == _selectedDrawerIndex,
                    onTap: () => _onSelectItem(i),
                  ),
                ),
              ),
            ],
          )
      );
    }
    var drawerOptions = <Widget>[];
    drawerOptions.add(
      new DrawerHeader(
        child: GestureDetector(
          onTap: (){
            _onSelectItem(0);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Color(0xff2e76bc),
                child: Text('ว',style: TextStyle(fontSize: 20.0),),
              ),
              new Padding(padding: EdgeInsets.only(top:12.0),child:  Text('นายวรัท ดูเบ'),),
              new Padding(padding: EdgeInsets.all(6.0),child:  Text('หน่วยงาน สำนักงานกรมสรรพสามิต'),),
            ],
          ),
        )
      ),
    );

    for (var i = 0; i < 11; i++) {
      if (i > 0) {
        var d = widget.drawerItems[i];
        if(i==4||i==5||i==6||i==7) {
          if (i == 5) {
            drawerOptions.add(
                new Column(
                  children: <Widget>[
                    new Padding(
                      padding: EdgeInsets.only(left: 18.0, right: 18.0),
                      child: new Container(
                        height: 1.0,
                        color: Colors.grey[300],
                      ),
                    ),
                    ExpandableNotifier(
                      child: Stack(
                        children: <Widget>[
                          Expandable(
                              collapsed: buildCollapsed(),
                              expanded: buildExpanded()
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Builder(
                                builder: (context) {
                                  var exp = ExpandableController.of(context);
                                  return Container(
                                      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                                  //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                                  child:IconButton(
                                    icon: Icon(
                                      exp.expanded
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      //size: 18.0,
                                      color: Colors.grey,),
                                    onPressed: () {
                                      exp.toggle();
                                    },
                                  ),
                                  );
                                }
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
            );
          }else if(i==6){
            //
        }else if(i==7) {
            drawerOptions.add(
                new Column(
                  children: <Widget>[
                    new Padding(
                      padding: EdgeInsets.only(left: 18.0, right: 18.0),
                      child: new Container(
                        height: 1.0,
                        color: Colors.grey[300],
                      ),
                    ),
                    new Container(
                      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                      //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                      child: Container(
                        decoration: i == _selectedDrawerIndex
                            ? new BoxDecoration (
                          color: _colors.drawer_selected,
                        )
                            : null,
                        alignment: Alignment.center,
                        child: new ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 1.5),
                          leading: Image(image: d.icon,
                            height: 35.0,
                            width: 35.0,
                            fit: BoxFit.cover,
                            color: i == _selectedDrawerIndex
                                ? Colors.white
                                : icon_color,
                          ),
                          title: new Text(d.title, style: TextStyle(
                              color: i == _selectedDrawerIndex
                                  ? Colors.white
                                  : null),),
                          selected: i == _selectedDrawerIndex,
                          onTap: () => _onSelectItem(i),
                        ),
                      ),
                    ),
                  ],
                )
            );
          }else {
            drawerOptions.add(
                new Column(
                  children: <Widget>[
                    new Container(
                      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                      //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                      child: Container(
                        decoration: i == _selectedDrawerIndex
                            ? new BoxDecoration (
                          color: _colors.drawer_selected,
                        )
                            : null,
                        alignment: Alignment.center,
                        child: new ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 1.5),
                          leading: Image(image: d.icon,
                            height: 35.0,
                            width: 35.0,
                            fit: BoxFit.cover,
                            color: i == _selectedDrawerIndex
                                ? Colors.white
                                : icon_color,
                          ),
                          title: new Text(d.title, style: TextStyle(
                              color: i == _selectedDrawerIndex
                                  ? Colors.white
                                  : null),),
                          selected: i == _selectedDrawerIndex,
                          onTap: () => _onSelectItem(i),
                        ),
                      ),
                    ),
                  ],
                )
            );
          }
        }else {
          drawerOptions.add(
            new Container(
              padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
              //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
              child: Container(
                decoration: i == _selectedDrawerIndex ? new BoxDecoration (
                  color: _colors.drawer_selected,
                ) : null,
                alignment: Alignment.center,
                child: new ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 1.5),
                  leading: Image(image: d.icon,
                    height: 35.0,
                    width: 35.0,
                    fit: BoxFit.cover,
                    color: i == _selectedDrawerIndex ? Colors.white : icon_color,
                  ),
                  title: new Text(d.title, style: TextStyle(
                      color: i == _selectedDrawerIndex
                          ? Colors.white
                          : null),),
                  selected: i == _selectedDrawerIndex,
                  onTap: () => _onSelectItem(i),
                ),
              ),
            ),
          );
        }
      }
    }

    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        centerTitle: true,
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title,style: TextStyle(fontSize: 16.0),),
        actions: <Widget>[
          _selectedDrawerIndex==0?Container():new IconButton( icon: new Icon(Icons.search,color: Colors.white,), tooltip: 'Search',
            onPressed: (){
            switch(_selectedDrawerIndex){
              case 1 :
                Navigator.of(context)
                    .push(
                    new MaterialPageRoute(
                        builder: (context) => ArrestMainScreenFragmentSearch()));
                break;
              case 2 :
                Navigator.of(context)
                    .push(
                    new MaterialPageRoute(
                        builder: (context) => LawsuitMainScreenFragmentSearch()));
                break;
              case 3 :
                Navigator.of(context)
                    .push(
                    new MaterialPageRoute(
                        builder: (context) => ProveMainScreenFragmentSearch()));
                break;
              case 4 :
                Navigator.of(context)
                    .push(
                    new MaterialPageRoute(
                        builder: (context) => CompareMainScreenFragmentSearch()));
                break;
            }

            },
          ),
        ],
      ),
      drawer: new Drawer(
        child: new SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Column(children: drawerOptions)
                ],
              ),
            ],
          ),
        )
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Branch>[]]);

  final String title;
  final List<Branch> children;
}
class Branch {
  Branch(this.title, this.desc);

  final String title;
  final String desc;
}