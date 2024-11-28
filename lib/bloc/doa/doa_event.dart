part of 'doa_bloc.dart';

abstract class DoaEvent {
  const DoaEvent();

  @override 
  List<Object> get props => [];
}

class DoaList extends DoaEvent {
  const DoaList();
}

class FetchDoaEvent extends DoaEvent {
  const FetchDoaEvent();

  @override
  List<Object> get props => [];
}
