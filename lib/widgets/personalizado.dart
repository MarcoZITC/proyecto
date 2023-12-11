import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// * ListTile
class CustomListTile extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String routeAsset;
  final String title;
  final String subtitle;

  const CustomListTile({
    super.key,
    required this.routeAsset,
    required this.title,
    required this.subtitle,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(routeAsset), //asset('assets/icon_orange.png'),
      trailing: const Icon(Icons.chevron_right),
      title: Text(title), //FruitApp
      subtitle: Text(subtitle), //Carrusel,
      onTap: onTap,
    );
  }
}

// * TextField
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final String labelText;

  const CustomTextField({
    super.key,
    required this.controller,
    this.textInputAction,
    this.obscureText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: textInputAction,
      style: const TextStyle(color: Colors.white),
      obscureText: obscureText ?? false,
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
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white)
      ),
    );
  }
}

// * TextFormField
class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final int? maxLines;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.text,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        label: Text(text),
        labelStyle: const TextStyle(color: Colors.white),
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
      ),
      controller: controller,
      maxLines: maxLines,
    );
  }
}

// * FloatingActionButton
class CustomFloatingActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;
  

  const CustomFloatingActionButton({
    super.key, 
    required this.text, 
    required this.icon, 
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(icon),
      label: Text(text),
      foregroundColor: Colors.white,
      backgroundColor: Color.fromARGB(255, 72, 0, 0),
      onPressed: onPressed
    );
  }
}

// * ElevatedButton
class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const CustomElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all( Color.fromARGB(255, 147, 0, 0) ),
        foregroundColor: MaterialStateProperty.all( Colors.white ),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Cambia el radio de las esquinas
        )),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

// * Toast - https://pub.dev/packages/fluttertoast
class CustomToast{
  static void show(String mess) {
    Fluttertoast.showToast(
      msg: mess,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black38,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }
}

// * GestureDetector
class CustomGestureDetector extends StatelessWidget {
  final Widget child;

  const CustomGestureDetector({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: child,
    );
  }
}

// * DropdownButton
class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint
  });

  final String? value;
  final String? hint;
  final List<String> items;
  final ValueChanged? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isExpanded: true,
      hint: Text(hint ?? "Select"),
      value: value,
      items: items.map(
        (status) => DropdownMenuItem(
          value: status,
          child: Center(child: Text(status))
        )
      ).toList(),
      onChanged: onChanged
    );
  }
}