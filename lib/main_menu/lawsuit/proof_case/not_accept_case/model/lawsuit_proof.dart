import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_evidence.dart';

class ItemsLawsuitProof {
  String ProofNumber;
  String ProofNumber1;
  String ProofDate;
  String ProofTime;
  List<ItemsLawsuitEvidence> Evidences;

  ItemsLawsuitProof(
      this.ProofNumber,
      this.ProofNumber1,
      this.ProofDate,
      this.ProofTime,
      this.Evidences,
      );
}