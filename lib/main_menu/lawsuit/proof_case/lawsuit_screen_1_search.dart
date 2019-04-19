import 'package:flutter/material.dart';
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

class LawsuitMainScreenFragmentSearch extends StatefulWidget {
  @override
  _LawsuitMainScreenFragmentSearchSearchState createState() => new _LawsuitMainScreenFragmentSearchSearchState();
}
class _LawsuitMainScreenFragmentSearchSearchState extends State<LawsuitMainScreenFragmentSearch> {
  TextEditingController controller = new TextEditingController();
  List<ItemsLawsuitMainAcceptCase> _searchResult = [];
  List<ItemsLawsuitMainAcceptCase> _itemsInit = [
    new ItemsLawsuitMainAcceptCase(
        "1",
        "2561",
        "26 มีนาคม 2562",
        "16:42 น.",
        "นายวสันต์ ศรีอ้วน",
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
              new ItemsLawsuitSuspect(
                  "นายอนุชา นักเมือง",
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
            null,
            false,
          false
        ),
        "สน.วังทองหลาง",
        "วันนี้ เวลา 08:40 น. ข้าพเจ้าพร้อมด้วยพวกได้ดำเนินการจับกุม 1.นายเสนาะ อุตโม  2.นางวิไล เมืองใจ พร้อมของกลาง ตามบัญชีของกลาง ส.ส.2/4 โดยแจ้งข้อกล่าวหามีไว้เพื่อขายซึ่งสินค้าที่มิได้เสียภาษี ให้ทราบ และ นำตัวผู้ต้องหาพร้อมของกลางส่งพนักงานสอบสวน เพื่อดำเนินคดี แต่ผู้ต้องหายินยอมชำระค่าปรับ ในความผิดที่ถูกกล่าวหา จึงได้นำตัวส่ง ส่วนคดี สำนักกฎหมาย เพื่อดำเนินการต่อไป",
        "เปรียบเทียบปรับ",
      true
    ),
    new ItemsLawsuitMainAcceptCase(
        "4",
        "2561",
        "26 มีนาคม 2562",
        "16:42 น.",
        "นายวสันต์ ศรีอ้วน",
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
                  new ItemsLawsuitSentence(
                      "001/2561",
                      "001/2561",
                      "ศาลนนทบุรี",
                      "09 กันยายน 2561",
                      104000,
                      "สลึง",
                      "09 กันยายน 2561",
                      true,
                      false,
                      null,
                      null,
                      4,
                    "วัน",
                    true,
                    true,
                    false
                  )
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
            null,
            false,
          false
        ),
        "สน.ลาดพร้าว",
        "วันนี้ เวลา 08:40 น. ข้าพเจ้าพร้อมด้วยพวกได้ดำเนินการจับกุม 1.นายเสนาะ อุตโม  2.นางวิไล เมืองใจ พร้อมของกลาง ตามบัญชีของกลาง ส.ส.2/4 โดยแจ้งข้อกล่าวหามีไว้เพื่อขายซึ่งสินค้าที่มิได้เสียภาษี ให้ทราบ และ นำตัวผู้ต้องหาพร้อมของกลางส่งพนักงานสอบสวน เพื่อดำเนินคดี แต่ผู้ต้องหายินยอมชำระค่าปรับ ในความผิดที่ถูกกล่าวหา จึงได้นำตัวส่ง ส่วนคดี สำนักกฎหมาย เพื่อดำเนินการต่อไป",
        "",
        false),
    new ItemsLawsuitMainAcceptCase(
        "10",
        "2561",
        "26 มีนาคม 2562",
        "16:42 น.",
        "นายวสันต์ ศรีอ้วน",
        new ItemsLawsuitCaseInformation(
            "TN90403056100050",
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
              new ItemsLawsuitSuspect(
                  "นายอนุชา นักเมือง",
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
            new ItemsLawsuitProof(
                "080700.4",
                "1",
                "10 ตุลาคม 2561",
                "เวลา 11.00 น",
                [
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
                      false),
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
                ])
            ,false,
            true
        ),
        "สน.วังทองหลาง",
        "วันนี้ เวลา 08:40 น. ข้าพเจ้าพร้อมด้วยพวกได้ดำเนินการจับกุม 1.นายเสนาะ อุตโม  2.นางวิไล เมืองใจ พร้อมของกลาง ตามบัญชีของกลาง ส.ส.2/4 โดยแจ้งข้อกล่าวหามีไว้เพื่อขายซึ่งสินค้าที่มิได้เสียภาษี ให้ทราบ และ นำตัวผู้ต้องหาพร้อมของกลางส่งพนักงานสอบสวน เพื่อดำเนินคดี แต่ผู้ต้องหายินยอมชำระค่าปรับ ในความผิดที่ถูกกล่าวหา จึงได้นำตัวส่ง ส่วนคดี สำนักกฎหมาย เพื่อดำเนินการต่อไป",
        "เปรียบเทียบปรับ",
        true
    ),
    new ItemsLawsuitMainAcceptCase(
        "12",
        "2561",
        "26 มีนาคม 2562",
        "16:42 น.",
        "นายวสันต์ ศรีอ้วน",
        new ItemsLawsuitCaseInformation(
            "TN90403056100051",
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
                  new ItemsLawsuitSentence(
                      "001/2561",
                      "001/2561",
                      "ศาลนนทบุรี",
                      "09 กันยายน 2561",
                      104000,
                      "สลึง",
                      "09 กันยายน 2561",
                      true,
                      false,
                      null,
                      null,
                      4,
                      "วัน",
                      true,
                      true,
                      false
                  )
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
            null,
            false,
            false
        ),
        "สน.ลาดพร้าว",
        "วันนี้ เวลา 08:40 น. ข้าพเจ้าพร้อมด้วยพวกได้ดำเนินการจับกุม 1.นายเสนาะ อุตโม  2.นางวิไล เมืองใจ พร้อมของกลาง ตามบัญชีของกลาง ส.ส.2/4 โดยแจ้งข้อกล่าวหามีไว้เพื่อขายซึ่งสินค้าที่มิได้เสียภาษี ให้ทราบ และ นำตัวผู้ต้องหาพร้อมของกลางส่งพนักงานสอบสวน เพื่อดำเนินคดี แต่ผู้ต้องหายินยอมชำระค่าปรับ ในความผิดที่ถูกกล่าวหา จึงได้นำตัวส่ง ส่วนคดี สำนักกฎหมาย เพื่อดำเนินการต่อไป",
        "",
        false),
  ];
  int _countItem = 0;
  List<ItemsListArrestSearch> _itemsData = [];

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
      if (userDetail.LawsuitNumber.contains(text) ||
          userDetail.LawsuitYear.contains(text))
        _searchResult.add(userDetail);
    });
    setState(() {});
  }
  Widget _buildSearchResults() {
    Color labelColorPreview = Colors.white;
    Color labelColorEdit= Color(0xff087de1);
    TextStyle textPreviewStyle = TextStyle(fontSize: 16.0, color: labelColorPreview);
    TextStyle textEditStyle = TextStyle(fontSize: 16.0, color: labelColorEdit);

    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black);
    TextStyle textStyleDataSub = TextStyle(fontSize: 16,color: Colors.grey[400]);
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
                    child: Text("เลขที่รับคำกล่าวโทษ", style: textLabelStyle,),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      _searchResult[index].LawsuitNumber+'/'+_searchResult[index].LawsuitYear, style: textInputStyle,),
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
                  _searchResult[index].Informations.Suspects.length > 1 ? Padding(
                      padding: paddingInputBox,
                      child: Row(
                        children: <Widget>[
                          Text(
                            _searchResult[index].Informations.Suspects[1].SuspectName,
                            style: textStyleDataSub,),
                          _searchResult[index].Informations.Suspects.length-2!=0?
                          Text(' ... และคนอื่นๆ '+(_searchResult[index].Informations.Suspects.length-2).toString(),
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
                            color:labelColor,
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
                                      _navigateLawsuitAcceptCase(context,_searchResult[index],_searchResult[index].Informations,index,false,true);
                                    },
                                    splashColor: labelColor,
                                    //highlightColor: Colors.blue,
                                    child: Center(
                                      child: Text("เรียกดู", style: textPreviewStyle,),),
                                  ),
                                )
                            )
                        ),
                      ),
                      _searchResult[index].IsCompare?new Card(
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
                                  _navigateLawsuitAcceptCase(context,_searchResult[index],_searchResult[index].Informations,index,true,false);
                                },
                                splashColor: labelColor,
                                //highlightColor: Colors.blue,
                                child: Center(
                                  child: Text("แก้ไข", style: textEditStyle,),),
                              ),
                            )
                          )
                      ):Container(),
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

  _navigateLawsuitAcceptCase(BuildContext context,ItemsLawsuitMainAcceptCase itemMain,ItemsLawsuitCaseInformation itemInfor,index,IsEdit,IsPreview) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LawsuitAcceptCaseMainScreenNonProofFragment(
        itemsLawsuitMainAcceptCase: itemMain,
        itemsCaseInformation: itemInfor,
        IsEdit: IsEdit,
        IsPreview: IsPreview,
        itemsPreview: [],
      )),
    );
    if(result.toString()!="Back") {
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
              Navigator.pop(context,_itemsData);
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
                      child: new Text('ILG60_B_02_00_02_00',
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
