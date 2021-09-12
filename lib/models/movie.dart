
class Movie {
  final String imdbId; 
  final String poster; 
  final String title; 
  final String year;
  final String type;
  Movie({this.imdbId, this.title, this.poster, this.year,this.type});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      imdbId: json["imdbID"], 
      poster: json["Poster"], 
      title: json["Title"], 
      year: json["Year"],
        type: json["Type"]
    );
  }

}