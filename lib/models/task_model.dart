class TaskModel{
  
  int? idTask;
  String? nameTask;
  String? dscTask;
  bool? sttTask;
  
  TaskModel({this.idTask, this.nameTask, this.dscTask, this.sttTask});
//parametros nombrados se colocan en cualquier posición y funciona correctamente, no importa su posición funciona bien donde se manden llamar
  
  factory TaskModel.fromMap(Map<String, dynamic> map){
    return TaskModel(
      idTask: map['idTask'],
      dscTask: map['dscTask'],
      nameTask: map['nameTask'],
      sttTask: map['sttTask']
    );
  }
//Aveces necesitamos hacer sobre carga de constructores, para ello flutter hace uso de constructores nombrados factory
//Es como darle un alias al constructor

}