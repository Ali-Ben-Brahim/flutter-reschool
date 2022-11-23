class CollectModel {
  double quantiteTotalCollectePlastique;
  double quantiteTotalCollecteComposte;
  double quantiteTotalCollecteCanette;
  double quantiteTotalCollectePapier;


  CollectModel({
   required  this.quantiteTotalCollectePlastique,
 required    this.quantiteTotalCollecteComposte,
   required  this.quantiteTotalCollecteCanette,
  required   this.quantiteTotalCollectePapier,


  });

  factory CollectModel.fromJson(Map<String, dynamic> json) {
    return CollectModel(
      quantiteTotalCollectePlastique: json['quantite_total_collecte_plastique'].toDouble() ?? 0,
      quantiteTotalCollecteComposte: json['quantite_total_collecte_composte'].toDouble() ?? 0,
      quantiteTotalCollectePapier: json['quantite_total_collecte_papier'].toDouble() ?? 0,
      quantiteTotalCollecteCanette: json['quantite_total_collecte_canette'].toDouble() ?? 0,
 
    );
  }
}
