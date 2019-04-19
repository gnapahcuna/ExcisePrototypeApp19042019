import 'package:prototype_app_pang/main_menu/prove/model/evidence.dart';

class ItemsProveEvidence {
  String Date;
  String Time;
  String Command;
  String Person;
  bool IsScientific;
  String LabNumber;
  String LabYear;
  String PetitionNumber;
  String ReportNumber;

  List<ItemsEvidence> Evidences;

  ItemsProveEvidence(
      this.Date,
      this.Time,
      this.Command,
      this.Person,
      this.IsScientific,
      this.LabNumber,
      this.LabYear,
      this.PetitionNumber,
      this.ReportNumber,
      this.Evidences,
      );
}