import 'package:flutter/material.dart';
import 'package:practica_1/assets/styles/global_values.dart';
import 'package:practica_1/database/tareas_profesor.dart';
import 'package:intl/intl.dart';
import 'package:practica_1/models/tarea_model.dart';
import 'package:practica_1/widgets/profe_tareas/tareas_card.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  TareaProfesor? tareaProfesorBD;

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  final Map<DateTime, List<TareaModel>> _events = {};
  List<String> listDates = [];
  List<TareaModel> listTasks = [];

  @override
  void initState() {
    super.initState();
    tareaProfesorBD = TareaProfesor();
    obtenerDatosTarea();
  }

  Future<void> obtenerDatosTarea() async {
    listTasks = await tareaProfesorBD!.getTareaData();
    List<TareaModel> listaTareas = await tareaProfesorBD!.getTareaData();
    setState(() {
      for (var tarea in listaTareas) {
        final fecTarea = DateTime.parse(tarea.fecExp!);
        if (_events.containsKey(fecTarea)) {
          _events[fecTarea]!.add(tarea);
        } else {
          _events[fecTarea] = [tarea];
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarBuilders: CalendarBuilders(
            markerBuilder: (context, day, events) {
              List<Widget> dots = [];
              final dateFormat = DateTime.parse(DateFormat('yyyy-MM-dd').format(day));
              final events = _events[dateFormat] ?? [];
              dots = events.map((event) {
                return Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 112, 1, 1),
                  ),
                );
              }).toList();
              // if (day == _selectedDay) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: dots,
                );
              // } else {
              //   return null;
              // }
            },
          ),

            locale: "en_US",
            rowHeight: 45,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true
            ),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, _focusedDay),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _focusedDay = selectedDay;
                _selectedDay = selectedDay;
              });
            },
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: GlobalValues.flagTask,
              builder: (context, value, _) {
                return FutureBuilder(
                  future: tareaProfesorBD!.getTareaFecha(_selectedDay.toString().substring(0, 10)),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<TareaModel>> snapshot
                    ) {
                      if(snapshot.hasData) {
                        listTasks = snapshot.data!;
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TareasCard(
                              tareaModel: snapshot.data![index],
                              tareasProfeBD: tareaProfesorBD,
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
    );
  }
}