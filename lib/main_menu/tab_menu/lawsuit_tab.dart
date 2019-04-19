import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/lawsuit_accept_case_screen.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/lawsuit_not_accept_case_screen_1.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_%20suspect.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_case_information.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_evidence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_offense.dart';

class LawsuitFragment extends StatefulWidget {
  @override
  _LawsuitFragmentState createState() => new _LawsuitFragmentState();
}
class _LawsuitFragmentState extends State<LawsuitFragment>  {

  //style content
  TextStyle textStyleLanding = TextStyle(fontSize: 20);
  TextStyle textStyleLabel = TextStyle(fontSize: 16,color: Color(0xff087de1));
  TextStyle textStyleData = TextStyle(fontSize: 18,color: Colors.black);
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400]);
  TextStyle textStyleDataSub = TextStyle(fontSize: 16,color: Colors.grey[400]);
  EdgeInsets paddingData =  EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel =  EdgeInsets.only(top: 4.0, bottom: 4.0);
  TextStyle textStyleButtonAccept = TextStyle(fontSize: 16,color: Colors.white);
  TextStyle textStyleButtonNotAccept = TextStyle(fontSize: 16,color: Color(0xff087de1));
  //item data
  /*List<ItemsLawsuit> _itemsInit=[
    new ItemsLawsuit("TN90403056100047", "203", "นายเสนาะ อุตโม"),
    new ItemsLawsuit("TN90403056100048", "204", "นายวสันต์ ศรีอ้วน")
  ];*/
  List<ItemsLawsuitCaseInformation> itemsCaseInformation = [
    new ItemsLawsuitCaseInformation(
        "TN90403056100047",
        "นายมิตรชัย เอกชัย",
        "09 ตุลาคม 2561",
        "เวลา 13.00 น.",
        "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
        "203",
        "มีไวในครอบครองซึ่งสินค้าที่มิได้เสียภาษี",
        "",
        [
          new ItemsLawsuitSuspect(
              "นายเสนาะ อุตโม",
              "บุคคลธรรมดา",
              "คนไทย",
              "155600009661",
              "เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
              [
                new ItemsLawsuitOffense(
                  "105/2561",
                  "203",
                  "มีไว้ครอบครองโดยมิได้เสียภาษี",
                  "09 กันยายน 2561",
                  "สุรา",
                  "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                  "1/2561",
                  "10000",
                  "กรมสรรพสามิต",
                ),
                new ItemsLawsuitOffense(
                  "1/2562",
                  "209",
                  "มีไว้ครอบครองโดยมิได้เสียภาษี",
                  "09 กันยายน 2561",
                  "สุรา",
                  "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                  "1/2561",
                  "10000",
                  "กรมสรรพสามิต",
                ),
              ],
              null
          ),
          new ItemsLawsuitSuspect(
              "นายวสันต์ ศรีอ้วน",
              "บุคคลธรรมดา",
              "คนไทย",
              "155600009662",
              "เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
              [
                new ItemsLawsuitOffense(
                  "1/2562",
                  "209",
                  "มีไว้ครอบครองโดยมิได้เสียภาษี",
                  "09 กันยายน 2561",
                  "สุรา",
                  "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                  "1/2561",
                  "10000",
                  "กรมสรรพสามิต",
                ),
                new ItemsLawsuitOffense(
                  "102/2561",
                  "203",
                  "มีไว้ครอบครองโดยมิได้เสียภาษี",
                  "09 กันยายน 2561",
                  "สุรา",
                  "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                  "1/2561",
                  "10000",
                  "กรมสรรพสามิต",
                )
              ],
              null
          ),
        ],
        [
          new ItemsLawsuitEvidence(
              "เบียร์",
              "สราแช่",
              "ชนิดเบียร์",
              "4.4",
              "ดีกรี",
              "hoegaarden",
              "",
              "SADLER S PEAKY BLINDER",
              22,
              "ขวด",
              500,
              "ลิตร",
              1100,
              "มิลลิกรัม",
            false
          ),
          new ItemsLawsuitEvidence(
            "เบียร์",
            "สราแช่",
            "ชนิดเบียร์",
            "4.5",
            "ดีกรี",
            "Leo",
            "",
            "SADLER S PEAKY BLINDER",
            23,
            "ขวด",
            750,
            "ลิตร",
            1500,
            "มิลลิกรัม",
              false)
        ],
        null
        ,false,
      false
    ),
    new ItemsLawsuitCaseInformation(
        "TN90403056100048",
        "นายอนุชา นักผล",
        "09 ตุลาคม 2561",
        "เวลา 13.00 น.",
        "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
        "203",
        "มีไวในครอบครองซึ่งสินค้าที่มิได้เสียภาษี",
        "",
        [
          new ItemsLawsuitSuspect(
              "นายเสนาะ อุตโม",
              "บุคคลธรรมดา",
              "คนไทย",
              "155600009661",
              "เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
              [
                new ItemsLawsuitOffense(
                  "105/2561",
                  "203",
                  "มีไว้ครอบครองโดยมิได้เสียภาษี",
                  "09 กันยายน 2561",
                  "สุรา",
                  "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                  "1/2561",
                  "10000",
                  "กรมสรรพสามิต",
                ),
                new ItemsLawsuitOffense(
                  "1/2562",
                  "209",
                  "มีไว้ครอบครองโดยมิได้เสียภาษี",
                  "09 กันยายน 2561",
                  "สุรา",
                  "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                  "1/2561",
                  "10000",
                  "กรมสรรพสามิต",
                ),
              ],
              null
          ),
          new ItemsLawsuitSuspect(
              "นายวสันต์ ศรีอ้วน",
              "บุคคลธรรมดา",
              "คนไทย",
              "155600009662",
              "เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
              [
                new ItemsLawsuitOffense(
                  "1/2562",
                  "209",
                  "มีไว้ครอบครองโดยมิได้เสียภาษี",
                  "09 กันยายน 2561",
                  "สุรา",
                  "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                  "1/2561",
                  "10000",
                  "กรมสรรพสามิต",
                ),
                new ItemsLawsuitOffense(
                  "102/2561",
                  "203",
                  "มีไว้ครอบครองโดยมิได้เสียภาษี",
                  "09 กันยายน 2561",
                  "สุรา",
                  "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                  "1/2561",
                  "10000",
                  "กรมสรรพสามิต",
                )
              ],
              null
          ),
        ],
        [
          new ItemsLawsuitEvidence(
              "เบียร์",
              "สราแช่",
              "ชนิดเบียร์",
              "4.4",
              "ดีกรี",
              "hoegaarden",
              "",
              "SADLER S PEAKY BLINDER",
              22,
              "ขวด",
              500,
              "ลิตร",
              1100,
              "มิลลิกรัม",
              false
          ),
          new ItemsLawsuitEvidence(
            "เบียร์",
            "สราแช่",
            "ชนิดเบียร์",
            "4.5",
            "ดีกรี",
            "Leo",
            "",
            "SADLER S PEAKY BLINDER",
            23,
            "ขวด",
            750,
            "ลิตร",
            1500,
            "มิลลิกรัม",
              false)
        ],
        null
        ,false,
        true,
    )
  ];

  Widget _buildContent(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 85) / 100;
    return ListView.builder(
      itemCount: itemsCaseInformation.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return itemsCaseInformation[index].IsActive ? Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            //Text("ไม่มีรายการรับคดี", style: textStyleLanding,)
          ],
        )
            : Padding(
          padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
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
            child: Stack(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("เลขที่ใบงาน", style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      itemsCaseInformation[index].ArrestNumber,
                      style: textStyleData,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text("ฐานความผิดมาตรา", style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      itemsCaseInformation[index].MistakeNumber,
                      style: textStyleData,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text("ชื่อผู้ต้องหา", style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      itemsCaseInformation[index].Suspects[0].SuspectName,
                      style: textStyleData,),
                  ),
                  itemsCaseInformation[index].Suspects.length > 1 ? Padding(
                    padding: paddingData,
                    child: Row(
                      children: <Widget>[
                        Text(
                          itemsCaseInformation[index].Suspects[1].SuspectName,
                          style: textStyleDataSub,),
                        itemsCaseInformation[index].Suspects.length-2!=0?
                        Text(' ... และคนอื่นๆ '+(itemsCaseInformation[index].Suspects.length-2).toString(),
                          style: textStyleDataSub,)
                            :Container()
                      ],
                    )
                  )
                      : Container()
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: new Card(
                            color: Color(0xff087de1),
                            shape: new RoundedRectangleBorder(
                                side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                            ),
                            elevation: 0.0,
                            child: Container(
                                width: 100.0,
                                //height: 40,
                                child: Center(
                                  child: MaterialButton(
                                    onPressed: () {
                                      _navigateLawsuitAcceptCase(
                                          context,itemsCaseInformation[index], index);
                                    },
                                    splashColor: Color(0xff087de1),
                                    //highlightColor: Colors.blue,
                                    child: Center(
                                      child: Text("รับคดี",
                                        style: textStyleButtonAccept,),),
                                  ),
                                )
                            )
                        ),
                      ),
                      new Card(
                          shape: new RoundedRectangleBorder(
                              side: new BorderSide(
                                  color: Color(0xff087de1), width: 1.5),
                              borderRadius: BorderRadius.circular(12.0)
                          ),
                          elevation: 0.0,
                          child: Container(
                              width: 100.0,
                              //height: 40,
                              child: Center(
                                child: MaterialButton(
                                  onPressed: () {
                                    _navigateLawsuitNotAcceptCase(
                                        context,itemsCaseInformation[index], index);
                                  },
                                  splashColor: Color(0xff087de1),
                                  //highlightColor: Colors.blue,
                                  child: Center(
                                    child: Text("ไม่รับคดี",
                                      style: textStyleButtonNotAccept,),),
                                ),
                              )
                          )
                      ),
                    ],
                  )
                ],
              ),
            ],
            ),
          ),
        );
      },
    );
  }

  _navigateLawsuitNotAcceptCase(BuildContext context,ItemsLawsuitCaseInformation itemsInfor,index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LawsuitNotAcceptCaseMainScreenFragment(
        itemsCaseInformation: itemsInfor)),
    );
    if(result.toString()!="Back") {
      itemsCaseInformation = result;
      print("resut : " + result.toString());
    }
  }
  _navigateLawsuitAcceptCase(BuildContext context,ItemsLawsuitCaseInformation itemsInfor,index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LawsuitAcceptCaseMainScreenNonProofFragment(
        itemsCaseInformation: itemsInfor,
        IsEdit: false,
        IsPreview: false,
        itemsPreview: [],
      )),
    );
    if(result.toString()!="Back") {
      itemsCaseInformation = result;
      print("resut : " + result.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[200],
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
                        child: new Text('ILG60_B_02_00_01_00',
                          style: textStylePageName),
                      ),
                    ],
                  ),
                  ],
                )
            ),
            Expanded(
              child: _buildContent(context),
            ),
          ],
        ),
      ),
    );
  }
}