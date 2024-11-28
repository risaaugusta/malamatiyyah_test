import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:r_muslim/models/doa_model.dart';
import 'package:r_muslim/services/doa_api_services.dart';

part 'doa_event.dart';
part 'doa_state.dart';

class DoaBloc extends Bloc<DoaEvent, DoaState> {
  final DoaApiServices _doaApiServices;

  DoaBloc(this._doaApiServices) : super(DoaInitial()) {
    on<FetchDoaEvent>((event, emit) async {
      try {
        emit(DoaLoading());
        final List<DoaModel> listDoa = await _doaApiServices.fetchAllDoa();

        if (listDoa.isNotEmpty) {
          emit(DoaLoaded(listDoa));
        } else {
          emit(DoaError("Tidak ada data"));
        }
      } catch (e) {
        emit(DoaError("Terjadi kesalahan: $e"));
      }
    });
  }
}
