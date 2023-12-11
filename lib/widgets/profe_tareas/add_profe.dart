import 'package:flutter/material.dart';
import 'package:practica_1/assets/styles/global_values.dart';
import 'package:practica_1/database/tareas_profesor.dart';
import 'package:practica_1/models/carrera_model.dart';
import 'package:practica_1/models/profe_model.dart';
import 'package:practica_1/widgets/personalizado.dart';
import 'package:practica_1/widgets/profe_tareas/profe_card.dart';

// ignore: must_be_immutable
class AddProfe extends StatefulWidget {
  AddProfe({super.key, this.profeModel});
  ProfeModel? profeModel;

  List<ProfeModel> profes = [];

  @override
  State<AddProfe> createState() => _AddProfeState();
}

class _AddProfeState extends State<AddProfe> {

  TareaProfesor? tareaProfeBD;
  TextEditingController txtConProfe = TextEditingController();
  TextEditingController txtConEmail = TextEditingController();
  int? dropDownValue;
  List<String> dropDownValues = [];

  @override
  void initState() {
    super.initState();
    tareaProfeBD = TareaProfesor();
    obtenerCarreraData();
    if(widget.profeModel != null) {
      txtConProfe.text = widget.profeModel!.nomProfe!;
      txtConEmail.text = widget.profeModel!.email!;
      dropDownValue = widget.profeModel!.idCarrera!;
    }
  }


  Future<void> obtenerCarreraData() async {
    List<CarreraModel> courseData = await tareaProfeBD!.getCarreraData();
    if (mounted) {
      setState(() {
        dropDownValues.clear();
        for (var course in courseData) {
          String nomCarrera = course.nomCarrera!;
          dropDownValues.add(nomCarrera);
        }
      });
    }
  }

  onChanged(value) {
    setState(() {
      dropDownValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox( height: 20 ),
        CustomTextField(
          controller: txtConProfe,
          labelText: 'Profesor'
        ),
        const SizedBox( height: 20 ),
        CustomTextField(
          controller: txtConEmail,
          labelText: 'Email'
        ),
        const SizedBox( height: 20 ),
        DropdownButton(
          hint: const Text( "Carrera" ),
          value: dropDownValue,
          onChanged: onChanged,
          items: dropDownValues.asMap().entries.map(
            (entry) => DropdownMenuItem(
              value: entry.key + 1,
              child: Text(entry.value),
            ),
          ).toList(),
        ),
        const SizedBox( height: 20 ),
        CustomElevatedButton(
          text: "Guardar Profe",
          onPressed: () async {
            if (txtConEmail.text.isEmpty || txtConProfe.text.isEmpty || dropDownValue == null) {
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
              final isInsert = widget.profeModel == null;
              const tableName = 'tblProfe';
              final operation = isInsert ? 'Inserción' : 'Actualización';

              final result = isInsert
                    ? await tareaProfeBD!.insert(tableName, {
                        'nomProfe': txtConProfe.text,
                        'email': txtConEmail.text,
                        'idCarrera': dropDownValue!,
                      })
                    : await tareaProfeBD!.update(tableName, {
                        'idProfe': widget.profeModel!.idProfe,
                        'nomProfe': txtConProfe.text,
                        'email': txtConEmail.text,
                        'idCarrera': dropDownValue,
                        },
                        'idProfe'
                    );
              GlobalValues.flagTask.value = !GlobalValues.flagTask.value;

              final message = (result > 0) ? '$operation fue exitosa' : 'Ocurrió un error';
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
                future: tareaProfeBD!.getProfeData(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<ProfeModel>> snapshot
                  ) {
                    if(snapshot.hasData) {
                      widget.profes = snapshot.data!;
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          if(widget.profeModel == null){
                            return ProfeCard(
                              profeModel: widget.profes[index],
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