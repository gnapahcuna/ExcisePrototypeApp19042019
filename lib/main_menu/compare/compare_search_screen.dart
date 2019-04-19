import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_screen.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_%20suspect.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_%20suspect_detail.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_case_information.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_evidence.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_evidence_controller.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_main.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/lawsuit_accept_case_screen.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_sentence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_main.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_%20suspect.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_case_information.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_evidence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_offense.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_proof.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_search.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_2.dart';
import 'package:expandable/expandable.dart';
import 'package:prototype_app_pang/main_menu/prove/model/delivered_for_storage.dart';
import 'package:prototype_app_pang/main_menu/prove/model/evidence.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_case_information.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_check_evidence.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_evidence.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_main.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_screen.dart';

class CompareMainScreenFragmentSearch extends StatefulWidget {
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<CompareMainScreenFragmentSearch> {
  TextEditingController controller = new TextEditingController();
  List<ItemsCompareMain> _searchResult = [];
  List<ItemsCompareMain> _itemsInit = [
    new ItemsCompareMain(
      "น.1",
      "2561",
      "สุรา",
      "10 ตุลาคม 2561",
      "เวลา 11.00 น.",
      "นายเอกพัฒน์ สายสมุทร",
      "080700.4/1",
      new ItemsCompareCaseInformation(
          "TN90403056100047",
          "นายมิตรชัย เอกชัย",
          "09 ตุลาคม 2561",
          "เวลา 13.00 น.",
          "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
          "203",
          "มีไวในครอบครองซึ่งสินค้าที่มิได้เสียภาษี",
          "ระวางโทษปรับตั้งแต่สองเท่าถึงสิบเท่าของค่าภาษีที่จะต้องเสียหรือที่เสียไม่ครบถ้วน แต่ต้องไม่ต่ำกว่าสี่ร้อยบาท",
          "",
          "09 ตุลาคม 2561",
          "เวลา 13.00 น.",
          [
            new ItemsCompareSuspect(
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
                null,
                1200000,
                new ItemsCompareSuspectDetail(
                    false,
                    "09 ตุลาคม 2561",
                    "เวลา 13.00 น.",
                    "นายอนุชา นักผล",
                    "สน.โชคชัย4",
                    true,
                    false,
                    "09 พฤศจิกายน 2561",
                    "123",
                    "25563",
                    true,
                    false,
                    null,
                    null,
                    null
                ),
                true
            ),
            new ItemsCompareSuspect(
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
                null,
                5000,
                new ItemsCompareSuspectDetail(
                    false,
                    "09 ตุลาคม 2561",
                    "เวลา 13.00 น.",
                    "นายอนุชา นักผล",
                    "สน.โชคชัย4",
                    true,
                    false,
                    "09 พฤศจิกายน 2561",
                    "123",
                    "25563",
                    true,
                    false,
                    null,
                    null,
                    null
                ),
                true
            ),
          ],
          [
            new ItemsCompareEvidence(
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
                false,
                new ItemsCompareEvidenceTaxValue(
                  40000,
                  0,
                  0,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                )
            ),
            new ItemsCompareEvidence(
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
                false,
                new ItemsCompareEvidenceTaxValue(
                  40000,
                  0,
                  0,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                )
            )
          ],
          null
          ,
          false,
          false,
          "1",
          "2561",
          true
      ),
      true,
    ),
    new ItemsCompareMain(
      "น.2",
      "2561",
      "เบียร์",
      "10 ตุลาคม 2561",
      "เวลา 11.00 น.",
      "นายเอกพัฒน์ สายสมุทร",
      "080700.4/1",
      new ItemsCompareCaseInformation(
          "TN90403056100047",
          "นายมิตรชัย เอกชัย",
          "09 ตุลาคม 2561",
          "เวลา 13.00 น.",
          "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
          "203",
          "มีไวในครอบครองซึ่งสินค้าที่มิได้เสียภาษี",
          "ระวางโทษปรับตั้งแต่สองเท่าถึงสิบเท่าของค่าภาษีที่จะต้องเสียหรือที่เสียไม่ครบถ้วน แต่ต้องไม่ต่ำกว่าสี่ร้อยบาท",
          "",
          "09 ตุลาคม 2561",
          "เวลา 13.00 น.",
          [
            new ItemsCompareSuspect(
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
                null,
                500,
                new ItemsCompareSuspectDetail(
                    false,
                    "09 ตุลาคม 2561",
                    "เวลา 13.00 น.",
                    "นายอนุชา นักผล",
                    "สน.โชคชัย4",
                    true,
                    false,
                    "09 พฤศจิกายน 2561",
                    "123",
                    "25563",
                    true,
                    false,
                    null,
                    null,
                    null
                ),
                true
            ),
            new ItemsCompareSuspect(
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
                null,
                1000,
                new ItemsCompareSuspectDetail(
                    false,
                    "09 ตุลาคม 2561",
                    "เวลา 13.00 น.",
                    "นายอนุชา นักผล",
                    "สน.โชคชัย4",
                    true,
                    false,
                    "09 พฤศจิกายน 2561",
                    "123",
                    "25563",
                    true,
                    false,
                    null,
                    null,
                    null
                ),
                true
            ),
          ],
          [
            new ItemsCompareEvidence(
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
                false,
                new ItemsCompareEvidenceTaxValue(
                  40000,
                  0,
                  0,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                )
            ),
            new ItemsCompareEvidence(
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
                false,
                new ItemsCompareEvidenceTaxValue(
                  40000,
                  0,
                  0,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                )
            )
          ],
          null
          ,
          false,
          false,
          "1",
          "2561",
          true
      ),
      true,
    )
  ];

  @override
  void initState() {
    super.initState();
  }

  onSearchTextChanged(String text) async {
    print(text);
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    /*for(int i=0;i<_items.length;i++){
      if (_items[i].contains(text) ||
          _searchDetails[i].contains(text)) {
        _searchResult.add(_searchDetails[i]);
        _searchResult1.add(_searchDetails1[i]);
      }
    }*/
    _itemsInit.forEach((userDetail) {
      if (userDetail.Informations.CompareYear.contains(text) ||
          userDetail.Informations.CompareNumber.contains(text))
        _searchResult.add(userDetail);
    });
    setState(() {});
  }

  Widget _buildSearchResults() {
    Color labelColorPreview = Colors.white;
    Color labelColorEdit = Color(0xff087de1);
    TextStyle textPreviewStyle = TextStyle(
        fontSize: 16.0, color: labelColorPreview);
    TextStyle textEditStyle = TextStyle(fontSize: 16.0, color: labelColorEdit);

    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black);
    TextStyle textStyleDataSub = TextStyle(
        fontSize: 16, color: Colors.grey[400]);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
    return ListView.builder(
      itemCount: _searchResult.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
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
                    child: Text("เลขที่เปรียบเทียบคดี", style: textLabelStyle,),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      _searchResult[index].Number + '/' +
                          _searchResult[index].Year, style: textInputStyle,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text("ชื่อผู้ต้องหา", style: textLabelStyle,),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      _searchResult[index].Informations.Suspects[0].SuspectName,
                      style: textInputStyle,),
                  ),
                  _searchResult[index].Informations.Suspects.length > 1
                      ? Padding(
                      padding: paddingInputBox,
                      child: Row(
                        children: <Widget>[
                          Text(
                            _searchResult[index].Informations.Suspects[1]
                                .SuspectName,
                            style: textStyleDataSub,),
                          _searchResult[index].Informations.Suspects.length -
                              2 != 0
                              ?
                          Text(' ... และคนอื่นๆ ' +
                              (_searchResult[index].Informations.Suspects
                                  .length - 2)
                                  .toString(),
                            style: textStyleDataSub,)
                              : Container()
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
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: new Card(
                            color: labelColor,
                            shape: new RoundedRectangleBorder(
                                side: new BorderSide(
                                    color: labelColor, width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                            ),
                            elevation: 0.0,
                            child: Container(
                                width: 100.0,
                                //height: 40,
                                child: Center(
                                  child: MaterialButton(
                                    onPressed: () {
                                      //
                                      _navigate(
                                          context, _searchResult[index], false,
                                          true);
                                    },
                                    splashColor: labelColor,
                                    //highlightColor: Colors.blue,
                                    child: Center(
                                      child: Text(
                                        "เรียกดู", style: textPreviewStyle,),),
                                  ),
                                )
                            )
                        ),
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

  _navigate(BuildContext context, ItemsCompareMain itemMain, IsEdit,
      IsPreview) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          CompareMainScreenFragment(
            itemsCompareMain: itemMain,
            IsEdit: IsEdit,
            IsPreview: IsPreview,
          )),
    );
    if (result.toString() != "Back") {
      _searchResult = result;
      print("resut : " + result.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextSearch = TextStyle(fontSize: 16.0);
    var size = MediaQuery
        .of(context)
        .size;

    return new Theme(
      data: new ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.white,
          hintColor: Colors.grey[400]
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0), // here the desired height
          child: AppBar(
            title: new Padding(
              padding: EdgeInsets.only(right: 22.0),
              child: new TextField(
                style: styleTextSearch,
                controller: controller,
                decoration: new InputDecoration(
                  hintText: "ค้นหา",
                  hintStyle: styleTextSearch,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]),
                  ),
                ),
                onChanged: onSearchTextChanged,
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,), onPressed: () {
              Navigator.pop(context, "Back");
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
                      child: new Text('ILG60_B_04_00_02_00',
                        style: TextStyle(color: Colors.grey[400]),),
                    )
                  ],
                ),
              ),
              Expanded(
                child: _searchResult.length != 0 || controller.text.isNotEmpty
                    ? _buildSearchResults() : new Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
