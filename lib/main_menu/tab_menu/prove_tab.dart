import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_%20suspect.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_case_information.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_evidence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_offense.dart';
import 'package:prototype_app_pang/main_menu/prove/model/evidence.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_case_information.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_main.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_screen.dart';

class ProveFragment extends StatefulWidget {
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<ProveFragment>  {

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

  List<ItemsProveMain> itemMain = [
    new ItemsProveMain(
      "1",
      "2561",
      "สุรา",
      "10 ตุลาคม 2561",
      "เวลา 11.00 น.",
      "นายเอกพัฒน์ สายสมุทร",
      "080700.4/1",
      new ItemsProveCaseInformation(
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
            new ItemsEvidence(
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
                false,
                null,
              false
            ),
            new ItemsEvidence(
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
                false,
                null,
                false
            )
          ],
          null
          ,false,
          false
      ),
      null,
      null,
      null,
      false,
    ),
    new ItemsProveMain(
      "2",
      "2561",
      "เบียร์",
      "10 ตุลาคม 2561",
      "เวลา 11.00 น.",
      "นายเอกพัฒน์ สายสมุทร",
      "080700.4/1",
      new ItemsProveCaseInformation(
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
            new ItemsEvidence(
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
                false,
              null,
                false
            ),
            new ItemsEvidence(
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
                false,
              null,
                false
            )
          ],
          null
          ,false,
          false
      ),
      null,
      null,
      null,
      false,
    )
  ];

  Widget _buildContent(BuildContext context) {
    return ListView.builder(
      itemCount: itemMain.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return itemMain[index].IsActive ? Column(
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
                    child: Text("เลขที่รับคำกล่าวโทษ", style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      itemMain[index].Number+"/"+itemMain[index].Year,
                      style: textStyleData,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text("ประเภทของกลาง", style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      itemMain[index].EvidenceType,
                      style: textStyleData,),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                                  _navigate(
                                      context,itemMain[index], index);
                                },
                                splashColor: Color(0xff087de1),
                                //highlightColor: Colors.blue,
                                child: Center(
                                  child: Text("พิสูจน์",
                                    style: textStyleButtonAccept,),),
                              ),
                            )
                        )
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

  _navigate(BuildContext context,ItemsProveMain itemsProve,index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProveMainScreenFragment(
        itemsProveMain: itemsProve,
        IsEdit: false,
        IsPreview: false,
      )),
    );
    if(result.toString()!="Back") {
      itemMain = result;
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
                        child: new Text('ILG60_B_03_00_01_00',
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