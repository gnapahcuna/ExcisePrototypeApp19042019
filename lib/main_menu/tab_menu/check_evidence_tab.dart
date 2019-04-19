import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/check_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_detail_controller.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_infor.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_infor_delivered.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_main.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_screen.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_%20suspect.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_case_information.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_evidence.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_evidence_controller.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_main.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_offense.dart';
class CheckEvidenceFragment extends StatefulWidget {
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<CheckEvidenceFragment> {

  //style content
  TextStyle textStyleLanding = TextStyle(fontSize: 20);
  TextStyle textStyleLabel = TextStyle(fontSize: 16, color: Color(0xff087de1));
  TextStyle textStyleData = TextStyle(fontSize: 18, color: Colors.black);
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400]);
  TextStyle textStyleAdd = TextStyle(fontSize: 16.0, color: Colors.black);
  TextStyle textStyleDataSub = TextStyle(fontSize: 16);
  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
  TextStyle textStyleButtonAccept = TextStyle(
      fontSize: 16, color: Colors.white);
  TextStyle textStyleButtonNotAccept = TextStyle(
      fontSize: 16, color: Color(0xff087de1));

  //item data

  List<ItemsCheckEvidenceMain> itemMain = [
    new ItemsCheckEvidenceMain(
      "กค 0809.1",
      "2561",
      "10 ตุลาคม 2561",
      "เวลา 11.00 น.",
      "นายธนากร สุตโต",
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
                null,
                false
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
                null,
                false
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
          null,
          false,
          false,
          null,
          null,
          false
      ),
      null,
      new ItemsCheckEvidenceInformationChecked(
          "Auto Generate",
          "09 กันยายน 2561",
          "11.30",
          "นายนิรมิตร  เนตรนัย",
          "ส่วนกลาง",
          [
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
                false,
                new ItemsCheckEvidenceDetailController(
                    new ExpandableController(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    "ขวด",
                    "ลิตร",
                    ['ขวด','ลัง'],
                    ['ลิตร'])),
            new ItemsEvidence(
                "เบียร์",
                "สราแช่",
                "ชนิดเบียร์",
                "4.5",
                "ดีกรี",
                "hoegaarden",
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
                new ItemsCheckEvidenceDetailController(
                    new ExpandableController(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    "ขวด",
                    "ลิตร",
                    ['ขวด','ลัง'],
                    ['ลิตร']))
          ]
      ),
      1,
      false,
    ),
    new ItemsCheckEvidenceMain(
      "ตช 0809.1",
      "2561",
      "10 ตุลาคม 2561",
      "เวลา 11.00 น.",
      "สน.พญาไท",
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
                null,
                false
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
                null,
                false
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
          null,
          null,
          false
      ),
      new ItemsCheckEvidenceInformationDevivered(
          "กค. 1/2561",
          "09 กันยายน 2561",
          "13.00",
          "09 กันยายน 2561 เวลา 13.00 น.",
          "นายรณชัย โกมลไสย",
          "รองสารวัตร",
          "สน.หัวหมาก",
          "ฝากพิสูจน์",
          null,
          true),
      new ItemsCheckEvidenceInformationChecked(
          "Auto Generate",
          "09 กันยายน 2561",
          "11.30",
          "นายนิรมิตร  เนตรนัย",
          "ส่วนกลาง",
          [
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
                false,
                new ItemsCheckEvidenceDetailController(
                    new ExpandableController(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    "ขวด",
                    "ลิตร",
                    ['ขวด','ลัง'],
                    ['ลิตร'])),
            new ItemsEvidence(
                "เบียร์",
                "สราแช่",
                "ชนิดเบียร์",
                "4.5",
                "ดีกรี",
                "hoegaarden",
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
                new ItemsCheckEvidenceDetailController(
                    new ExpandableController(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    "ขวด",
                    "ลิตร",
                    ['ขวด','ลัง'],
                    ['ลิตร']))
          ]
      ),
      2,
      false,
    ),
    new ItemsCheckEvidenceMain(
      "กค 0809.2",
      "2561",
      "10 ตุลาคม 2561",
      "เวลา 11.00 น.",
      "นายพงพัทธิ์  ฤทธิวงศ์",
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
                null,
                false
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
                null,
                false
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
          null,
          null,
          false
      ),
      null,
      null,
      3,
      false,
    )
  ];

  Widget _buildContent(BuildContext context) {
    return ListView.builder(
      itemCount: itemMain.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        String person, textButton;
        if (itemMain[index].CheckEvidenceType == 1) {
          person = "ชื่อผู้ต้องหา";
          textButton = "ตรวจรับหน่วยงานภายใน";
        } else if (itemMain[index].CheckEvidenceType == 2) {
          person = "หน่วยงาน";
          textButton = "ตรวจรับหน่วยงานภายนอก";
        } else {
          person = "ชื่อผู้นำออก";
          textButton = "ตรวจรับจากการนำออก";
        }
        return itemMain[index].IsActive ? Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            //Text("ไม่มีรายการรับคดี", style: textStyleLanding,)
          ],
        )
            : Padding(
          padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
          child: Container(
            padding: EdgeInsets.only(
                left: 18.0, top: 18.0, bottom: 18.0, right: 8.0),
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
                    child: Text(itemMain[index].CheckEvidenceType == 3
                        ? "เลขที่หนังสือ"
                        : "เลขที่หนังสือนำส่ง", style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      itemMain[index].Number + "/" + itemMain[index].Year,
                      style: textStyleData,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text(person, style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      itemMain[index].Informations.Suspects[0].SuspectName,
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
                            width: 210.0,
                            child: Center(
                              child: MaterialButton(
                                onPressed: () {
                                  _navigate(
                                      context, itemMain[index], textButton);
                                },
                                splashColor: Color(0xff087de1),
                                //highlightColor: Colors.blue,
                                child: Center(
                                  child: Text(textButton,
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

  _navigate(BuildContext context, ItemsCheckEvidenceMain itemsMain,
      String title) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          CheckEvidenceMainScreenFragment(
            itemsCheckEvidenceMain: itemsMain,
            title: title,
            IsCreate: false,
            IsActive: false,
          )),
    );
    if (result.toString() != "Back") {
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
                        child: new Text('ILG60_B_05_00_01_00',
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
      bottomNavigationBar: Container(
        //padding: EdgeInsets.only(bottom: 22.0),
        height: 100.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: new Text('สร้างงานตรวจรับจากหน่วยงานภายนอก',
                  style: textStyleAdd),
            ),
            new IconButton(
              padding: new EdgeInsets.all(0.0),
              color: Colors.white,
              icon: new Icon(
                  Icons.add_circle, color: Color(0xff087de1),
                  size: 65.0),
              onPressed: () {
                Navigator.of(context)
                    .push(
                    new MaterialPageRoute(
                        builder: (context) =>
                            CheckEvidenceMainScreenFragment(
                              IsActive: false,
                              title: "ตรวจรับจากหน่วยงานภายนอก",
                              IsCreate: true,
                            )));
              },
            )
          ],
        ),
      ),
    );
  }
}