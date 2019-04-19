import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/detail/lawsuit_not_accept_screen_offense_detail.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_offense.dart';

class LawsuitNotAcceptOffenseListScreenFragment extends StatefulWidget {
  List<ItemsLawsuitOffense> ItemsOffense;
  LawsuitNotAcceptOffenseListScreenFragment({
    Key key,
    @required this.ItemsOffense,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<LawsuitNotAcceptOffenseListScreenFragment>  with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildContent() {
    var size = MediaQuery
        .of(context)
        .size;
    TextStyle textStyleData = TextStyle(fontSize: 16, color: Colors.black);
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      // new
      itemCount: widget.ItemsOffense.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          //padding: EdgeInsets.only(top: 4.0,bottom: 4.0),
          child: Container(
            padding: EdgeInsets.only(
              left: 12.0, right: 12.0, top: 12.0, bottom: 12.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border(
                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(
                    new MaterialPageRoute(
                        builder: (context) => LawsuitNotAcceptOffenseDetailScreenFragment(ItemsOffense: widget.ItemsOffense,Indexs:index,Title:"เลขรับคำกล่าวโทษ " + widget.ItemsOffense[index].Number)));
              },
              title: Text("เลขรับคำกล่าวโทษ " + widget.ItemsOffense[index].Number,
                style: textStyleData,),
              subtitle: Text(
                  "ฐานความผิดมาตรา " + widget.ItemsOffense[index].SectionNumber,
                  style: textStyleData),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[400],size: 18.0),
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    TextStyle textStylePageName = TextStyle(color: Colors.grey[400]);
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0);
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            title: new Text("รายละเอียดการกระทำผิด",
              style: styleTextAppbar,
            ),
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
        ),
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
                      //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new Text(
                        'ILG60_B_02_00_09_00', style: textStylePageName,),
                    )
                  ],
                ),
              ),
              Expanded(
                child: new ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: SingleChildScrollView(
                    child: _buildContent(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class Choice {
  const Choice({this.title});
  final String title;
}