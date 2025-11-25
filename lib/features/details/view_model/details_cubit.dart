import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/network/result_api.dart';
import 'package:movies/features/details/data/api/details_api.dart';
import 'package:movies/features/details/data/models/movie_detail_model.dart.dart';
import 'package:movies/features/details/view_model/details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  void fetchDetails(int movieId) async {
    emit(DetailsLoading());
    final result = await DetailsApi.fetchMovieDetails(movieId);
    switch (result) {
      case Success<MovieDetailsModel>():
        emit(DetailsSuccess(result.data));
      case Error<MovieDetailsModel>():
        emit(DetailsError(result.errorMessage));
    }
  }
}
