import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_detail.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_case_information.dart';
import 'package:prototype_app_pang/main_menu/prove/model/delivered_for_storage.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_case_information.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_check_evidence.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_evidence.dart';

class ItemsCheckEvidenceInformationChecked{
  String Number;
  String ReturnDate;
  String ReturnTime;
  String Person;
  String Stock;
  List<ItemsEvidence> Evidences;

  ItemsCheckEvidenceInformationChecked(
      this.Number,
      this.ReturnDate,
      this.ReturnTime,
      this.Person,
      this.Stock,
      this.Evidences
      );
}