class EtablissementModel {

  final String nomEtablissement;
   final int nbrPoubellePlastique;
   final int nbrPoubellePapier;
   final int nbrPoubelleCanette;
   final int nbrPoubelleComposte;

  EtablissementModel({
   required this.nomEtablissement,
   required this.nbrPoubelleCanette,
   required this.nbrPoubelleComposte,
   required this.nbrPoubellePapier,
   required this.nbrPoubellePlastique,

   });

  factory EtablissementModel.fromJson(Map<String, dynamic> json) {
    return EtablissementModel(
      nomEtablissement: json['nom_etablissement']?? "No name",
      nbrPoubelleCanette: json['poubelle_canette']?? 0,
      nbrPoubelleComposte:json['poubelle_composte']?? 0 ,
      nbrPoubellePapier:json['poubelle_papier']?? 0 ,
      nbrPoubellePlastique: json['poubelle_plastique']?? 0,
   
    );
  }
}