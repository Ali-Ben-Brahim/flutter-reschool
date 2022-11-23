class TableModel {
  List? id;

  TableModel(
      {this.id,
      });

  factory TableModel.fromJson(List json) {
 
    return TableModel(
      id: json,
     
    );
  }
}
