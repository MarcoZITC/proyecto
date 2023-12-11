import 'package:flutter/material.dart';
import 'package:practica_1/screens/DashboardScreen.dart';
import 'package:practica_1/screens/add_profetareas.dart';
import 'package:practica_1/screens/add_task.dart';
import 'package:practica_1/screens/calendar_screen.dart';
import 'package:practica_1/screens/login_screen.dart';
import 'package:practica_1/screens/popular_screen.dart';
import 'package:practica_1/screens/profeTareas_screen.dart';
import 'package:practica_1/screens/task_screen.dart';

Map<String, WidgetBuilder> getRoutes(){
  return{
    '/login' : (BuildContext context) => const LoginScreen(),
    '/dash' : (BuildContext context) => DashboardScreen(),
    '/task' : (BuildContext context) => const TaskScreen(),
    '/add' : (BuildContext context) => AddTask(),
    '/popular' : (BuildContext context) => const PopularScreen(),
    '/profe' : (BuildContext context) => ProfeTareasScreen(),
    '/addProfeTarea' : (BuildContext context) => AddProfeTareas(),
    '/calendar' : (BuildContext context) => const CalendarScreen(),
  };
}