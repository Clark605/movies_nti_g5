class MovieDetailsModel {
  int? id;
  String? title;
  String? posterPath;
  String? backdropPath;
  String? releaseDate;
  String? overview;
  double? voteAverage;
  List<Genres>? genres;
  int? runtime;

  MovieDetailsModel({
    this.backdropPath,
    this.genres,
    this.id,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.runtime,
    this.title,
    this.voteAverage,
  });

  MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    overview = json['overview'];
    backdropPath = json['backdrop_path'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    runtime = json['runtime'];
    voteAverage = json['vote_average'];
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(Genres.fromJson(v));
      });
    }
  }
}

class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
