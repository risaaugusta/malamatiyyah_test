part of 'videos_bloc.dart';

abstract class VideosState {}

class VideosInitial extends VideosState {}

class VideosLoading extends VideosState {}

class VideosLoaded extends VideosState {
  final List<DataVideos> listVideos;

  VideosLoaded(this.listVideos);
}

class VideosError extends VideosState {
  final String errorMessage;

  VideosError(this.errorMessage);
}
