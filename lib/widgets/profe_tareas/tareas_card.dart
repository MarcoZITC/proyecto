import 'package:flutter/material.dart';
import 'package:practica_1/assets/styles/global_values.dart';
import 'package:practica_1/database/tareas_profesor.dart';
import 'package:practica_1/models/profe_model.dart';
import 'package:practica_1/models/tarea_model.dart';
import 'package:practica_1/widgets/buttons.dart';
import 'package:practica_1/widgets/profe_tareas/add_tareas.dart';

// ignore: must_be_immutable
class TareasCard extends StatefulWidget {
  TareasCard({super.key, required this.tareaModel, this.tareasProfeBD});

  TareaModel tareaModel;
  TareaProfesor? tareasProfeBD;

  @override
  State<TareasCard> createState() => _TareasCardState();
}

class _TareasCardState extends State<TareasCard> {

  TareaProfesor? tareaProfeBD;
  bool stateCheck = false;

  @override
  void initState() {
    super.initState();    
    tareaProfeBD = TareaProfesor();
    obtenerCarreraData();
  }

  Map<int, dynamic>? nombreProfes;

  Future<void> obtenerCarreraData() async {
    List<ProfeModel> profeData = (await tareaProfeBD!.getProfeData());
    if (mounted) {
      setState(() {
        nombreProfes?.clear();
        nombreProfes = {}; // Inicializa el mapa
        for (var profe in profeData) {
          int idProfe= profe.idProfe!;
          String nomProfe = profe.nomProfe!;
          nombreProfes![idProfe] = nomProfe; // Usar idTeacher como clave
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    stateCheck = widget.tareaModel.realizada! == 1 ? false : true;

    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 112, 1, 1),
      ),
      margin: const EdgeInsets.only( top: 10 ),
      padding: const EdgeInsets.all( 6 ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Titulo: ${widget.tareaModel.nomTarea!}"),
                Text("Descripción: ${widget.tareaModel.desTarea!}"),
                Text("Limite: ${widget.tareaModel.fecExp!}"),
                Text("Recordar: ${widget.tareaModel.fecRec!}"),
                Text("Estado: ${widget.tareaModel.realizada! == 1 ? "Por Hacer" : "Haciendo"}"),
                Text("Profe: ${nombreProfes?[widget.tareaModel.idProfe] ?? 'Pendiente'}" )
              ],
            ),
          ),
          Expanded(child: Container()),
          Botones(
            tareaProfeBD: widget.tareasProfeBD!, 
            tableName: "tblTarea",
            id: "idTarea",
            model: widget.tareaModel.idTarea,
            idForeignKey: widget.tareaModel.idProfe,
            builder: (context) => AddTareas(),
            screen: 'tarea',
            data: widget.tareaModel,
            checkbox: Checkbox(
              value: stateCheck,
              onChanged: (value) async {
                await widget.tareasProfeBD!.update('tblTarea', {
                    'idTarea': widget.tareaModel.idTarea,
                    'nomTarea': widget.tareaModel.nomTarea,
                    'desTarea': widget.tareaModel.desTarea,
                    'fecExp': widget.tareaModel.fecExp,
                    'fecRec': widget.tareaModel.fecRec,
                    'realizada': widget.tareaModel.realizada == 1 ? 2 : 1,
                  },
                  'idTarea'
                );

                GlobalValues.flagTask.value = !GlobalValues.flagTask.value;
                stateCheck = !value!;
              },
            ), SizedBox: null, 
          )
        ],
      ),
    );
  }
}