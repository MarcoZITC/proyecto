class TareaModel {
  int? idTarea;
  String? nomTarea;
  String? fecExp;
  String? fecRec;
  String? desTarea;
  int? realizada;
  int? idProfe;

  TareaModel({this.idTarea,this.nomTarea,this.fecExp,this.fecRec,this.desTarea,this.realizada,this.idProfe});

  factory TareaModel.fromMap(Map<String, dynamic> map){
    return TareaModel(
      idTarea: map['idTarea'],
      nomTarea: map['nomTarea'],
      fecExp: map['fecExp'],
      fecRec: map['fecRec'],
      desTarea: map['desTarea'],
      realizada: map['realizada'],
      idProfe: map['idProfe']
    );
  }
}