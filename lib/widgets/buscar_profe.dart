import 'package:flutter/material.dart';
import 'package:practica_1/models/profe_model.dart';

class BuscarProfe extends SearchDelegate<ProfeModel> {

  BuscarProfe({
    this.screen, 
    this.listaProfes,
  });

  final String? screen;
  final List<ProfeModel>? listaProfes;
  List<ProfeModel> _filter = [];
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {          
          close(context, ProfeModel());
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      onPressed: () {
        close(context, ProfeModel());
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
            title: Text(_filter[index].nomProfe!)
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
    _filter = listaProfes!.where((model) {
          return model.nomProfe!.toLowerCase().contains(query.trim().toLowerCase());
        }).toList();
    return ListView.builder(
      itemCount: _filter.length,
      itemBuilder: (_, index) {
        return GestureDetector(
          child: ListTile(
            title: Text(_filter[index].nomProfe!),
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