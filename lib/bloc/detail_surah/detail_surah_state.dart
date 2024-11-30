part of 'detail_surah_bloc.dart';

abstract class DetailSurahState {
  const DetailSurahState();

  @override
  List<Object> get props => [];
}

class DetailSurahInitial extends DetailSurahState {}

class DetailSurahLoading extends DetailSurahState {}

class DetailSurahLoaded extends DetailSurahState {
  final Data data;

  const DetailSurahLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class DetailSurahError extends DetailSurahState {
  final String message;

  const DetailSurahError(this.message);

  @override
  List<Object> get props => [message];
}
