import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r_muslim/models/list_surah_model.dart';
import 'package:r_muslim/services/surah_api_services.dart';

part 'surah_event.dart';
part 'surah_state.dart';

class SurahBloc extends Bloc<SurahEvent, SurahState> {
  final SurahApiServices _surahApiServices;

  SurahBloc(this._surahApiServices) : super(SurahInitial()) {
    on<FetchSurahEvent>((event, emit) async {
      try {
        emit(SurahLoading());
        final List<DataListSurah> listSurah = await _surahApiServices.fetchAllSurat();

        if (listSurah.isNotEmpty) {
          emit(SurahLoaded(listSurah));
        } else {
          emit(SurahError("Tidak ada data"));
        }
      } catch (e) {
        emit(SurahError("Terjadi kesalahan: $e"));
      }
    });
  }
}
