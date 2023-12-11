// ignore: file_names
import 'package:flutter/material.dart';
import 'package:practica_1/assets/styles/global_values.dart';
import 'package:practica_1/database/tareas_profesor.dart';
import 'package:practica_1/models/tarea_model.dart';
import 'package:practica_1/widgets/botones_profe.dart';
import 'package:practica_1/widgets/buscar_tareaProfe.dart';
import 'package:practica_1/widgets/personalizado.dart';
import 'package:practica_1/widgets/profe_tareas/tareas_card.dart';

// ignore: must_be_immutable
class ProfeTareasScreen extends StatefulWidget {
  ProfeTareasScreen({super.key, this.tareaModel});
  TareaModel? tareaModel;

  @override
  State<ProfeTareasScreen> createState() => _ProfeTareasScreen();
}

class _ProfeTareasScreen extends State<ProfeTareasScreen> {

  TareaProfesor? tareaProfBD;

  @override
  void initState() {
    super.initState();
    tareaProfBD = TareaProfesor();
  }

  String dropDownValue = "3.- Todas";
  List<String> dropDownValues = [
      "1.- Por hacer",
      "2.- Haciendo",
      "3.- Todas"
  ];

  List<TareaModel> tareas = [];

  @override
  Widget build(BuildContext context) {
    
    onChanged(value) {
      dropDownValue = value;
      setState(() {
      });
    }

    final addBStatus = CustomDropdownButton(
      value: dropDownValue, 
      items: dropDownValues,
      onChanged: onChanged,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tareas Profe'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {
              Navigator.pushNamed(context, '/calendar', arguments: {'tasks': tareas});
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context, 
                delegate: BuscarTareaProfe(listaTareas: tareas, screen: "tareas")
              );
            },
          ),
        ]
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox( height: 20 ),
              addBStatus,
              const SizedBox( height: 20 ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: GlobalValues.flagTask,
                  builder: (context, value, _) {
                    return FutureBuilder(
                      future: dropDownValue != "3.- Todas"
                        ? tareaProfBD!.getTareaRealizada(int.parse(dropDownValue.substring(0, 1)))
                        : tareaProfBD!.getTareaData(),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<List<TareaModel>> snapshot
                        ) {
                          if(snapshot.hasData) {
                            tareas = snapshot.data!;
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TareasCard(
                                  tareaModel: tareas[index],
                                  tareasProfeBD: tareaProfBD,
                                );
                             }
                            );
                          } else {
                            if(snapshot.hasError) {
                              return const Center(
                                child: Text('Something was wrong!'),
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }
                        }
                    );
                  }
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 60,
            right: 20,
            child: BotonesProfe(tareaProfeBD: tareaProfBD)
          ),
        ],
      ) 
    );
  }
}