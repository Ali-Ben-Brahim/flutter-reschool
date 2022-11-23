class User {
  int? id;
  String? nom;
  String? prenom;
  String? email;
  String? cin;
  String? zoneTravailId;
  String? camionId;
  String? poste;
  String? numeroTelephone;
  String? adresse;
  String? token;
  String? photo;
  User(
      {this.id,
      this.nom,
      this.cin,
      this.zoneTravailId,
      this.camionId,
      this.poste,
      this.email,
      this.numeroTelephone,
      this.adresse,
      this.token,
      this.photo});

  User.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    zoneTravailId = json['zone_travail_id'].toString();
    camionId = json['camion_id'].toString();
    nom = json['nom'].toString();
    prenom = json['prenom'].toString();
    email = json['email'].toString();
    cin = json['CIN'].toString();
    poste = json['poste'].toString();
    numeroTelephone = json['numero_telephone'].toString();
    adresse = json['adresse'].toString();
    photo = json['photo'].toString();
  }

  Map<String, dynamic> toJson() {
  	final Map<String, dynamic> data = <String, dynamic>{};
  	data['id'] = id;
    data['camionId'] = camionId ;
    data['zoneTravailId'] = zoneTravailId ;
    data['nom'] = nom ;
    data['prenom'] = prenom ;
    data['email'] = email ;
    data['cin'] = cin ;
    data['poste'] = poste ;
  	data['numeroTelephone'] = numeroTelephone;
  	data['adresse'] = adresse;
  	return data;
  }
}
