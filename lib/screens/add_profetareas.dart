
import 'package:flutter/material.dart';
import 'package:practica_1/database/tareas_profesor.dart';
import 'package:practica_1/models/carrera_model.dart';
import 'package:practica_1/models/profe_model.dart';
import 'package:practica_1/widgets/buscar_carrera.dart';
import 'package:practica_1/widgets/buscar_profe.dart';
import 'package:practica_1/widgets/profe_tareas/add_carrera.dart';
import 'package:practica_1/widgets/profe_tareas/add_profe.dart';
import 'package:practica_1/widgets/profe_tareas/add_tareas.dart';

class AddProfeTareas extends StatefulWidget {
  const AddProfeTareas({super.key});

  @override
  State<AddProfeTareas> createState() => _AddProfeTareas();
}

class _AddProfeTareas extends State<AddProfeTareas> {
  List<dynamic> modelos = [];  
  List<ProfeModel> profes = [];  
  List<CarreraModel> carreras = [];  
  TareaProfesor? tareaProfesorBD;

  @override
  void initState() {
    super.initState();
    tareaProfesorBD = TareaProfesor();
    ObtenerDatos();
  }

  Future<void> ObtenerDatos() async {
    carreras = await tareaProfesorBD!.getCarreraData();
    profes = await tareaProfesorBD!.getProfeData();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    Widget widget;
    switch (arguments['screen']) {
      case 'profe':
        widget = AddProfe(profeModel: arguments['data'] );
        break;
      case 'carrera':
        widget = AddCarrera(carreraModel: arguments['data'] );
        break;
      default:
        widget = AddTareas(tareaModel: arguments['data'] );
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: arguments['data'] != null ? const Text('Edit Element') : const Text('Añadir Elemento'),
        actions: <Widget>[
          if (arguments['screen'] == 'profe')
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context, 
                  delegate: BuscarProfe(
                    listaProfes: profes, 
                    screen: arguments['screen']
                  )
                );
              },
            )
          else
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context, 
                  delegate: BuscarCarrera(
                    listaCarreras: carreras,
                    screen: arguments['screen']
                  )
                );
              },
            )
        ]
      ),
      body: widget
    );
  }
}