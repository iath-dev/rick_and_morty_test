import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_test/src/models/models.dart';
import 'package:rick_and_morty_test/src/services/services.dart';

part 'search_state.dart';
part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ApiService service;
  String query = '';
  bool isMore = true;

  SearchBloc(this.service) : super(SearchInitial()) {
    on<LoadCharacters>((event, emit) async {
      emit(SearchInitial());
      emit(SearchLoading());

      isMore = true;

      try {
        query = event.query;
        final data = await service.searchCharacter(event.query, state.page);

        if (data != null) {
          emit(SearchLoaded(2, [...state.characters, ...data.results]));
        }
      } catch (e) {
        emit(SearchError(msg: e.toString()));
      }
    });
    on<LoadMore>((event, emit) async {
      if (!isMore) return;
      try {
        final data = await service.searchCharacter(query, state.page);

        if (data != null) {
          emit(SearchLoaded(
              data.info.next.isNotEmpty ? state.page + 1 : state.page,
              state.characters + data.results));

          isMore = data.info.next.isNotEmpty;
        }
      } catch (e) {
        emit(SearchError(msg: e.toString()));
      }
    });
  }
}
