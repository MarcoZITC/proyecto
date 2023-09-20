import 'package:flutter/material.dart';
import 'package:practica_1/assets/styles/global_values.dart';
import 'package:practica_1/assets/styles/styles_app.dart';
import 'package:practica_1/routes.dart';
import 'package:practica_1/screens/DashboardScreen.dart';
import 'package:practica_1/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalValues.configPrefs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return ValueListenableBuilder(
      valueListenable: GlobalValues.flagTheme,
      builder: (context, value, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: GlobalValues.prefsCheck.getBool('checkValue') ?? false
                ?  DashboardScreen() 
                : const LoginScreen(),
          routes: getRoutes(),
          theme: value
                  ? StylesApp.darkTheme(context)
                  : StylesApp.lightTheme(context)
        );
      }
    );
  }
}