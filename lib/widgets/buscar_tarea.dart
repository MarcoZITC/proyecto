import 'package:flutter/material.dart';
import 'package:practica_1/assets/styles/global_values.dart';

class BuscarTarea {

  static Widget getAppBarNotSearching(String title, Function startSearchFunction) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              startSearchFunction();
            }),
      ],
    );
  }

  static Widget getAppBarSearching(Function cancelSearch, Function searching,
    TextEditingController searchController) {
    return AppBar(
      automaticallyImplyLeading: false,
      
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: TextField(
          onSubmitted: (value) {
            searching();
            GlobalValues.flagTask.value = !GlobalValues.flagTask.value;
          },
          controller: searchController,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          autofocus: true,
          decoration: const InputDecoration(
            focusColor: Colors.white,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
          ),
        ),
      ),
      leading: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            cancelSearch();
          }),
    );
  } 
}