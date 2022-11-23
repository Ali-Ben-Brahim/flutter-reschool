class ResponsableModel {
  int? id;
  String? nom;
  String? prenom;
  String? CIN;
  String? photo;
  String? numero_telephone;

  String? email;

  ResponsableModel({this.id, this.nom, this.prenom, this.CIN, this.photo,this.numero_telephone, this.email});

  ResponsableModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'].toString();
    prenom = json['prenom'].toString();
    CIN = json['CIN'].toString();
    nom = json['nom'].toString();
    numero_telephone = json['numero_telephone'].toString();
    email = json['email'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nom'] = nom;
    data['prenom'] = prenom;
    data['CIN'] = CIN;
    data['photo'] = photo;
    data['numero_telephone'] = numero_telephone;
    data['email'] = email;
    return data;
  }
}