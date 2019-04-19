import 'package:prototype_app_pang/main_menu/prove/model/delivered_for_storage.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_case_information.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_check_evidence.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_evidence.dart';

class ItemsProveMain {
  String Number;
  String Year;
  String EvidenceType;
  String LawsuitDate;
  String LawsuitTime;
  String LawsuitPersonName;
  String BookNumber;
  ItemsProveCaseInformation Informations;
  ItemsProveCheckEvidence CheckEvidence;
  ItemsProveEvidence ProveEvidence;
  DeliveredForStorage Delivered;
  bool IsActive;

  ItemsProveMain(
      this.Number,
      this.Year,
      this.EvidenceType,
      this.LawsuitDate,
      this.LawsuitTime,
      this.LawsuitPersonName,
      this.BookNumber,
      this.Informations,
      this.CheckEvidence,
      this.ProveEvidence,
      this.Delivered,
      this.IsActive,
      );
}