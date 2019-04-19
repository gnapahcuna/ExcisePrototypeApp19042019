import 'package:prototype_app_pang/main_menu/compare/model/compare_%20suspect.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_%20suspect_detail.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_evidence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_proof.dart';

class ItemsCompareCaseInformation {
  String ArrestNumber;
  String ArrestPersonName;
  String ArrestDate;
  String ArrestTime;
  String ArrestLocation;
  String MistakeNumber;
  String MistakeDetail;
  String PenaltyRate;
  String ArrestPlace;
  List<ItemsCompareSuspect> Suspects;
  List<ItemsCompareEvidence> Evidenses;
  ItemsLawsuitProof Proof;
  bool IsActive=false;
  bool IsProof=false;
  String CompareNumber;
  String CompareYear;
  bool IsCompare;
  String ProveDate;
  String ProveTime;

  ItemsCompareCaseInformation(
      this.ArrestNumber,
      this.ArrestPersonName,
      this.ArrestDate,
      this.ArrestTime,
      this.ArrestLocation,
      this.MistakeNumber,
      this.MistakeDetail,
      this.PenaltyRate,
      this.ArrestPlace,
      this.ProveDate,
      this.ProveTime,
      this.Suspects,
      this.Evidenses,
      this.Proof,
      this.IsActive,
      this.IsProof,
      this.CompareNumber,
      this.CompareYear,
      this.IsCompare
      );
}