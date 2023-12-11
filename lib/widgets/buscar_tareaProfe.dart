import 'package:flutter/material.dart';
import 'package:practica_1/models/tarea_model.dart';

class BuscarTareaProfe extends SearchDelegate<TareaModel> {

  BuscarTareaProfe({
    this.screen, 
    this.listaTareas,
  });

  final String? screen;
  final List<TareaModel>? listaTareas;
  List<TareaModel> _filter = [];
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {          
          close(context, TareaModel());
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      onPressed: () {
        close(context, TareaModel());
      },
      icon: const Icon(Icons.arrow_back),
    );
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: _filter.length,
      itemBuilder: (_, index) {        
        return GestureDetector(
          child: ListTile(
            title: Text(_filter[index].nomTarea!)
          ),
          onTap: () {
            close(context, _filter[index]);
            Navigator.pushNamed(context, '/addTareaProfe', arguments: {'screen': screen, 'data': _filter[index]});
          }
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filter = listaTareas!.where((model) {
          return model.nomTarea!.toLowerCase().contains(query.trim().toLowerCase());
        }).toList();
    return ListView.builder(
      itemCount: _filter.length,
      itemBuilder: (_, index) {
        return GestureDetector(
          child: ListTile(
            title: Text(_filter[index].nomTarea!),
          ),
          onTap: () {
            close(context, _filter[index]);
            Navigator.pushNamed(context, '/addTareaProfe', arguments: {'screen': screen, 'data': _filter[index]});
          }
        );
      },
    );
  }
}