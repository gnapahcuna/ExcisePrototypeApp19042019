import 'package:prototype_app_pang/main_menu/compare/model/compare_%20suspect_detail.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_sentence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_offense.dart';

class ItemsCompareSuspect {
  String SuspectName;
  String SuspectArrestType;
  String SuspectPersonType;
  String IdentifyNumber;
  String Address;
  List<ItemsLawsuitOffense> Offenses;
  ItemsLawsuitSentence Sentences;
  double FineValue;
  ItemsCompareSuspectDetail SuspectDetails;
  bool IsActive;

  ItemsCompareSuspect(this.SuspectName,
      this.SuspectArrestType,
      this.SuspectPersonType,
      this.IdentifyNumber,
      this.Address,
      this.Offenses,
      this.Sentences,
      this.FineValue,
      this.SuspectDetails,
      this.IsActive,
      );
}