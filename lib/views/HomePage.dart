import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_db/data/remote.dart';
import 'package:movie_db/mode/film_populer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FilmPopuler filmPopuler;
  var isLoaded = false;

  void initState(){
    super.initState();

    getData();
  }

  getData()async{
    filmPopuler = await Remote().getFilmPopuler();
    if (filmPopuler != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("film"),),
      body: ListView.builder(
        itemCount: filmPopuler.results.length,
        itemBuilder: (context, index) {
          return Text("");
        },),
    );
  }
}