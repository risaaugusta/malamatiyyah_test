import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r_muslim/models/ebooks_model.dart';
import 'package:r_muslim/services/ebooks_api_services.dart';

part 'ebooks_event.dart';
part 'ebooks_state.dart';

class EbooksBloc extends Bloc<EbooksEvent, EbooksState> {
  final EbooksApiServices _ebooksApiServices;

  EbooksBloc(this._ebooksApiServices) : super(EbooksInitial()) {
    on<FetchEbooksEvent>((event, emit) async {
      try {
        emit(EbooksLoading());
        final List<DataEbooks> listEbooks = await _ebooksApiServices.fetchAllEbooks();

        if (listEbooks.isNotEmpty) {
          emit(EbooksLoaded(listEbooks));
        } else {
          emit(EbooksError("Tidak ada data"));
        }
      } catch (e) {
        emit(EbooksError("Terjadi kesalahan: $e"));
      }
    });
  }
}
