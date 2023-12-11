import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practica_1/models/popular_model.dart';

class ApiPopular{
  Uri link = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=d0fef6c4d125b0e90bc513955ea4fd6c&language=es-MX&page=1');

  Future<List<PopularModel>?> getAllPopular() async{
    var response = await http.get(link);
    if(response.statusCode == 200){
      var jsonResult = jsonDecode(response.body)['results'] as List;
      return jsonResult.map((popular) => PopularModel.fromMap(popular)).toList();
    }
    return null;
  }
}