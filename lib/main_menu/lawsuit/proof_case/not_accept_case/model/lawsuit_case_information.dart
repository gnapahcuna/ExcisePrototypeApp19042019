import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_%20suspect.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_evidence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_proof.dart';

class ItemsLawsuitCaseInformation {
  String ArrestNumber;
  String ArrestPersonName;
  String ArrestDate;
  String ArrestTime;
  String ArrestLocation;
  String MistakeNumber;
  String MistakeDetail;
  String ArrestPlace;
  List<ItemsLawsuitSuspect> Suspects;
  List<ItemsLawsuitEvidence> Evidenses;
  ItemsLawsuitProof Proof;
  bool IsActive=false;
  bool IsProof=false;

  ItemsLawsuitCaseInformation(
      this.ArrestNumber,
      this.ArrestPersonName,
      this.ArrestDate,
      this.ArrestTime,
      this.ArrestLocation,
      this.MistakeNumber,
      this.MistakeDetail,
      this.ArrestPlace,
      this.Suspects,
      this.Evidenses,
      this.Proof,
      this.IsActive,
      this.IsProof,
      );
}