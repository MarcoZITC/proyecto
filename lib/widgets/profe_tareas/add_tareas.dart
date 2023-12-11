import 'package:flutter/material.dart';
import 'package:practica_1/assets/styles/global_values.dart';
import 'package:practica_1/database/tareas_profesor.dart';
import 'package:practica_1/models/profe_model.dart';
import 'package:intl/intl.dart';
import 'package:practica_1/models/tarea_model.dart';
import 'package:practica_1/notifications/profe_tareas_noti.dart';
import 'package:practica_1/widgets/personalizado.dart';

// ignore: must_be_immutable
class AddTareas extends StatefulWidget {
  AddTareas({super.key, this.tareaModel});
  TareaModel? tareaModel;

  @override
  State<AddTareas> createState() => _AddTareasState();
}

class _AddTareasState extends State<AddTareas> {
  
  TareaProfesor? tareaProfeBD;
  TextEditingController txtConNombre = TextEditingController();
  TextEditingController txtConDes = TextEditingController();
  TextEditingController txtConFecExp = TextEditingController();
  TextEditingController txtConFecRec = TextEditingController();

  String? dropDownValueTarea;
  List<String> dropDownTareaValues = [
    "1.- Por Hacer",
    "2.- Haciendo"
  ];
  int? dropDownValueProfe;
  List<String> dropDownProfeValues = [];

  Future<void> obtenerTareaData() async {
    List<ProfeModel> profeData = await tareaProfeBD!.getProfeData();
    if (mounted) {
      setState(() {
        dropDownProfeValues.clear();
        for (var profe in profeData) {
          String nomProfe = profe.nomProfe!;
          dropDownProfeValues.add(nomProfe);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    tareaProfeBD = TareaProfesor();
    obtenerTareaData();
    if(widget.tareaModel != null) {
      txtConNombre.text = widget.tareaModel!.nomTarea!; 
      txtConDes.text = widget.tareaModel!.desTarea!; 
      txtConFecExp.text = widget.tareaModel!.fecExp!; 
      txtConFecRec.text = widget.tareaModel!.fecRec!; 
      dropDownValueTarea = widget.tareaModel!.realizada! == 1 ? "1.- Por hacer" : "2.- Haciendo"; 
      dropDownValueProfe = widget.tareaModel!.idProfe!;
    }
  }

  @override
  Widget build(BuildContext context) {

    onChangedTeacher(value) {
      setState(() {
        dropDownValueProfe = value;
      });
    } 

    onChangedTask(value) {
      setState(() {
        dropDownValueTarea = value;
      });
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(        
        children: [
          const SizedBox( height: 20 ),
          CustomTextField(
            controller: txtConNombre,
            labelText: 'Tarea'
          ),
          const SizedBox( height: 20 ),
          CustomTextFormField(
            controller: txtConDes,
            text: 'Description',
            maxLines: 6,
          ),
          const SizedBox( height: 20 ),
          DateInputField(
            controller: txtConFecExp,
            label: "Limite Tarea",
            onDateSelected: (DateTime selectedDate) {
              
            },
          ),
          const SizedBox( height: 20 ),
          DateInputField(
            controller: txtConFecRec,
            label: "Recordar Tarea",
            onDateSelected: (DateTime selectedDate) {
              
            },
          ),
          const SizedBox( height: 20 ),
          CustomDropdownButton(
            value: dropDownValueTarea,
            items: dropDownTareaValues,
            onChanged: onChangedTask
          ),
          const SizedBox( height: 20 ),
          DropdownButton(
            hint: const Text( "Profe" ),
            value: dropDownValueProfe,
            onChanged: onChangedTeacher,
            items: dropDownProfeValues.asMap().entries.map(
              (entry) => DropdownMenuItem(
                value: entry.key + 1,
                child: Text(entry.value),
              ),
            ).toList(),
          ),
          const SizedBox( height: 20 ),
          CustomElevatedButton(
            text: "Guardar Tarea",
            onPressed: () async {
              if (txtConNombre.text.isEmpty || txtConDes.text.isEmpty || txtConFecExp.text.isEmpty || txtConFecRec.text.isEmpty || dropDownValueTarea == null || dropDownValueProfe == null) {
                showDialog(
                  context: context, 
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Campos'),
                      content: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Los campos no pueden estar vacíos.'),
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
                if(widget.tareaModel == null){
                  scheduleNotification(txtConNombre.text, txtConDes.text, DateFormat('yyyy-MM-dd').parse(txtConFecRec.text));
                  showNotification(txtConNombre.text, 'Tarea Programada');
                }

                GlobalValues.flagTask.value = !GlobalValues.flagTask.value; // ? Debería implementarse en los inserts
                final isInsert = widget.tareaModel == null;
                const tableName = 'tblTarea';
                final operation = isInsert ? 'Inserción' : 'Actualización';
      
                final result = isInsert
                      ? await tareaProfeBD!.insert(tableName, {
                          'nomTarea': txtConNombre.text,
                          'desTarea': txtConDes.text,
                          'fecExp': txtConFecExp.text,
                          'fecRec': txtConFecRec.text,
                          'realizada': int.parse(dropDownValueTarea!.substring(0, 1)),
                          'idProfe': dropDownValueProfe,
                        })
                      : await tareaProfeBD!.update(tableName, {
                          'idTarea': widget.tareaModel!.idTarea,
                          'nomTarea': txtConNombre.text,
                          'desTarea': txtConDes.text,
                          'FecExp': txtConFecExp.text,
                          'FecRec': txtConFecRec.text,
                          'realizada': int.parse(dropDownValueTarea!.substring(0, 1)),
                        },
                        'idTarea'
                        );
      
                final message = (result > 0) ? '$operation fue exitosa' : 'Ocurrió un error';
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }
}

// * Custom Widget Date
class DateInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function(DateTime)? onDateSelected;

  const DateInputField({
    super.key, 
    required this.controller,
    required this.label,
    this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white
          )
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white
          )
        ),
        icon: const Icon(Icons.calendar_today),
        labelText: label,
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          controller.text = formattedDate;
          if (onDateSelected != null) {
            onDateSelected!(pickedDate);
          }
        }
      },
    );
  }
}