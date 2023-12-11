import 'package:flutter/material.dart';
import 'package:practica_1/database/tareas_profesor.dart';
import 'package:practica_1/models/carrera_model.dart';
import 'package:practica_1/models/profe_model.dart';
import 'package:practica_1/widgets/buttons.dart';
import 'package:practica_1/widgets/profe_tareas/add_profe.dart';

// ignore: must_be_immutable
class ProfeCard extends StatefulWidget {
  ProfeCard({super.key, required this.profeModel, this.tareaProfeBD});

  ProfeModel profeModel;
  TareaProfesor? tareaProfeBD;

  @override
  State<ProfeCard> createState() => _ProfeCardState();
}

class _ProfeCardState extends State<ProfeCard> {

  TareaProfesor? tareaProfeBD;

  @override
  void initState() {
    super.initState();    
    tareaProfeBD = TareaProfesor();
    obtenerCarreraData();
  }

  Map<int, dynamic>? nombreCarreras;

  Future<void> obtenerCarreraData() async {
    List<CarreraModel> carreraData = (await tareaProfeBD!.getCarreraData());
    if (mounted) {
      setState(() {
        nombreCarreras?.clear();
        nombreCarreras = {}; // Inicializa el mapa
        for (var carrera in carreraData) {
          int idCarrera = carrera.idCarrera!;
          String nomCarrera = carrera.nomCarrera!;
          nombreCarreras![idCarrera] = nomCarrera;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 96, 0, 0),
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
                Text(widget.profeModel.nomProfe!),
                Text(widget.profeModel.email!),
                Text( "Profe: ${nombreCarreras?[widget.profeModel.idCarrera] ?? 'Pendiente'}" )
              ],
            ),
          ),
          Botones(
            tareaProfeBD: widget.tareaProfeBD!, 
            tableName: "tblProfe",
            id: "idProfe",
            model: widget.profeModel.idProfe,
            idForeignKey: widget.profeModel.idProfe,
            builder: (context) => AddProfe(),
            screen: 'profe',
            data: widget.profeModel, 
            SizedBox: null,
          )
        ],
      ),
    );
  }
}