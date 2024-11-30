import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r_muslim/models/detail_surah_model.dart';
import 'package:r_muslim/services/surah_api_services.dart';

part 'detail_surah_event.dart';
part 'detail_surah_state.dart';

class DetailSurahBloc extends Bloc<DetailSurahEvent, DetailSurahState> {
  final SurahApiServices _surahApiServices;

  DetailSurahBloc(this._surahApiServices) : super(DetailSurahInitial()) {
    on<FetchDetailSurahEvent>((event, emit) async {
      try {
        emit(DetailSurahLoading());  

        final data = await _surahApiServices.fetchDetailSurah(event.id);

        emit(DetailSurahLoaded(data));   
      } catch (e) {
        emit(DetailSurahError("Terjadi kesalahan: $e")); 
      }
    });
  }
}
