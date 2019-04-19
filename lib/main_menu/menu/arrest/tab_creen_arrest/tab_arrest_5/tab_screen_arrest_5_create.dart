import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_5.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_5_controller.dart';

class TabScreenArrest5Create extends StatefulWidget {
  List<ItemsListArrest5>ItemsData;
  TabScreenArrest5Create({
    Key key,
    @required this.ItemsData,
  }) : super(key: key);
  @override
  _TabScreenArrest5CreateState createState() => new _TabScreenArrest5CreateState();
}
class _TabScreenArrest5CreateState extends State<TabScreenArrest5Create> {

  List<ItemsListArrest5Controller> itemsController=[];

  int _countItem = 0;

  @override
  void initState() {
    super.initState();
    widget.ItemsData.forEach((item){
      TextEditingController editProductUnit= new TextEditingController();
      TextEditingController editVolumeUnit= new TextEditingController();
      FocusNode focusNodeProductUnit = FocusNode();
      FocusNode focusNodeVolumeUnit = FocusNode();
      itemsController.add(new ItemsListArrest5Controller(editProductUnit, editVolumeUnit,
          focusNodeProductUnit,focusNodeVolumeUnit,
          ["ขวด",'ลัง'],["ลิตร",'มิลลิกรัม'],"ขวด","ลิตร"));
    });
  }


  @override
  void dispose() {
    super.dispose();
    itemsController.forEach((item){
      item.myFocusNodeProductUnit.dispose();
      item.myFocusNodeVolumeUnit.dispose();
    });
  }

  Widget _buildSearchResults() {

    TextStyle textInputStyleTitle = TextStyle(
        fontSize: 16.0, color: Colors.black);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
    EdgeInsets paddingLabelTitle = EdgeInsets.only(bottom: 16.0);
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 100) / 100;
    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);

    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );
    return ListView.builder(
      itemCount: widget.ItemsData.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        /*TextEditingController editProductUnit = new TextEditingController();
        TextEditingController editVolumnUnit= new TextEditingController();
        FocusNode myFocusNodeProductUnit=new FocusNode();
        FocusNode myFocusNodeVolumeUnit=new FocusNode();
        arrEdtProductUnit.add(editProductUnit);
        arrEdtVolumnUnit.add(editVolumnUnit);
        arrNodeProductUnit.add(myFocusNodeProductUnit);
        arrNodeVolumnUnit.add(myFocusNodeVolumeUnit);*/

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: paddingLabelTitle,
                        child: Text(
                          widget.ItemsData[index].ProductCategory+  widget.ItemsData[index].ProductType+ ' > ' +
                              widget.ItemsData[index].MainBrand+ widget.ItemsData[index].ProductModel+ ' > ' +
                              widget.ItemsData[index].SubProductType + ' '+
                              widget.ItemsData[index].SubSetProductType + ' > ' +
                              widget.ItemsData[index].Capacity.toString() + ' ' +
                              widget.ItemsData[index].ProductUnit,
                          style: textInputStyleTitle,),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: ((size.width*75)/100)/2,
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("จำนวน", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: itemsController[index].myFocusNodeProductUnit,
                              controller: itemsController[index].editProductUnit,
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
                    Container(
                      width: ((size.width*75)/100)/2,
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("หน่วย", style: textLabelStyle,),
                          ),
                          Container(
                            width: Width,
                            //padding: paddingInputBox,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: itemsController[index].dropdownValueProductUnit,
                                onChanged: (String newValue) {
                                  setState(() {
                                    itemsController[index].dropdownValueProductUnit= newValue;
                                  });
                                },
                                items: itemsController[index].dropdownItemsProductUnit
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                })
                                    .toList(),
                              ),
                            ),
                          ),
                          _buildLine,
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: ((size.width*75)/100)/2,
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("ปริมาณสุทธิ", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: itemsController[index].myFocusNodeVolumeUnit,
                              controller: itemsController[index].editVolumeUnit,
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
                    Container(
                      width: ((size.width*75)/100)/2,
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("หน่วย", style: textLabelStyle,),
                          ),
                          Container(
                            width: Width,
                            //padding: paddingInputBox,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: itemsController[index].dropdownValueVolumeUnit,
                                onChanged: (String newValue) {
                                  setState(() {
                                    itemsController[index].dropdownValueVolumeUnit= newValue;
                                  });
                                },
                                items: itemsController[index].dropdownItemsVolumeUnit
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                })
                                    .toList(),
                              ),
                            ),
                          ),
                          _buildLine,
                        ],
                      ),
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
    widget.ItemsData.forEach((item) {
      if (item.isCheck)
        setState(() {
          isCheck = item.isCheck;
          _countItem++;
        });
    });
    return Container(
      width: size.width,
      height: 65,
      color: Color(0xff2e76bc),
      child: MaterialButton(
        onPressed: () {
          /*widget.ItemsData.forEach((item) {
            print(item.Counts.toString()+", "+item.Volume.toString());
            if (item.isCheck)
              widget.ItemsData.add(item);
          });*/
          for(int i=0;i<itemsController.length;i++){
            widget.ItemsData[i].Counts = double.parse(itemsController[i].editProductUnit.text);
            widget.ItemsData[i].Volume = double.parse(itemsController[i].editVolumeUnit.text);
            widget.ItemsData[i].CountsUnit = itemsController[i].dropdownValueProductUnit;
            widget.ItemsData[i].VolumeUnit = itemsController[i].dropdownValueVolumeUnit;
          }
          Navigator.pop(context,widget.ItemsData);
        },
        child: Center(
          child: Text('ตกลง', style: textStyleButton,),
        ),
      ),
    );
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
          title: new Padding(
            padding: EdgeInsets.only(right: 22.0),
            child: new Text("ค้นหาของกลาง",
              style: styleTextAppbar,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context, "back");
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