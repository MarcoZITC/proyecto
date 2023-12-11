import 'package:flutter/material.dart';
import 'package:practica_1/database/tareas_profesor.dart';
import 'package:practica_1/models/carrera_model.dart';
import 'package:practica_1/widgets/buttons.dart';
import 'package:practica_1/widgets/profe_tareas/add_carrera.dart';

// ignore: must_be_immutable
class CarreraCard extends StatefulWidget {
  CarreraCard({super.key, required this.carreraModel, this.tareaProfeBD});

  CarreraModel carreraModel;
  TareaProfesor? tareaProfeBD;

  @override
  State<CarreraCard> createState() => _CarreraCardState();
}

class _CarreraCardState extends State<CarreraCard> {

  TareaProfesor? tareaProfeBD;

  @override
  void initState() {
    super.initState();    
    tareaProfeBD = TareaProfesor();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 112, 1, 1),
      ),
      margin: const EdgeInsets.only( top: 10 ),
      padding: const EdgeInsets.all( 6 ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.carreraModel.nomCarrera!),
              ],
            ),
          ),
          Botones(
            tareaProfeBD: widget.tareaProfeBD!, 
            tableName: "tblCarrera",
            id: "idCarrera",
            model: widget.carreraModel.idCarrera,
            idForeignKey: widget.carreraModel.idCarrera,
            builder: (context) => AddCarrera(),
            screen: 'carrera',
            data: widget.carreraModel,
            SizedBox: null,
          )
        ],
      ),
    );
  }
}