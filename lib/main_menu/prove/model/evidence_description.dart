
import 'dart:io';

class ItemsEvidenceDescription {
  int TaxValue;

  int TaxVolumnBy;
  int TaxUnitValue;
  String TaxUnit;
  int TaxVolumnAlcohol;
  int TaxVolumnSugar;
  int TaxVolumnCo2;
  double TaxRetailPrice;
  double TaxProveValue;

  double RemainingCount;
  String RemainingCountsUnit;
  double RemainingVolumn;
  String RemainingVolumnUnit;
  String RemainingComment;

  String ProveDescription;
  String LabResult;

  List<File> ItemsImageFiles;

  ItemsEvidenceDescription(
      this.TaxValue,

      this.TaxVolumnBy,
      this.TaxUnitValue,
      this.TaxUnit,
      this.TaxVolumnAlcohol,
      this.TaxVolumnSugar,
      this.TaxVolumnCo2,
      this.TaxRetailPrice,
      this.TaxProveValue,

      this.RemainingCount,
      this.RemainingCountsUnit,
      this.RemainingVolumn,
      this.RemainingVolumnUnit,
      this.RemainingComment,

      this.ProveDescription,
      this.LabResult,

      this.ItemsImageFiles,
      );
}