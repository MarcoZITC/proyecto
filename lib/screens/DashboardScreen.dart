import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:practica_1/assets/styles/global_values.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen ({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //bool isDarkModeEnable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wellcome... :)'),
      ),
      drawer: createDrawer(context),           //Menu lateral izquierdo
      //endDrawer: Drawer(),        Menu lateral derecho
    );
  }

  Widget createDrawer(context){
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/777'),
            ),
            accountName: Text('Rubensin Torres Frias'), 
            accountEmail: Text('isctorres@gmail.com')
          ),
          ListTile(
            //leading: Icon(Icons.web),
            leading: Image.asset('assets/456.jpg'),
            trailing: Icon(Icons.chevron_right),
            title: Text('FruitApp'),
            subtitle: Text('Carrusel'),
            onTap: (){},
          ),
          
          ListTile(
            leading: const Icon(Icons.task_alt_outlined),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Task Manager'),
            onTap: () => Navigator.pushNamed(context, '/task'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: DayNightSwitcher(
              isDarkModeEnabled: GlobalValues.flagTheme.value,
              onStateChanged: (isDarkModeEnabled) async {              
                setState(() {
                  GlobalValues.prefsTheme.setBool('themeValue', isDarkModeEnabled);
                  GlobalValues.flagTheme.value = isDarkModeEnabled; 
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80, right: 80),
            child: FloatingActionButton.extended(
              icon: Icon(Icons.login_outlined),
              label: Text('Login out'),
              foregroundColor: Colors.white,
              backgroundColor: Color.fromARGB(255, 255, 8, 0),
              onPressed: () { GlobalValues.prefsCheck.setBool("checkValue", false); 
                Navigator.pushNamed(context, '/login'); 
              }
            )
          )
          /*DayNightSwitcher(
            isDarkModeEnabled: GlobalValues.flagTheme.value,
            onStateChanged: (isDarkModeEnabled) {
              GlobalValues.flagTheme.value = isDarkModeEnabled;
            },
          ),*/
        ],
      ),
    );
  }
}