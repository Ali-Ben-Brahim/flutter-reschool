class TrieModel {
List triee;


  TrieModel({
   required  this.triee,
    
  });

  factory TrieModel.fromJson(Map<String, dynamic> json) {
    return TrieModel(
      triee: json['poubelle_triee'],
      
    );
  }
}
