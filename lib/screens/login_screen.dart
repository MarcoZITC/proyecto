import 'package:flutter/material.dart';
import 'package:practica_1/assets/styles/global_values.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    //return Container();

    TextEditingController txtConUser = TextEditingController();   //Controladores para las cajas de texto
    TextEditingController txtConPass = TextEditingController();

    final txtUser = TextField(            //Cajas de texto asociadas a sus controladores
      controller: txtConUser,
      decoration: const InputDecoration(
        border: OutlineInputBorder()
      ),
    );

    final txtPass = TextField(
      controller: txtConPass,
      obscureText: true,        //ocultar el texto que estamos tecleando
      decoration: const InputDecoration(
        border: OutlineInputBorder()
      ),
    );

    final imgLogo = Container(
      width: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(        //Utilizado para trabajar recursos externos
            'https://img.freepik.com/vector-premium/diseno-logotipo-icono-pc-computadora_775854-1632.jpg'
          )
        ),
      ),
    );

    final btnEntrar = FloatingActionButton.extended(
      icon: Icon(Icons.login),
      backgroundColor: const Color.fromARGB(255, 0, 103, 3),
      label: Text('Login'),
      onPressed: (){    //onPressed: () => Navigator.pushNamed(context, '/dash')  Basicamente es lo mismo
        Navigator.pushNamed(context, '/dash');
      },
    );

    final checkSesion = Checkbox(
      activeColor: Color.fromARGB(255, 0, 96, 14),
      value: GlobalValues.prefsCheck.getBool('checkValue') ?? false,
      onChanged: (bool? value) {
        setState(() {
          GlobalValues.prefsCheck.setBool('checkValue', value!);
          // isChecked = value!;
        });
      },
    );

    return Scaffold(
      body: Container(
        //height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: .9,
            fit: BoxFit.fill,
            image: NetworkImage(        //Utilizado para trabajar recursos externos
              'https://e1.pxfuel.com/desktop-wallpaper/451/964/desktop-wallpaper-green-and-black-green.jpg'
            )
          )
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              //imgFondo,
              Container(
                height: 200,
                //color: Colors.green,
                padding: const EdgeInsets.all(30),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 0, 102, 3)
                ),
                child: Column(
                  children: [
                  txtUser,
                  const SizedBox(height: 10,), 
                  txtPass
                  ]
                ),
              ),
              imgLogo
            ],
          ),
        ),
      ),    
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          btnEntrar,
          checkSesion,
          const Text('Remember')
        ],
      )
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //floatingActionButton: btnEntrar,
    );
  }
}