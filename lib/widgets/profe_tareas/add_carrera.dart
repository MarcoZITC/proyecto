import 'package:flutter/material.dart';
import 'package:practica_1/assets/styles/global_values.dart';
import 'package:practica_1/database/tareas_profesor.dart';
import 'package:practica_1/models/carrera_model.dart';
import 'package:practica_1/widgets/personalizado.dart';
import 'package:practica_1/widgets/profe_tareas/carrera_card.dart';

// ignore: must_be_immutable
class AddCarrera extends StatefulWidget {
  AddCarrera({super.key, this.carreraModel});
  CarreraModel? carreraModel;

  List<CarreraModel> carreras = [];

  @override
  State<AddCarrera> createState() => _AddCarreraState();
}

class _AddCarreraState extends State<AddCarrera> {
  TextEditingController txtConCarrera = TextEditingController();

  TareaProfesor? tareaProfeBD;

  @override
  void initState() {
    super.initState();
    tareaProfeBD = TareaProfesor();
    if(widget.carreraModel != null) {
      txtConCarrera.text = widget.carreraModel!.nomCarrera!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox( height: 20 ),
        CustomTextField(
          controller: txtConCarrera,
          labelText: 'Carrera'
        ),
        const SizedBox( height: 20 ),
        CustomElevatedButton(
          text: "Guardar Carrera",
          onPressed: () async {
            if (txtConCarrera.text.isEmpty) {
              showDialog(
                context: context, 
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Campos'),
                    content: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Los campos no pueden estar vacíos'),
                      ]
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Aceptar'),
                        onPressed: (){
                          Navigator.of(context).pop();
                        }, 
                      )
                    ],
                  );
                },
              );
            } else {
              final isInsert = widget.carreraModel == null;
              const tableName = 'tblCarrera';
              final operation = isInsert ? 'Inserción' : 'Actualización';

              final result = isInsert
                    ? await tareaProfeBD!.insert(tableName, {
                        'nomCarrera': txtConCarrera.text,
                      })
                    : await tareaProfeBD!.update(tableName, {
                        'idCarrera': widget.carreraModel!.idCarrera,
                        'nomCarrera': txtConCarrera.text,
                        },
                        'idCarrera'
                    );
              GlobalValues.flagTask.value = !GlobalValues.flagTask.value;
              final message = (result > 0) ? '$operation fue exitosa' : 'Ocurrió un error';
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
              Navigator.pop(context);
              if (operation == "Actualización") {
                Navigator.pop(context);
              }
            }
          },
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: GlobalValues.flagTask,
            builder: (context, value, _) {
              return FutureBuilder(
                future: tareaProfeBD!.getCarreraData(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<CarreraModel>> snapshot
                  ) {
                    if(snapshot.hasData) {
                      widget.carreras = snapshot.data!;
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          if(widget.carreraModel == null){
                            return CarreraCard(
                              carreraModel: widget.carreras[index],
                              tareaProfeBD: tareaProfeBD,
                            );
                          }
                          return null;
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
    );
  }
}