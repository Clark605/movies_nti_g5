import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/network/result_api.dart';
import 'package:movies/features/search/data/api/search_api.dart';
import 'package:movies/features/search/data/models/search_model.dart';
import 'package:movies/features/search/view_model/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> fetchDetails(String search) async {
    emit(SearchLoading());
    final result = await SearchApi.fetchSearch(search);
    switch (result) {
      case Success<SearchResponseModel>():
        emit(SearchLoaded(result.fromJson));
      case Error<SearchResponseModel>():
        emit(SearchError(result.errorMessage));
    }
  }
}
