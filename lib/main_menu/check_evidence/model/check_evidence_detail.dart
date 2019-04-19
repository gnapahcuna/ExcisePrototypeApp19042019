import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_detail_controller.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_case_information.dart';
import 'package:prototype_app_pang/main_menu/prove/model/delivered_for_storage.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_case_information.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_check_evidence.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_evidence.dart';

class ItemsCheckEvidenceDetail {
  String Number;
  String Name;
  String DeliveredNumber;
  String DeliveredVolumn;
  String DefectiveNumber;
  String TotalNumber;
  String DefectiveNumberUnit;
  String DefectiveVolumn;
  String TotalVolumn;
  String DefectiveVolumnUnit;
  String Comment;

  ItemsCheckEvidenceDetail(
      this.Number,
      this.Name,
      this.DeliveredNumber,
      this.DeliveredVolumn,
      this.DefectiveNumber,
      this.TotalNumber,
      this.DefectiveNumberUnit,
      this.DefectiveVolumn,
      this.TotalVolumn,
      this.DefectiveVolumnUnit,
      this.Comment,
      );
}