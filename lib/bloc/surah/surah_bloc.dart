import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r_muslim/models/list_surah_model.dart';
import 'package:r_muslim/services/surah_api_services.dart';

part 'surah_event.dart';
part 'surah_state.dart';

class SurahBloc extends Bloc<SurahEvent, SurahState> {
  final SurahApiServices _doaApiServices;

  SurahBloc(this._doaApiServices) : super(SurahInitial()) {
    on<FetchSurahEvent>((event, emit) async {
      try {
        emit(SurahLoading());
        final List<DataListSurah> listSurah = await _doaApiServices.fetchAllSurat();

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
