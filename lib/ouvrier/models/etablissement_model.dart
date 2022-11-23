class EtabModel {
  List id;

  EtabModel(
      {required this.id,
      });

  factory EtabModel.fromJson(List json) {
 
    return EtabModel(
      id: json,
     
    );
  }
}
