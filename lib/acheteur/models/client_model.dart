class ResponsablePersonnelModel {
  int? id;
  String? nom;
  String? prenom;
  String? CIN;
  String? numero_telephone;
  String? email;
  String? photo;


  ResponsablePersonnelModel({this.id, this.nom, this.prenom, this.CIN,this.numero_telephone, this.email, this.photo});

  ResponsablePersonnelModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'].toString();
    prenom = json['prenom'].toString();
    CIN = json['CIN'].toString();
    email = json['email'].toString();
    numero_telephone = json['numero_telephone'].toString();
    photo = json['photo'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nom'] = nom;
    data['prenom'] = prenom;
    data['CIN'] = CIN;
    data['numero_telephone'] = numero_telephone;
    data['email'] = email;
    data['photo'] = photo;
    return data;
  }
}