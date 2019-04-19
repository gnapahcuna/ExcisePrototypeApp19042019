
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_4.dart';

class TabScreenArrest4SearchFace extends StatefulWidget {
  Future<File> ImageFile;
  TabScreenArrest4SearchFace({
    Key key,
    @required this.ImageFile,
  }) : super(key: key);
  @override
  _TabScreenArrest4SearchFaceState createState() => new _TabScreenArrest4SearchFaceState();
}
class _TabScreenArrest4SearchFaceState extends State<TabScreenArrest4SearchFace> {

  List<ItemsListArrest4> _itemData=[];
  List<ItemsListArrest4> _itemsInit = [
    new ItemsListArrest4(
        null,
        null,
        null,
        "นาย",
        "สมพงษ์ ชาติชาย",
        null,
        null,
        null,
        2,
        false,null,null,null,
      "https://i.pinimg.com/originals/9b/4d/3b/9b4d3b6c6d20acc66a2558a76a2c5ae5.jpg",100
    ),
    new ItemsListArrest4(
        null,
        null,
        null,
        "นาย",
        "เสนาะ อุตะมา",
        null,
        null,
        null,
        4,
        false,null,null,null,
        "https://i.pinimg.com/originals/19/d1/90/19d1906421efdfc2cb96194c751c0fc2.jpg",55)
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildImage(BuildContext context) {
    return FutureBuilder<File>(
        future: widget.ImageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white30),
              ),
              margin: const EdgeInsets.only(top: 22.0,bottom: 22.0),
              padding: const EdgeInsets.all(3.0),
              child: ClipOval(
                child: Image.file(snapshot.data,fit: BoxFit.cover),
              ),
            );
          } else if (snapshot.error != null) {
            return const Text(
              'Error picking image.',
              textAlign: TextAlign.center,
            );
          } else {
            return const Text(
              'You have not yet picked an image.',
              textAlign: TextAlign.center,
            );
          }
        });
  }
  Widget _buildContent() {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 80) / 100;
    TextStyle textInputStyleTitle = TextStyle(
    fontSize: 16.0, color: Colors.black);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
    return ListView.builder(
      itemCount: _itemsInit.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(top: 0.3, bottom: 0.3),
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
                leading: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white30),
                  ),
                  //margin: const EdgeInsets.only(top: 32.0, left: 16.0),
                  padding: const EdgeInsets.all(3.0),
                  child: ClipOval(
                    child: Image.network(_itemsInit[index].ImageURL,fit: BoxFit.cover,),
                  ),
                ),
                title: Text(_itemsInit[index].NameTitle +
                    _itemsInit[index].NameSus,
                  style: textInputStyleTitle,),
                trailing: Text(_itemsInit[index].Accuracy.toString()+' %',
                  style: textInputStyleTitle,),
                onTap: () {
                  List<ItemsListArrest4> items=[];
                  items.add(_itemsInit[index]);
                  Navigator.pop(context,items);
                }
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white);
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            title: new Padding(
              padding: EdgeInsets.only(right: 22.0),
              child: new Text("วิเคราะห์ข้อมูลผู้ต้องหา",
                style: styleTextAppbar,
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context,"back");
                }),
          ),
        ),
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
              Center(
                child: _buildImage(context),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 22.0),
                child: _buildContent(),
              )
            ],
          ),
        ),
      ),
    );
  }
}