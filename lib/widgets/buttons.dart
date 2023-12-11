import 'package:flutter/material.dart';
import 'package:practica_1/assets/styles/global_values.dart';
import 'package:practica_1/database/tareas_profesor.dart';

// ignore: must_be_immutable
class Botones extends StatefulWidget {
  Botones({
    super.key,
    required this.tareaProfeBD,
    required this.tableName,
    required this.id,
    required this.builder,
    required this.screen,
    required this.idForeignKey,
    this.model,
    this.data,
    this.checkbox, required SizedBox 
  });

  final WidgetBuilder builder;
  late TareaProfesor tareaProfeBD;
  final String tableName;
  final String id;
  final String screen;
  final dynamic model;
  final dynamic data;
  final Widget? checkbox;
  final dynamic idForeignKey;

  @override
  State<Botones> createState() => _ButtonsUpDelState();
}

class _ButtonsUpDelState extends State<Botones> {
  bool foreignKey = false;

  @override
  void initState() {
    super.initState();
    widget.tareaProfeBD = TareaProfesor();
    initForeignKey();
  }

  Future<void> initForeignKey() async {
    setState(() {
      
    });
    switch (widget.screen) {
      case "carrera":
        foreignKey = await widget.tareaProfeBD.getForeignKey("tblProfe", "idCarrera", widget.idForeignKey);    
        break;
      case "teacher":
        foreignKey = await widget.tareaProfeBD.getForeignKey("tblTarea", "idProfe", widget.idForeignKey);
        break;
      default:
        foreignKey = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: widget.builder,
                  settings: RouteSettings(
                    arguments: {'screen': widget.screen, 'data': widget.data},
                  )
                ),
              );
              
            },
            child: const Icon(Icons.edit)
          ),
          widget.checkbox ?? const SizedBox(height: 20),
          IconButton(
            onPressed: () {
              showDialog(
                context: context, 
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Mensaje del sistema'),
                    content: const Text('¿Deseas borrar la tarea?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Future<void> getForeignKey() async {
                            switch (widget.screen) {
                              case "course":
                                foreignKey = await widget.tareaProfeBD.getForeignKey("tblProfe", "idCarrera", widget.model);
                                break;
                              case "teacher":
                                foreignKey = await widget.tareaProfeBD.getForeignKey("tblTarea", "idProfe", widget.model);
                                break;
                              default:
                                foreignKey = true;
                            }
                          }
                          getForeignKey();
                          if (foreignKey) {
                            widget.tareaProfeBD.delete(widget.tableName, widget.model!, widget.id).then((value) {
                              Navigator.pop(context);
                              GlobalValues.flagTask.value = !GlobalValues.flagTask.value;
                            });
                          } else {
                            Navigator.pop(context);
                            showDialog(
                              context: context, 
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Relaciones foráneas'),
                                  content: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('Hay una relación con otro resgistro, borra primero el otro registro.'),
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
                          }
                        }, 
                        child: const Text('Si.')
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context), 
                        child: const Text('No.')
                      )
                    ],
                  );
                },
              );
            }, 
            icon: const Icon(Icons.delete)
          ),
        ],
      ),
    );
  }
}