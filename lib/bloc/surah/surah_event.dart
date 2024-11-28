part of 'surah_bloc.dart';

abstract class SurahEvent {
  const SurahEvent();

  @override
  // List<Object> get props => [];
  List<Object> get props => [];
}

class SurahList extends SurahEvent {
  const SurahList();
}

class FetchSurahEvent extends SurahEvent {
  const FetchSurahEvent();

  @override
  List<Object> get props => [];
}
