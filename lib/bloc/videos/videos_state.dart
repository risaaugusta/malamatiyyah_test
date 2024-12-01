part of 'videos_bloc.dart';

abstract class VideosState {}

class VideosInitial extends VideosState {}

class VideosLoading extends VideosState {}

class VideosLoaded extends VideosState {
  final List<DataVideos> listEbooks;

  VideosLoaded(this.listEbooks);
}

class VideosError extends VideosState {
  final String errorMessage;

  VideosError(this.errorMessage);
}
