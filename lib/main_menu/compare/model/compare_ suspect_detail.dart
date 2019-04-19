import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_sentence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_offense.dart';

class ItemsCompareSuspectDetail {
  bool IsRelease;
  String Date;
  String Time;
  String Person;
  String Place;
  bool IsRequested;
  bool IsNotRequested;
  String TaxDueDate;
  String BillNumber;
  String BillBookNo;
  bool IsCash;
  bool IsCredit;
  //IsRelease =true
  String FineDueDate;
  String Bail;
  String DepositBail;

  ItemsCompareSuspectDetail(
      this.IsRelease,
      this.Date,
      this.Time,
      this.Person,
      this.Place,
      this.IsRequested,
      this.IsNotRequested,
      this.TaxDueDate,
      this.BillNumber,
      this.BillBookNo,
      this.IsCash,
      this.IsCredit,
      this.FineDueDate,
      this.Bail,
      this.DepositBail
      );
}