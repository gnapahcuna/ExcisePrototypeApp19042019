import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_%20suspect.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_proof.dart';
import 'package:prototype_app_pang/main_menu/prove/model/evidence.dart';

class ItemsProveCaseInformation {
  String ArrestNumber;
  String ArrestPersonName;
  String ArrestDate;
  String ArrestTime;
  String ArrestLocation;
  String MistakeNumber;
  String MistakeDetail;
  String ArrestPlace;
  List<ItemsLawsuitSuspect> Suspects;
  List<ItemsEvidence> Evidenses;
  ItemsLawsuitProof Proof;
  bool IsActive=false;
  bool IsProof=false;

  ItemsProveCaseInformation(
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