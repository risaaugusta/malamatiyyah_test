part of 'ebooks_bloc.dart';

abstract class EbooksEvent {
  const EbooksEvent();

  @override
  // List<Object> get props => [];
  List<Object> get props => [];
}

class EbooksList extends EbooksEvent {
  const EbooksList();
}

class FetchEbooksEvent extends EbooksEvent {
  const FetchEbooksEvent();

  @override
  List<Object> get props => [];
}
