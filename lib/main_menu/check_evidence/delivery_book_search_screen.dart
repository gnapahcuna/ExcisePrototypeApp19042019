import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/check_evidence_select_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/delivery_book_select_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence.dart';

class DeliveryBookSearchScreenFragment extends StatefulWidget {
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<DeliveryBookSearchScreenFragment> {
  ItemsEvidence _itemsData;

  final FocusNode myFocusNodeSearch = FocusNode();
  TextEditingController editSearch = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
    editSearch.dispose();
  }

  Widget _buildContent(BuildContext context) {
    Color labelColor = Color(0xff087de1);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor);
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 85) / 100;
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border(
              top: BorderSide(color: Colors.grey[300], width: 1.0),
              //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )
        ),
        width: size.width,
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
            width: Width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildInput(),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Card(
                          shape: new RoundedRectangleBorder(
                              side: new BorderSide(
                                  color: labelColor, width: 1.5),
                              borderRadius: BorderRadius.circular(12.0)
                          ),
                          elevation: 0.0,
                          child: Container(
                            width: 100.0,
                            child: MaterialButton(
                              onPressed: () {
                                _navigate(context);
                              },
                              splashColor: Colors.grey,
                              child: Center(
                                child: Text("ค้นหา", style: textLabelStyle,),),
                            ),
                          )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  Widget _buildInput() {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 100) / 100;
    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text("เลขที่หนังสือ", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeSearch,
            controller: editSearch,
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
    );
  }

  _navigate(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectDeliveryBookScreenFragment()),
    );
    if(result.toString()!="Back"){
      _itemsData = result;
      Navigator.pop(context,result);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white);
    return new WillPopScope(
      onWillPop: () {
        //
      }, child: Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          title: new Text("ค้นหาหนังสือนำส่ง",
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
                        child: new Text('ILG60_B_05_00_14_00',
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
                    child: _buildContent(context),
                  )
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}