
import 'package:prototype_app_pang/main_menu/compare/model/compare_evidence_controller.dart';
import 'package:prototype_app_pang/main_menu/prove/model/evidence_description.dart';

class ItemsCompareEvidence {
  String ProductGroup;
  String ProductCategory;
  String ProductType;
  String SubProductType;
  String SubSetProductType;
  String MainBrand;

  String SecondaryBrand;
  String ProductModel;
  int Capacity;
  String ProductUnit;
  int Counts;
  String CountsUnit;
  int Volume;
  String VolumeUnit;
  bool IsCkecked;
  ItemsEvidenceDescription Descriptions;
  bool IsActive;

  //มูลค่าภาษี
  ItemsCompareEvidenceTaxValue EvidenceTaxValues;

  ItemsCompareEvidence(this.ProductGroup,
      this.ProductCategory,
      this.ProductType,
      this.SubProductType,
      this.SubSetProductType,
      this.MainBrand,
      this.SecondaryBrand,
      this.ProductModel,
      this.Capacity,
      this.ProductUnit,
      this.Counts,
      this.CountsUnit,
      this.Volume,
      this.VolumeUnit,
      this.IsCkecked,
      this.Descriptions,
      this.IsActive,
      this.EvidenceTaxValues
      );
}