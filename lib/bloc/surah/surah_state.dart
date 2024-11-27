part of 'surah_bloc.dart';

abstract class SurahState {}

class SurahInitial extends SurahState {}

class SurahLoading extends SurahState {}

class SurahLoaded extends SurahState {
  final List<DataListSurah> listSurah;

  SurahLoaded(this.listSurah);
}

class SurahError extends SurahState {
  final String errorMessage;

  SurahError(this.errorMessage);
}
