import 'package:movies/features/search/data/models/search_model.dart';

class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final SearchModel? searchmodel;
  SearchSuccess(this.searchmodel);
}

class SearchError extends SearchState {
  final String errorMessage;
  SearchError(this.errorMessage);
}
