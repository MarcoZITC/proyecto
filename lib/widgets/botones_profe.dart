import 'package:flutter/material.dart';
import 'package:practica_1/database/tareas_profesor.dart';
import 'package:practica_1/widgets/personalizado.dart';

class BotonesProfe extends StatefulWidget {
  const BotonesProfe({super.key,this.tareasProfeDB, TareaProfesor? tareaProfeBD});

  final TareaProfesor? tareasProfeDB;

  @override
  State<BotonesProfe> createState() => _BotonesProfeState();
}

class _BotonesProfeState extends State<BotonesProfe> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox( height: 10 ),
        CustomElevatedButton(
          text: 'Carreras', 
          // icon: Icons.add_task,
          onPressed: () {
              Navigator.pushNamed(context, '/addProfeTarea', arguments: {'screen': "carrera", 'dataList': widget.tareasProfeDB});
          },
        ),
        CustomElevatedButton(
          text: 'Profes', 
          // icon: Icons.add_task,
          onPressed: () {
              Navigator.pushNamed(context, '/addProfeTarea', arguments: {'screen': "profe", 'dataList': widget.tareasProfeDB});
          },
        ),
        const SizedBox( height: 10 ),
        CustomElevatedButton(
          text: 'Tareas', 
          // icon: Icons.add_task,
          onPressed: () {
              Navigator.pushNamed(context, '/addProfeTarea', arguments: {'screen': "tarea", 'dataList': widget.tareasProfeDB});
          },
        )
      ]
    );
  }
}