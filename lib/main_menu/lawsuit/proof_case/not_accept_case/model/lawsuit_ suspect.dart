import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_sentence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_offense.dart';

class ItemsLawsuitSuspect {
  String SuspectName;
  String SuspectArrestType;
  String SuspectPersonType;
  String IdentifyNumber;
  String Address;
  List<ItemsLawsuitOffense> Offenses;
  ItemsLawsuitSentence Sentences;

  ItemsLawsuitSuspect(this.SuspectName,
      this.SuspectArrestType,
      this.SuspectPersonType,
      this.IdentifyNumber,
      this.Address,
      this.Offenses,
      this.Sentences);
}