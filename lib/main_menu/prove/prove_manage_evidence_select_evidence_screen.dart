import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/prove/model/evidence.dart';

class ProveManageSelectEvidenceScreenFragment extends StatefulWidget {
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<ProveManageSelectEvidenceScreenFragment> {
  TabController tabController;
  List<ItemsEvidence> _itemsInit = [
    new ItemsEvidence(
        "สุรา",
        "สราแช่",
        "ชนิดเบียร์",
        "4.4",
        "ดีกรี",
        "hoegaarden",
        "",
        "SADLER S PEAKY BLINDER",
        0,
        "ลิตร",
      0,
      "",
      0,
      "",
        false,
        null,
      false
    ),
    new ItemsEvidence(
        "สุรา",
        "สราแช่",
        "ชนิดเบียร์",
        "4.5",
        "ดีกรี",
        "รวงข้าว",
        "",
        "40 Degree",
        0,
        "ลิตร",
        0,
        "",
        0,
        "",
        false,
        null,
      false
    )
  ];
  ItemsEvidence _itemsData;
  int _countItem = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildSearchResults() {
    TextStyle textInputStyleTitle = TextStyle(
        fontSize: 16.0, color: Colors.black);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
    return ListView.builder(
      itemCount: _itemsInit.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
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
                          _itemsInit[index].ProductCategory+  _itemsInit[index].ProductType+ ' > ' +
                              _itemsInit[index].MainBrand+ _itemsInit[index].ProductModel+ ' > ' +
                              _itemsInit[index].SubProductType + ' '+
                              _itemsInit[index].SubSetProductType + ' > ' +
                              _itemsInit[index].Capacity.toString() + ' ' +
                              _itemsInit[index].ProductUnit,
                          style: textInputStyleTitle,),
                      ),
                    ),
                    Center(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _itemsInit[index].IsCkecked =
                              !_itemsInit[index].IsCkecked;

                              for(int i=0;i<_itemsInit.length;i++){
                                if(i!=index){
                                  _itemsInit[i].IsCkecked =false;
                                }
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _itemsInit[index].IsCkecked
                                  ? Color(0xff3b69f3)
                                  : Colors.white,
                              border: _itemsInit[index].IsCkecked
                                  ?Border.all(color: Color(0xff3b69f3),width: 2)
                                  :Border.all(color: Colors.grey[400],width: 2),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: _itemsInit[index].IsCkecked
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottom() {
    var size = MediaQuery
        .of(context)
        .size;
    TextStyle textStyleButton = TextStyle(color: Colors.white, fontSize: 18.0);
    bool isCheck = false;
    _countItem = 0;
    _itemsInit.forEach((item) {
      if (item.IsCkecked)
        setState(() {
          isCheck = item.IsCkecked;
          _countItem++;
        });
    });
    return isCheck ? Container(
      width: size.width,
      height: 65,
      color: Color(0xff2e76bc),
      child: MaterialButton(
        onPressed: () {
          _itemsInit.forEach((item) {
            if (item.IsCkecked)
              _itemsData = item;
          });
          Navigator.pop(context,_itemsData);
        },
        child: Center(
          child: Text('เลือก', style: textStyleButton,),
        ),
      ),
    ) : null;
  }

  _navigateCreaet(BuildContext context) async {
    /*final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenArrest5Create(ItemsData: _itemsData,)),
    );
    if(result.toString()!="back"){
      _itemsData = result;
      Navigator.pop(context,result);
    }*/
  }


  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white);
    return new WillPopScope(
      onWillPop: () {
        //
      }, child: Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          title: new Text("ค้นหาของกลาง",
            style: styleTextAppbar,
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context, "Back");
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
                        child: new Text('ILG60_B_03_00_08_00',
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
                child: _buildSearchResults(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottom(),
    ),
    );
  }
}