import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/data/api_profider.dart';
import 'package:movie_db/mode/popular_movie.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiProvider apiProvider = ApiProvider();
  late Future<PopularMovie> PopularMovies;

  String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  void initState() {
    PopularMovies = apiProvider.getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App'),
      ),
      body: FutureBuilder(
        future: PopularMovies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.results.length,
              itemBuilder: (context, index) {
                return moviesItem(
                  poster: "$imageBaseUrl${snapshot.data?.results[index].posterPath}", 
                  title: "${snapshot.data?.results[index].title}", 
                  date: "${snapshot.data?.results[index].releaseDate}", 
                  vote_average: "${snapshot.data?.results[index].voteAverage}", 
                  onTap: () {
                    
                  },);
              },
            );
          }else if(snapshot.hasError){
            print("has Error ${snapshot.error}");
            return Text("error");
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
    );
  }

  Widget moviesItem(
      {required String poster,
      required String title,
      required String date,
      required String vote_average,
      required Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Card(
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  child: CachedNetworkImage(imageUrl: poster),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 12,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(date)
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 12,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(vote_average)
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MovieDetail extends StatelessWidget {
  final Result movie;
  const MovieDetail({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(movie.title),
      ),
    );
  }
}
