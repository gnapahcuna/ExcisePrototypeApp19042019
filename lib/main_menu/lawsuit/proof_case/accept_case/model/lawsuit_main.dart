import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_sentence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_%20suspect.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_case_information.dart';

class ItemsLawsuitMainAcceptCase {
  String LawsuitNumber;
  String LawsuitYear;
  String LawsuitDate;
  String LawsuitTime;
  String LawsuitPersonName;
  ItemsLawsuitCaseInformation Informations;
  String LawsuitPlace;
  String LawsuitTestimony;
  String LawsuitCompare;
  bool IsCompare;
  //กรณี
  //bool IsProof;

  ItemsLawsuitMainAcceptCase(
      this.LawsuitNumber,
      this.LawsuitYear,
      this.LawsuitDate,
      this.LawsuitTime,
      this.LawsuitPersonName,
      this.Informations,
      this.LawsuitPlace,
      this.LawsuitTestimony,
      this.LawsuitCompare,
      this.IsCompare,
      //this.IsProof,
      );
}