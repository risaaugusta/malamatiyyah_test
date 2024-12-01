import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r_muslim/models/videos_model.dart';
import 'package:r_muslim/services/videos_api_services.dart';

part 'videos_event.dart';
part 'videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  final VideosApiServices _videosApiServices;

  VideosBloc(this._videosApiServices) : super(VideosInitial()) {
    on<FetchVideosEvent>((event, emit) async {
      try {
        emit(VideosLoading());
        final List<DataVideos> listVideos = await _videosApiServices.fetchAllVideos();

        if (listVideos.isNotEmpty) {
          emit(VideosLoaded(listVideos));
        } else {
          emit(VideosError("Tidak ada data"));
        }
      } catch (e) {
        emit(VideosError("Terjadi kesalahan: $e"));
      }
    });
  }
}
