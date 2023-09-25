import 'package:flutter/material.dart';
import 'package:practica_1/database/agendadb.dart';
import 'package:practica_1/widgets/carTaskWidget.dart';

import '../models/task_model.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreen();
}

class _TaskScreen extends State<TaskScreen> {

  AgendaDB? agendaDB;

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [        //Nos muestra iconos para mostrar en las orillas de la app
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/add'), 
            icon: const Icon(Icons.task))
        ],
      ),
      body: FutureBuilder(
        future: agendaDB!.GETALLTASK(),
        builder: (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index){
                return CardTaskWidget(
                  taskModel: snapshot.data![index],
                );
              },
            );
          }else {
            if (snapshot.hasError){
              return const Center(
                child: Text('Something was wrong!!!'),
              );
            }else{
             return const CircularProgressIndicator();
            }
          }
        },
      ),
    );
  }
}