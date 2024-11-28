part of 'doa_bloc.dart';

abstract class DoaState {}

class DoaInitial extends DoaState {}

class DoaLoading extends DoaState {}

class DoaLoaded extends DoaState {
  final List<DoaModel> listDoa;

  DoaLoaded(this.listDoa);
}

class DoaError extends DoaState {
  final String errorMessage;

  DoaError(this.errorMessage);
}
