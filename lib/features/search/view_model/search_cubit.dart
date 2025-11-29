import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/search/data/api/search_api.dart';
import 'package:movies/features/search/view_model/search_state.dart';
import 'package:movies/core/network/result_api.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> searchMovies(String query) async {
    if (query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    final result = await SearchApi.searchMovies(query);

    switch (result) {
      case Success():
        if (result.data?.results == null || result.data!.results!.isEmpty) {
          emit(SearchEmpty());
        } else {
          emit(SearchSuccess(movies: result.data!.results!));
        }
      case Error():
        emit(SearchError(errorMessage: result.errorMessage));
    }
  }

  void clearSearch() {
    emit(SearchInitial());
  }
}
