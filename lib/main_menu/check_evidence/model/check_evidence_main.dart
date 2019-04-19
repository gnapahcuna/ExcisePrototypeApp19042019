import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_infor.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_infor_delivered.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_case_information.dart';

class ItemsCheckEvidenceMain {
  String Number;
  String Year;
  String LawsuitDate;
  String LawsuitTime;
  String PersonName;
  ItemsCompareCaseInformation Informations;
  ItemsCheckEvidenceInformationDevivered InforDelivered;
  ItemsCheckEvidenceInformationChecked InforChecked;
  int CheckEvidenceType;
  bool IsActive;

  ItemsCheckEvidenceMain(
      this.Number,
      this.Year,
      this.LawsuitDate,
      this.LawsuitTime,
      this.PersonName,
      this.Informations,
      this.InforDelivered,
      this.InforChecked,
      this.CheckEvidenceType,
      this.IsActive,
      );
}