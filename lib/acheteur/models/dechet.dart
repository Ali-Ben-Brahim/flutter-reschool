class Dechet {
  int? id;
  String? typeDechet;
  double? prixUnitaire;
  String? quantites;
  String? prix_dechet;
  Dechet(
      {this.id,
      this.typeDechet,
      this.prixUnitaire,
      });

  Dechet.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    typeDechet = json['type_dechet'];
    prixUnitaire = json['prix_unitaire'];
  }

    
}