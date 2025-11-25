class SimilarMoviesModel {
  List<Results>? results;

  SimilarMoviesModel({this.results});

  SimilarMoviesModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }
}

class Results {
  int? id;
  String? posterPath;

  Results({this.id, this.posterPath});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    posterPath = json['poster_path'];
  }
}
