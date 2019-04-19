import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';

class ItemsCheckEvidenceDetailController {
  ExpandableController expController;
  FocusNode myFocusNodeDeliveredNumber;
  FocusNode myFocusNodeDefectiveNumber;
  FocusNode myFocusNodeDefectiveNumberUnit;
  FocusNode myFocusNodeDeliveredVolumn;
  FocusNode myFocusNodeDefectiveVolumn;
  FocusNode myFocusNodeDefectiveVolumnUnit;
  FocusNode myFocusNodeToalNumber;
  FocusNode myFocusNodeToaVolumn;
  FocusNode myFocusNodeToalNumberUnit;
  FocusNode myFocusNodeToaVolumnUnit;
  FocusNode myFocusNodeEvidenceComment;

  TextEditingController editDeliveredNumber;
  TextEditingController editDefectiveNumber;
  TextEditingController editDefectiveNumberUnit;
  TextEditingController editDeliveredVolumn;
  TextEditingController editDefectiveVolumn;
  TextEditingController editDefectiveVolumnUnit;
  TextEditingController editTotalNumber;
  TextEditingController editTotalVolumn;
  TextEditingController editTotalNumberUnit;
  TextEditingController editTotalVolumnUnit;
  TextEditingController editEvidenceComment;

  //dropdown ของกลาง
  String dropdownValueProductUnit;
  String dropdownValueVolumeUnit;
  List<String> dropdownItemsProductUnit;
  List<String> dropdownItemsVolumeUnit;

  ItemsCheckEvidenceDetailController(
      this.expController,

      this.myFocusNodeDeliveredNumber,
      this.myFocusNodeDefectiveNumber,
      this.myFocusNodeDefectiveNumberUnit,
      this.myFocusNodeDeliveredVolumn,
      this.myFocusNodeDefectiveVolumn,
      this.myFocusNodeDefectiveVolumnUnit,
      this.myFocusNodeToalNumber,
      this.myFocusNodeToaVolumn,
      this.myFocusNodeToalNumberUnit,
      this.myFocusNodeToaVolumnUnit,
      this.myFocusNodeEvidenceComment,

      this.editDeliveredNumber,
      this.editDefectiveNumber,
      this.editDefectiveNumberUnit,
      this.editDeliveredVolumn,
      this.editDefectiveVolumn,
      this.editDefectiveVolumnUnit,
      this.editTotalNumber,
      this.editTotalVolumn,
      this.editTotalNumberUnit,
      this.editTotalVolumnUnit,
      this.editEvidenceComment,

      this.dropdownValueProductUnit,
      this.dropdownValueVolumeUnit,
      this.dropdownItemsProductUnit,
      this.dropdownItemsVolumeUnit,
      );
}