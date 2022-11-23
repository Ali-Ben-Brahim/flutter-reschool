import 'dart:convert';

GenderModel genderModelFromJson(Map<String, dynamic> str) => GenderModel.fromJson(str);

String genderModelToJson(GenderModel data) => json.encode(data.toJson());

class GenderModel {
    GenderModel({
        required this.Plastique,
        required this.Papier,
        required this.Composte,
        required this.Canette,
    });

    double Plastique;
    double Papier;
    double Composte;
    double Canette;

    factory GenderModel.fromJson(Map<String, dynamic> json) => GenderModel(
        Plastique: json["somme_depot_actuelle_plastique"].toDouble(),
        Papier: json["somme_depot_actuelle_papier"].toDouble(),
        Composte: json["somme_depot_actuelle_composte"].toDouble(),
        Canette: json["somme_depot_actuelle_canette"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "somme_depot_actuelle_plastique": Plastique,
        "somme_depot_actuelle_papier": Papier,
        "somme_depot_actuelle_composte": Composte,
        "somme_depot_actuelle_canette": Canette,
    };
}
