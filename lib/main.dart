import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello_movies/models/movie.dart';
import 'package:hello_movies/widgets/moviesWidget.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'Provider.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>MovieProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: App(),
      ),
    );
  }
}
class App extends StatefulWidget {
  @override 
  _App createState() => _App(); 
}

class _App extends State<App> {


  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<MovieProvider>(context,listen:false).populateAllMovies();
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Movies App",
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text("Home",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  // height: 60,width: 350,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(

                      onChanged: (val) =>

                      setState(() {
                        initiateSearch(val);
                        print("Value is $val");
                      }),
                      controller: searchController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                          ),
                          suffixIcon: Icon(Icons.search),
                          hintText: "Search for movies"
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 15,
                  child: MoviesWidget(movies: Provider.of<MovieProvider>(context,listen:false).Movies)),
            ],
          ),
        )
      )
    );
  }
  void initiateSearch(String val) async{
    print(val);
    final movies = await Provider.of<MovieProvider>(context,listen:false).fetchAllMovies(val);
    val == null || val =="" ?
    setState(() {
      val="";
    }):
    setState(() {
      Provider.of<MovieProvider>(context,listen:false).Movies = movies;
    });
}}
