import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'models/movie.dart';
class MovieProvider extends ChangeNotifier{
  var API_KEY = "8a76cc069a1630a8083e70f497a9f787";
  List<Movie> Movies = new List<Movie>();
  var movie_name="";
  bool available=false;
  // efcc2117
  String imagePath;
  var url= Uri.parse("http://www.omdbapi.com/?s=Batman&page=2&apikey=efcc2117");
  String fullImageUrl = "https://image.tmdb.org/t/p/w200{imagePath}";
  var data;



  Widget movieList(){
    return   ListView.builder(
        shrinkWrap: true,
        itemCount:
        data==null ? 0:
        data["Search"].length ,
        itemBuilder: (context,index){
          return
            Provider.of<MovieProvider>(context).data==null ? CircularProgressIndicator():
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Image.network(Provider.of<MovieProvider>(context).data["Search"][index]['Poster'].toString()
                      ,height: 100,width: 200,),
                  ),
                  Expanded(child: Text( Provider.of<MovieProvider>(context).data["Search"][index]['Title'].toString())),
                ],
              ),
            );
        });
}
  void populateAllMovies() async {
    final movies = await fetchAllMovies("batman");
    Movies = movies;
  }


  Future<List<Movie>> fetchAllMovies(String name) async {
    final response = await http.get("http://www.omdbapi.com/?s=${name}&page=2&apikey=efcc2117");

    if(response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["Search"];
      print(result["Search"]);
      return list.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Failed to load movies!");
    }

  }

}