part of 'videos_bloc.dart';

abstract class VideosEvent {
  const VideosEvent();

  @override 
  List<Object> get props => [];
}

class VideosList extends VideosEvent {
  const VideosList();
}

class FetchVideosEvent extends VideosEvent {
  const FetchVideosEvent();

  @override
  List<Object> get props => [];
}
