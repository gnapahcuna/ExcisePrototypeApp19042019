
import 'package:flutter/cupertino.dart';

class ItemsListArrest5Controller {
  TextEditingController editProductUnit;
  TextEditingController editVolumeUnit;
  FocusNode myFocusNodeProductUnit;
  FocusNode myFocusNodeVolumeUnit;
  List<String> dropdownItemsProductUnit;
  List<String> dropdownItemsVolumeUnit;
  String dropdownValueProductUnit;
  String dropdownValueVolumeUnit;
  ItemsListArrest5Controller(
      this.editProductUnit,
      this.editVolumeUnit,
      this.myFocusNodeProductUnit,
      this.myFocusNodeVolumeUnit,
      this.dropdownItemsProductUnit,
      this.dropdownItemsVolumeUnit,
      this.dropdownValueProductUnit,
      this.dropdownValueVolumeUnit,
      );
}