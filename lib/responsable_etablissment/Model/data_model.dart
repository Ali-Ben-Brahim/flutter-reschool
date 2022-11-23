class DataModel {
  double? poucentagePlastique;
  double? poucentageCanette;
  double? poucentagePapier;
  double? poucentageComposte;
  double? poucentageTotalePlastique;
  double? poucentageTotaleCanette;
  double? poucentageTotalePapier;
  double? poucentageTotaleComposte;
  double? sommeQtePlastique;
  double? sommeQteCanette;
  double? sommeQteComposte;
  double? sommeQtePapier;
  double? qteTotale;

  DataModel({
     this.poucentagePlastique,
     this.poucentageCanette,
     this.poucentageComposte,
     this.poucentagePapier,
     this.poucentageTotaleCanette,
     this.poucentageTotaleComposte,
     this.poucentageTotalePapier,
     this.poucentageTotalePlastique,
     this.sommeQteCanette,
     this.sommeQteComposte,
     this.sommeQtePapier,
     this.sommeQtePlastique,
     this.qteTotale,

  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      poucentagePlastique: json['pourcentage_qt_poubelle_plastique'].toDouble() ?? 0,
      poucentageCanette: json['pourcentage_qt_poubelle_canette'].toDouble() ?? 0,
      poucentageComposte: json['pourcentage_qt_poubelle_composte'].toDouble() ?? 0,
      poucentagePapier: json['pourcentage_qt_poubelle_papier'].toDouble() ?? 0,
      sommeQtePlastique: json['somme_qt_dechet_plastique'].toDouble() ?? 0,
      sommeQteCanette: json['somme_qt_dechet_canette'].toDouble() ?? 0,
      sommeQteComposte: json['somme_qt_dechet_composte'].toDouble() ?? 0,
      sommeQtePapier: json['somme_qt_dechet_papier'].toDouble() ?? 0,
      poucentageTotaleCanette: json['pourcentage_canette'].toDouble() ?? 0,
      poucentageTotaleComposte: json['pourcentage_composte'].toDouble() ?? 0,
      poucentageTotalePapier: json['pourcentage_papier'].toDouble() ?? 0,
      poucentageTotalePlastique: json['pourcentage_plastique'].toDouble() ?? 0,
      qteTotale: json['somme_qt_dechet'].toDouble() ?? 0,
    );
  }
}
