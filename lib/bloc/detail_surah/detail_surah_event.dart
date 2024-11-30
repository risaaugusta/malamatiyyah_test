part of 'detail_surah_bloc.dart';

abstract class DetailSurahEvent  {
  const DetailSurahEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailSurahEvent extends DetailSurahEvent {
  final int id;

  const FetchDetailSurahEvent(this.id);

  @override
  List<Object> get props => [id];
}