import 'package:flutter/material.dart';
import 'package:practica_1/screens/DashboardScreen.dart';
import 'package:practica_1/screens/add_task.dart';
import 'package:practica_1/screens/login_screen.dart';
import 'package:practica_1/screens/task_screen.dart';

Map<String, WidgetBuilder> getRoutes(){
  return{
    '/login' : (BuildContext context) => const LoginScreen(),
    '/dash' : (BuildContext context) => DashboardScreen(),
    '/task' : (BuildContext context) => TaskScreen(),
    '/add' : (BuildContext context) => AddTask(),
  };
}