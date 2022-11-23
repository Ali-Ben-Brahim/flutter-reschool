class UserModel {
  int? id;
  String? nom_entreprise;
  String? matricule_fiscale;
  String? nom_responsable;
  String? numero_fixe;
  String? adresse;
  String? numero_telephone;
  String? email;
  String? photo;
  String? camion_id;

  UserModel({this.id, this.camion_id, this.nom_entreprise, this.matricule_fiscale, this.nom_responsable, this.adresse,this.numero_telephone, this.email, this.numero_fixe, this.photo});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom_entreprise = json['nom_entreprise'].toString();
    matricule_fiscale = json['matricule_fiscale'].toString();
    nom_responsable = json['nom_responsable'].toString();
    numero_fixe = json['numero_fixe'].toString();
    adresse = json['adresse'].toString();
    numero_telephone = json['numero_telephone'].toString();
    email = json['email'].toString();
    photo = json['photo'].toString();
    camion_id = json['camion_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nom_entreprise'] = nom_entreprise;
    data['matricule_fiscale'] = matricule_fiscale;
    data['nom_responsable'] = nom_responsable;
    data['numero_fixe'] = numero_fixe;
    data['adresse'] = adresse;
    data['numero_telephone'] = numero_telephone;
    data['email'] = email;
    return data;
  }
}