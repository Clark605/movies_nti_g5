import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/network/result_api.dart';
import 'package:movies/features/details/data/api/details_api.dart';
import 'package:movies/features/details/data/models/similar_movies_model.dart';
import 'package:movies/features/details/view_model/similar_state.dart';

class SimilarCubit extends Cubit<SimilarState> {
  SimilarCubit() : super(SimilarInitial());

  void fetchSimilarMovies(int movieId) async {
    emit(SimilarLoading());
    final result = await DetailsApi.fetchSimilarDetails(movieId);
    switch (result) {
      case Success<SimilarMoviesModel>():
        emit(SimilarSuccess(result.data));
      case Error<SimilarMoviesModel>():
        emit(SimilarError(result.errorMessage));
    }
  }
}
