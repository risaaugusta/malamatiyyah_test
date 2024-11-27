import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:r_muslim/models/list_surah_model.dart';
import 'package:r_muslim/services/surah_api_services.dart'; 
part 'surah_event.dart';
part 'surah_state.dart';

class SurahBloc extends Bloc<SurahEvent, SurahState> {
  SurahBloc() : super(SurahInitial());

  @override
  Stream<SurahState> mapEventToState(SurahEvent event) async* {
    if (event is FetchSurahEvent) {
      yield SurahLoading();
      try {
        final List<DataListSurah> listSurat = await fetchAllSurat();

        if (listSurat.isNotEmpty) {
          yield SurahLoaded(listSurat);
        } else {
          yield SurahError("Tidak ada data surat.");
        }
      } catch (e) {
        yield SurahError("Terjadi kesalahan: $e");
      }
    }
  }
}