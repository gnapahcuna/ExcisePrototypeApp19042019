import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_sentence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_%20suspect.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_case_information.dart';

class ItemsProveCheckEvidence {
  String Number;
  String Year;
  String Date;
  String Time;
  String Place;
  String Person;
  bool IsOutside;

  ItemsProveCheckEvidence(this.Number,
      this.Year,
      this.Date,
      this.Time,
      this.Place,
      this.Person,
      this.IsOutside,
      );
}