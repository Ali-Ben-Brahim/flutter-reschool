

class AchatModel{


  String? id;
  String? type_dechet;
  String? prix_unitaire;
  String? photo;

  AchatModel({this.id, this.type_dechet, this.prix_unitaire, this.photo});
  

    AchatModel.fromJson( Map<String , dynamic> res){
      id = res['id'].toString();
      type_dechet = res['type_dechet'].toString();
      prix_unitaire = res['prix_unitaire'].toString();
      photo = res['photo'].toString();

    }
  }