import 'package:prototype_app_pang/main_menu/compare/model/compare_case_information.dart';
import 'package:prototype_app_pang/main_menu/prove/model/delivered_for_storage.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_case_information.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_check_evidence.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_evidence.dart';

class ItemsCheckEvidenceInformationDevivered {
  String Number;
  String DeliveredDate;
  String DeliveredTime;
  String ReturnDate;
  String PersonDelivered;
  String Position;
  String Department;
  String Comment;
  String Stock;
  bool IsActive;

  ItemsCheckEvidenceInformationDevivered(
      this.Number,
      this.DeliveredDate,
      this.DeliveredTime,
      this.ReturnDate,
      this.PersonDelivered,
      this.Position,
      this.Department,
      this.Comment,
      this.Stock,
      this.IsActive,
      );
}